import 'Firebase.dart';

abstract class DataSource<T> {
  /**
     * Connects a collection viewer (such as a data-table) to this data source. Note that
     * the stream provided will be accessed during change detection and should not directly change
     * values that are bound in template views.
     * @param collectionViewer The component that exposes a view over the data provided by this
     *     data source.
     * @returns Observable that emits a new value when the data changes.
     */
  Stream<List<T>> connect([CollectionViewer collectionViewer]);
  /**
     * Disconnects a collection viewer (such as a data-table) from this data source. Can be used
     * to perform any clean-up or tear-down operations when a view is being destroyed.
     *
     * @param collectionViewer The component that exposes a view over the data provided by this
     *     data source.
     */
  disconnect([CollectionViewer collectionViewer]);
}

abstract class SDataSource<T> implements DataSource<T> {
  bool reachedEnd();
  /**
   *  Called when the table is being destroyed. Use this function, to clean up
   * any open connections or free any held resources that were set up during connect.
   */
  void fetchData();
  nextBatch();
  setOrderBy(List<OrderBy> orderBy);
  addOrderBy(OrderBy orderBy);
  setFilterGroups(List<FilterGroup> filterGroups);
  setSearchFilters(List<SearchFilter> filters);
  removeFilterGroup(FilterGroup filterGroup, bool fireChanges);
  removeFilter(String groupName, Filter filter, bool fireChanges);
  removeSearchFilter(SearchFilter filter, bool fireChanges);
  accumulateFilterGroup(FilterGroup filterGroups);
  accumulateFilter(String groupName, Filter filter);
  accumulateSearchFilters(List<SearchFilter> filters);
  accumulateSearchFilter(SearchFilter filter);
  clearFilterGroup(FilterGroup filterGroup);
  clearSearchFilters(List<SearchFilter> filters);
  clearAllFilters();
  void setBatchSize(int batchSize);
}

/** Represents a range of numbers with a specified start and end. */
class ListRange {
  int start;
  int end;
  ListRange(this.start, this.end);
}

/**
  * Interface for any component that provides a view of some data collection and wants to provide
  * information regarding the view and any changes made.
  */
abstract class CollectionViewer {
  /**
  * A stream that emits whenever the `CollectionViewer` starts looking at a new portion of the
  * data. The `start` index is inclusive, while the `end` is exclusive.
  */
  late Stream<ListRange> viewChange;
}
