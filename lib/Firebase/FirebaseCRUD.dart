import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'PermissionService.dart';
import 'Firebase.dart';
import 'AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Firebase/model/CRUDPermission.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
var db = FirebaseFirestore.instance;
AuthService auth = new AuthService(_firebaseAuth);
PermissionsService _permissionsService = new PermissionsService(auth);

Future<bool> updateDocument(String collection) async {
  CRUDPermission permission =
      await _permissionsService.isRoleAuthorized(collection);
  if (permission.hasEdit == true) {
    return true;
  } else {
    return false;
  }
}
