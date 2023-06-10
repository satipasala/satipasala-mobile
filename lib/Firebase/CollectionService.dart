import "dart:async";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile/Firebase/model/base/FirestoreDocument.dart';

import 'Firebase.dart';
import 'model/MediaFiles.dart';

typedef Query QueryFn(Query ref);
typedef T? FromSnapshot<T extends FirestoreDocument>(Map<String, dynamic> snapshot, [String? id]);


/// https://github.com/dart-lang/language/issues/356 T.fromSnapshot cannot be called yet.

class CollectionService<T extends FirestoreDocument> {
  bool reachedEnd = false;
  QueryDocumentSnapshot? lastDoc;
  String collection;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FromSnapshot fromSnapshot;

  CollectionService(this.collection, this.fromSnapshot);

  bool loading = false;

  setCollection(String collectionName) {
    this.collection = collectionName;
  }

  Future<DocumentReference> add(doc) {
    return this.fireStore.collection(this.collection).add(doc);
  }

  //todo generify component and remove any
  Future addWithId(doc) {
    return this.fireStore.collection(this.collection).doc(doc.id).set(doc);
  }

  Future update(String? id, doc) {
    return this.fireStore.collection(this.collection).doc(id).update(doc);
  }

  Future delete(id) {
    return this.fireStore.collection(this.collection).doc(id).delete();
  }

  /**
   * get the collection reference of given collection name.
   */
  Stream<T> get(String? documentId) {
    /*return getCollectionRef(queryFn)
        .doc(documentId)
        .snapshots()
        .handleError((e) => FlutterError.dumpErrorToConsole(e))
        .map((event) => this.getDocumentData(event));*/

    return this
        .fireStore
        .collection(this.collection)
        .doc(documentId)
        .snapshots()
        .handleError((e) => FlutterError.dumpErrorToConsole(e))
        .map((event) => this.getDocumentData(event)) ;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDoc(String? documentId) {
    return this
        .fireStore
        .collection(this.collection)
        .doc(documentId)
        .snapshots()
        .map((event) => event)
        .handleError((e) => FlutterError.dumpErrorToConsole(e));
  }

  T getDocumentData(DocumentSnapshot payload) {
     //this.lastDoc = payload
    return fromSnapshot(payload.data() as Map<String, dynamic> , payload.id) as T;
  }

  Query getCollectionRef(QueryFn queryFn) {
    Query collectionRef;
    if (queryFn != null) {
      collectionRef = queryFn(this.fireStore.collection(this.collection));
    } else {
      collectionRef = this.fireStore.collection(this.collection);
    }

    return collectionRef;
  }

  /**
   * get a sumb collection of main collection
   */
  Stream<List<T>> queryCollection(QueryFn queryFn) {
    return this.onSnapshotChanges(getCollectionRef(queryFn));
  }

  Stream<List<T>> onSnapshotChanges(Query collection) {
    this.loading = true;
    return collection.snapshots()
    //.handleError((e) => FlutterError.dumpErrorToConsole(e))
        .map((QuerySnapshot<Object?> snapshot) {
      return snapshot.docs.map<T>((QueryDocumentSnapshot document) {
        this.lastDoc = document;
        this.loading = false;
        return fromSnapshot(document.data() as Map<String, dynamic>, document.id) as T;
      }).toList();
    });
  }

  Stream<List<T>> querySubCollection(QueryFn queryFn,
      [List<SubCollectionInfo>? subCollectionPaths]) {
    Query? collection;
    if (subCollectionPaths != null && subCollectionPaths.length > 0) {
      for (var i = 0; i < subCollectionPaths.length; i++) {
        if (collection != null) {
          collection =
              this.getSubCollection(collection as CollectionReference<Object?>, subCollectionPaths[i], queryFn);
        } else {
          collection = this.getSubCollection(
              this.fireStore.collection(this.collection),
              subCollectionPaths[i],
              queryFn);
        }
      }
    } else {
      collection = getCollectionRef(queryFn);
    }
    return this.onSnapshotChanges(collection!);
  }

  /**
   * get a sub collection from a given collection
   *
   *
   */
  Query<Object?> getSubCollection(CollectionReference collection,
      SubCollectionInfo subCollection,
      [QueryFn? queryFn]) {
    if (queryFn != null) {
      return queryFn(collection
          .doc(subCollection.documentId)
          .collection(subCollection.subCollection));
    } else {
      return collection
          .doc(subCollection.documentId)
          .collection(subCollection.subCollection);
    }
  }

/*  */ /**
        * get data from document change action.
        *
        */ /*
  T getPayload(DocumentChangeAction<DocumentData> action) {
    if (action.payload != null) {
      final T data =;
      data [ "id" ] =;
      //  this.lastObj = data

      //return this.lastObj;
      this.lastDoc = action.payload.doc;
      return data;
    } else {
      final T u1 = null;
      return u1;
    }
  }*/

/*
  */ /**
      * Return all documents in the collection
      *
      */ /*
  Observable<List <T>> getAll() {
    console.warn(
        "**Important** Getting all documents are very costly.Should be removed ASAP.collection:",
        this.collectionName);
    return this.fireStore.collection */ /*< T >*/ /*(this.collection).valueChanges();
  }

  Future setDoc(id, T doc) {
    return this.fireStore.collection(this.collection).doc(id).set(doc);
  }*/
}
