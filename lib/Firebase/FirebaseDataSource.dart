import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:rxdart/rxdart.dart';

import 'CollectionService.dart';
import 'Firebase.dart' as Firebase;
import 'SDataSource.dart';
import 'model/base/FirestoreDocument.dart';
/**
 * Data source for the HostInfoComponent view. This class should
 * encapsulate all logic for fetching and manipulating the displayed data
 * (including sorting, pagination, and filtering).
 */

typedef Query DataQuery(CollectionReference value);

class DataRequest {
  DataQuery query;
  List<Firebase.SubCollectionInfo>? subCollectionPaths;

  DataRequest(this.query, [this.subCollectionPaths]);
}

class PageEvent {
  /** The current page index. */
  int pageIndex;

  /**
   * Index of the page that was selected previously.
   * @breaking-change 8.0.0 To be made into a required property.
   */
  int previousPageIndex;

  /** The current page size */
  int pageSize;

  /** The current total number of items being paged */
  int length;

  PageEvent(this.pageSize,
      [this.pageIndex =0 , this.length = 10, this.previousPageIndex =0]);
}

class FirebaseDataSource<T extends FirestoreDocument> extends SDataSource<T> {
  int pageSize;

  late T lastObj;
  List<T> allDocuments = [];
  StreamController<List<T>> dataStream = StreamController<List<T>>();
  CollectionService<T> collectionService;

  //collection filters
  List<Firebase.FilterGroup> filterGroups = [];
  List<Firebase.SearchFilter> searchFilters = [];
  StreamController<bool> filterChangeStream = StreamController<bool>();
  List<Firebase.OrderBy> orderBy = [];
  int batchSize = 20;
  StreamController<DataRequest> dataRquestStream =
      StreamController<DataRequest>();

  ScrollController? scrollController;

  FirebaseDataSource(this.pageSize, this.collectionService,[this.scrollController]) : super() {
    this.batchSize = this.pageSize;
    /* super call moved to initializer */
    // wait for 1000 ms to send requests to server. avaoids unwanted server load
    this.dataRquestStream.stream.listen((value) {
      developer.log("request recieved value");
      this._requestData(value.query, value.subCollectionPaths);
    });
    this.filterChangeStream.stream.listen((value) {
      this.fetchData();
    });
    if(this.scrollController == null){
      this.scrollController  = ScrollController();
    }
    this.scrollController?.addListener(() {
      print("triggered");
      if (scrollController!.offset >=
          scrollController!.position.maxScrollExtent &&
          !scrollController!.position.outOfRange) {
        // "reach the bottom"
        this.nextBatch(); //todo fix this next batch call since its not efficient.
      }
      if (scrollController!.offset <=
          scrollController!.position.minScrollExtent &&
          !scrollController!.position.outOfRange) {
        // "reach the top";

      }
    });
  }


  bool reachedEnd() {
    return this.collectionService.reachedEnd;
  }

  /**
   * query data of a sub collection by giving documentId and sub collection name. this should never
   * be called directly in order to reduce number of server calls.
   *
   *
   */
  _requestData(DataQuery query, [List<Firebase.SubCollectionInfo>? subCollectionPaths]) {
    final List<Stream<List<T>>> observableList = [];
    if (this.searchFilters.length > 0) {
      this.searchFilters.forEach((searchFilter) {
        if (this.filterGroups.length > 0) {
          this.queryBySearchFiltersAndFilterGroup(
            observableList,
            query,
            searchFilter,
          );
        } else {
          this.queryBySearchFilters(
            observableList,
            query,
            searchFilter,
          );
        }
      });
    } else if (this.filterGroups.length > 0) {
      this.queryByFilterGroup(observableList, query, subCollectionPaths);
    } else {
      final QueryFn queryFnc = (ref) => query(this.addOrderByClauses(ref) as CollectionReference<Object?>);
      observableList.add(this
          .collectionService
          .querySubCollection(queryFnc, subCollectionPaths));
    }

    CombineLatestStream.list(observableList).listen((documentList) =>
        documentList.forEach((documents)  {
          allDocuments.addAll(documents);
          this.dataStream.add(allDocuments);
        }));
  }

  /**
   * query data method sends the query to data Stream .
   * equests are throttled and last request will be sent to the server
   *
   *
   */
  queryData(DataQuery query, [List<Firebase.SubCollectionInfo>? subCollectionPaths]) {
    this.dataRquestStream.add(DataRequest(query, subCollectionPaths));
  }

