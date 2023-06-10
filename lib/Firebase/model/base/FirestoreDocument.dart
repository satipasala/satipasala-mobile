import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreDocument{
  dynamic getProp(String key) => <String, dynamic>{

  }[key];
  String? id;
  FirestoreDocument.fromSnapshot(Map<String, dynamic> snapshot, this.id);
}
