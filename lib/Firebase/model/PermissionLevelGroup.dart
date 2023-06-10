import "PermissionLevel.dart" show PermissionLevel;
import './base/FirestoreDocument.dart';

 class PermissionLevelGroup extends FirestoreDocument {
  PermissionLevel? view;
  PermissionLevel? edit;

  PermissionLevelGroup.fromSnapshot(Map<String, dynamic> snapshot,String? id) : super.fromSnapshot(snapshot,id);

  dynamic getProp(String key) => <String, dynamic>{
    'view' : this.view,
    'edit':this.edit
  }[key];
}