  queryBySearchFiltersAndFilterGroup(
      List<Stream<dynamic>> observableList, DataQuery query, searchFilter,
      [List<Firebase.SubCollectionInfo>? subCollectionPaths]) {
    this.filterGroups.forEach((filterGroup) {
      final QueryFn queryFnc = (ref) => query(this.addSearchWhereClause(
          this.addWhereClauses(filterGroup.filters,
              this.addSearchAndOrderByClauses(ref, searchFilter)),
          searchFilter) as CollectionReference );
      observableList.add(this.collectionService.querySubCollection(
            queryFnc,
          ));
    });
  }

  queryBySearchFilters(
      List<Stream<dynamic>> observableList, DataQuery query, searchFilter,
      [List<Firebase.SubCollectionInfo>? subCollectionPaths]) {
    final QueryFn queryFnc = (ref) => query(
      this.addSearchWhereClause(this.addSearchAndOrderByClauses(ref, searchFilter), searchFilter) as CollectionReference 
      );
    observableList.add(this.collectionService.querySubCollection(
          queryFnc,
        ));
  }

  queryByFilterGroup(List<Stream<dynamic>> observableList, DataQuery query,
      [List<Firebase.SubCollectionInfo>? subCollectionPaths]) {
    this.filterGroups.forEach((filterGroup) {
      final QueryFn queryFnc = (ref) => query(this.addWhereClauses(filterGroup.filters, this.addOrderByClauses(ref)) as CollectionReference);
      observableList.add(this
          .collectionService
          .querySubCollection(queryFnc, subCollectionPaths));
    });
  }

  /**
   * query data from multiple sub collections by giving documentId and sub collection name as rest parameters
   */
  queryCombinedData(
      QueryFn queryFn, List<List<Firebase.SubCollectionInfo>> subCollectionPaths) {
    for (var i = 0; i < subCollectionPaths.length; i++) {
      this.queryData(queryFn, subCollectionPaths[i]);
    }
  }

  /**
   * Connect this data source to the table. The table will only update when
   * the returned stream emits new items.
   *
   */
  Stream<List<T>> connect([CollectionViewer? collectionViewer]) {
    this.collectionService.lastDoc = null;
    return this.dataStream.stream;
  }

  /**
   *  Called when the table is being destroyed. Use this function, to clean up
   * any open connections or free any held resources that were set up during connect.
   */
  disconnect([CollectionViewer? collectionViewer]) {
    dataStream.close();
    dataRquestStream.close();
    filterChangeStream.close();
    scrollController?.dispose();
  }

  /**
   * load more data to collection using paginator
   *
   */
  loadMore(PageEvent event) {
    this.queryData((query) => query
        .startAfterDocument(this.collectionService.lastDoc as DocumentSnapshot<Object?>)
        .limit(event.pageSize));
  }

  void fetchData() {
    //todo add correct value to startAt() method
    if (this.pageSize != null) {
      this.queryData((query) => query.limit(this.pageSize));
    } else {
      this.queryData((query) => query.limit(this.batchSize));
    }
  }

  nextBatch() {
    if (this.collectionService.lastDoc != null) {
      this.queryData((query) => query
          .startAfterDocument(this.collectionService.lastDoc as DocumentSnapshot<Object?>)
          .limit(this.batchSize));
    } else {
      this.queryData((query) => query.limit(this.batchSize));
    }
  }

  setOrderBy(List<Firebase.OrderBy> orderBy) {
    this.orderBy = orderBy;
  }

  addOrderBy(Firebase.OrderBy orderBy) {
    this.orderBy.add(orderBy);
  }

  Firebase.OrderBy getDefaultOrderBy(Firebase.SearchFilter searchFilter) {
    final index = this
        .orderBy
        .indexWhere((orderBy) => orderBy.fieldPath == searchFilter.field);
    final newOrderBy = ({
      "fieldPath": searchFilter.field,
      "directionStr": Firebase.OrderByDirection.asc
    } as Firebase.OrderBy);
    if (index > -1) {
      final existingObject = this.orderBy.removeAt(index);
      newOrderBy.directionStr = existingObject.directionStr;
    }
    return newOrderBy;
  }

  Query addSearchAndOrderByClauses(Query query, Firebase.SearchFilter searchFilter) {
    final order = this.getDefaultOrderBy(searchFilter);
    return this.addOrderByClause(query, order);
  }

