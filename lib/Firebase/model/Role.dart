import 'package:mobile/Firebase/model/Host.dart';

import "PermissionLevelGroup.dart" show PermissionLevelGroup;
import "RoleLevel.dart" show RoleLevel;
import './base/FirestoreDocument.dart';

class Role extends FirestoreDocument {
  String name;
  bool isActive;
  dynamic /* Date | null */ createdAt;
  dynamic /* Date | null */ updatedAt;
  String? description;
  Map<String, dynamic> courses;
  Map<String, dynamic> allowedOrgTypes;
  Map<String, dynamic> allowedPermissions;
  RoleLevel roleLevel;
  PermissionLevelGroup permissionLevelGroup;

  Role.fromSnapshot(Map<String, dynamic> snapshot, String? id)
      : name = snapshot['name'],
        isActive = snapshot['isActive'],
        createdAt = snapshot['createdAt'],
        updatedAt = snapshot['updatedAt'],
        description = snapshot['description'],
        courses = snapshot['courses'],
        allowedOrgTypes = snapshot['allowedOrgTypes'],
        allowedPermissions = snapshot['allowedPermissions'],
        roleLevel = RoleLevel.fromSnapshot(snapshot['roleLevel'],id),
        permissionLevelGroup =
            PermissionLevelGroup.fromSnapshot(snapshot['permissionLevelGroup'],id),
        super.fromSnapshot(snapshot,id);
}