  Query addOrderByClauses(Query query) {
    this.orderBy.forEach((order) {
      query = this.addOrderByClause(query, order);
    });
    return query;
  }

  Query addOrderByClause(Query query, Firebase.OrderBy orderBy) {
    return query.orderBy(orderBy.fieldPath,
        descending: orderBy.directionStr == Firebase.OrderByDirection.desc);
  }

  Query addWhereClauses(List<Firebase.Filter>? filters, Query query) {
    filters?.forEach((filter) {
      query = this.addWhereClause(query, filter);
    });
    return query;
  }

  Query addWhereClause(Query query, Firebase.Filter? filter) {
    return query.where(filter!);
  }

  Query addSearchWhereClause(Query query, Firebase.SearchFilter filter) {
    //return query.where(filter.field, ">=", filter.value)
    return query
        .where(filter.field, isGreaterThanOrEqualTo: filter.value)
        .where(filter.field, isLessThan: filter.value + "z");
  }

  setFilterGroups(List<Firebase.FilterGroup> filterGroups) {
    this.filterGroups = [];
    this.filterGroups = filterGroups;
    this.filterChangeStream.add(true);
  }

  accumulateFilterGroup(Firebase.FilterGroup filterGroup) {
    filterGroup.filters?.forEach((filter) {
      this.removeFilter(filterGroup.key, filter, false);
      this.filterGroups.add(filterGroup);
    });
    this.filterChangeStream.add(true);
  }

  accumulateFilter(String groupName, Firebase.Filter filter) {
    this.removeFilter(groupName, filter, false);
    this.filterGroups.forEach((value) {
      if (value.key == groupName) {
        value.filters?.add(filter);
      }
    });
    this.filterChangeStream.add(true);
  }

  removeFilterGroup(Firebase.FilterGroup filterGroup, [bool fireChanges = true]) {
    final index =
        this.filterGroups.indexWhere((value) => (value.key == filterGroup.key));
    if (index != -1) {
      this.filterGroups.remove(index);
    }
    if (fireChanges == true) {
      this.filterChangeStream.add(false);
    }
  }

  removeFilter(String groupName, Firebase.Filter filter, [bool fireChanges = true]) {
    this.filterGroups.forEach((group) {
      if (group.key == groupName) {
        final index = group.filters?.indexWhere((value) => value == filter);
        if (index != -1) {
          group.filters?.remove(index);
        }
      }
    });
    if (fireChanges == true) {
      this.filterChangeStream.add(false);
    }
  }

  clearFilterGroup(Firebase.FilterGroup filterGroup) {
    filterGroup.filters?.forEach((filter) {
      this.removeFilter(filterGroup.key, filter, true);
    });
    this.filterChangeStream.add(true);
  }

  setSearchFilters(List<Firebase.SearchFilter> filters) {
    this.searchFilters = [];
    filters.forEach((filter) {
      this.searchFilters.add(filter);
    });
    this.filterChangeStream.add(true);
  }

  accumulateSearchFilters(List<Firebase.SearchFilter> filters) {
    filters.forEach((filter) {
      this.removeSearchFilter(filter, false);
      this.searchFilters.add(filter);
    });
    this.filterChangeStream.add(true);
  }

  accumulateSearchFilter(Firebase.SearchFilter filter) {
    this.removeSearchFilter(filter, false);
    this.searchFilters.add(filter);
    this.filterChangeStream.add(true);
  }

  removeSearchFilter(Firebase.SearchFilter filter, [bool fireChanges = true]) {
    final index =
        this.searchFilters.indexWhere((value) => (value.field == filter.field));
    if (index != -1) {
      this.searchFilters.remove(index);
    }
    if (fireChanges == true) {
      this.filterChangeStream.add(false);
    }
  }

  clearSearchFilters(List<Firebase.SearchFilter> filters) {
    filters.forEach((filter) {
      this.removeSearchFilter(filter, true);
    });
    this.filterChangeStream.add(true);
  }

  clearAllFilters() {
    final List<Firebase.FilterGroup> filterGroups = List.from(this.filterGroups);
    filterGroups.forEach((group) {
      this.removeFilterGroup(group, false);
    });
    final searchFilters = List.from(this.searchFilters);
    searchFilters.forEach((filter) {
      this.removeSearchFilter(filter, false);
    });
    this.filterChangeStream.add(true);
  }

  setBatchSize(int batchSize) {
    this.batchSize = batchSize;
  }

  isLoading(){
    return this.collectionService.loading;
  }
}
