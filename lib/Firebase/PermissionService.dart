import "dart:async";
import 'dart:developer' as developer;

import 'package:mobile/Firebase/model/CRUDPermission.dart';

import 'AuthService.dart';
import 'Firebase.dart';
import 'model/User.dart';
import 'model/base/FirestoreDocument.dart';

class PermissionsService {
  AuthService authService;

  PermissionsService(this.authService);

  bool editAuthorization = false;

  //todo there is a limitation since only one value is filtered in the security rule.
  Future<List<FilterGroup>> getHostsFilters(dynamic mainPermission) async {
    final List<FilterGroup> filterBy = [];
    try {
      User user = await this.authService.getCurrentDbUser();
      final FilterGroup filtersGroup1 = new FilterGroup("default");
      final FilterGroup filtersGroup2 = new FilterGroup("assigned-host");
      if (user.userRole != null && user.userRole.permissionLevelGroup != null) {
        if (user.userRole.permissionLevelGroup.getProp(mainPermission).id ==
            "global") {
          filterBy.add(filtersGroup1);
        } else {
          if (user.addressInfo != null) {
            if (user.userRole.permissionLevelGroup.getProp(mainPermission).id ==
                "country") {
              filtersGroup1.filters?.add(Filter("addressInfo.country.id",
                  isEqualTo: user.addressInfo?.country?.id));
            } else if (user.userRole.permissionLevelGroup
                    .getProp(mainPermission)
                    .id ==
                "district") {
              filtersGroup1.filters?.add(Filter("addressInfo.state.id",
                  isEqualTo: user.addressInfo?.state?.id));
            } else if (user.userRole.permissionLevelGroup
                    .getProp(mainPermission)
                    .id ==
                "city") {
              filtersGroup1.filters?.add(Filter("addressInfo.city.id",
                  isEqualTo: user.addressInfo?.city?.id));
            }
          } else if (user.userRole.permissionLevelGroup
                      .getProp(mainPermission)
                      .id ==
                  "organization" &&
              user.organizationInfo != null) {
            filtersGroup1.filters?.add(Filter("id", isEqualTo: user.organizationInfo?.id));
          }
          filtersGroup1.filters?.add(Filter("type.name",
              whereIn: List.from(user.userRole.allowedOrgTypes.keys)));
          /**
           * user will always see the organization that assigned to user. it is treated as an OR query.
           * therefore separate filter group should be created.
           */
          if (user.organizationInfo != null) {
            filtersGroup2.filters?.add(Filter("id", isEqualTo: user.organizationInfo?.id));
            filterBy.add(filtersGroup2);
          }
          filterBy.add(filtersGroup1);
        }
      }
    } catch (e) {
      developer.log("Error getHostsFilters", error: e);
    }

    return filterBy;
  }

  Future<List<FilterGroup>> getUsersFilters(
      dynamic /* | */ mainPermission) async {
    final List<FilterGroup> filterBy = [];
    try {
      User user = await this.authService.getCurrentDbUser();
      final FilterGroup filtersGroup1 = new FilterGroup("default");
      if (user.userRole != null && user.userRole.permissionLevelGroup != null) {
        if (user.userRole.permissionLevelGroup.getProp(mainPermission).id ==
            "global") {
          filterBy.add(filtersGroup1);
        } else {
          if (user.addressInfo != null) {
            if (user.userRole.permissionLevelGroup.getProp(mainPermission).id ==
                "country") {
              filtersGroup1.filters?.add(Filter("addressInfo.country.id",
                  isEqualTo: user.addressInfo?.country?.id));
            } else if (user.userRole.permissionLevelGroup
                    .getProp(mainPermission)
                    .id ==
                "district") {
              filtersGroup1.filters?.add(Filter("addressInfo.state.id",
                  isEqualTo: user.addressInfo?.state?.id));
            } else if (user.userRole.permissionLevelGroup
                    .getProp(mainPermission)
                    .id ==
                "city") {
              filtersGroup1.filters?.add(Filter("addressInfo.city.id",
                  isEqualTo: user.addressInfo?.city?.id));
            }
          } else if (user.userRole.permissionLevelGroup
                      .getProp(mainPermission)
                      .id ==
                  "organization" &&
              user.organizationInfo != null) {
            filtersGroup1.filters?.add(Filter("organizationInfo.id",
                isEqualTo: user.organizationInfo?.id));
          }
          filtersGroup1.filters?.add(Filter("organizationInfo.type.name",
              whereIn: List.from(user.userRole.allowedOrgTypes.keys)));
          if (mainPermission == "edit") {
            filtersGroup1.filters?.add(Filter("userRole.roleLevel.access_level",
                isLessThan: user.userRole.roleLevel.access_level));
          }
          filterBy.add(filtersGroup1);
        }
      }
    } catch (e) {
      developer.log("Error getUsersFilters", error: e);
    }

    return filterBy;
  }

  Future<FirestoreDocument> getCurrentUserAccessLevel() async {
    try {
      User user = await this.authService.getCurrentDbUser();
      final accessLevel = user.userRole.roleLevel.access_level;
      final currentUser = user.email;
      return {'user': currentUser, 'access': accessLevel} as FirestoreDocument;
    } catch (e) {
      return {} as FirestoreDocument;
    }
  }

  /*Future<List <FilterGroup>> getUsersEditFilters(mainPermission) {
    return new Promise ((resolve, reject) {
      this.getUsersFilters("view").then((filterGroups) {
        this.authService.getCurrentDbUser().subscribe((user) {
          filterGroups.forEach((filterGroup) {
            filterGroup.filters.add(
                Filter( "userRole.roleLevel.access_level",
                opStr: "<",
                value: user.userRole.roleLevel.access_level);
          });
          resolve(filterGroups);
        }, (error) {
          reject(error);
        });
      })
      . catch ( ( reason ) { reject ( reason ) ; } );
    });
  }*/

  Future<List<FilterGroup>> getCourseFilters(
      dynamic /* | */ mainPermission) async {
    List<FilterGroup> filterBy = [];
    User user = await this.authService.getCurrentDbUser();
    if (user?.userRole?.permissionLevelGroup != null) {
      return filterBy;
    } else {
      return filterBy;
    }
  }

  Future<List<FilterGroup>> getEventFilters(
      dynamic /* | */ mainPermission) async {
    List<FilterGroup> filterBy = [];
    User user = await this.authService.getCurrentDbUser();
    if (user?.userRole?.permissionLevelGroup != null) {
      return filterBy;
    } else {
      return filterBy;
    }
  }

  Future<List<FilterGroup>> getQuestionnaireFilters(
      dynamic /* | */ mainPermission) async {
    List<FilterGroup> filterBy = [];
    User user = await this.authService.getCurrentDbUser();
    if (user?.userRole?.permissionLevelGroup != null) {
      return filterBy;
    } else {
      return filterBy;
    }
  }

  Future<List<FilterGroup>> getQuestionFilters(
      dynamic /* | */ mainPermission) async {
    List<FilterGroup> filterBy = [];
    User user = await this.authService.getCurrentDbUser();
    if (user?.userRole?.permissionLevelGroup != null) {
      return filterBy;
    } else {
      return filterBy;
    }
  }

  /*

  Future<List <FilterGroup>> getRolesFilters() {
    return new Promise ((resolve, reject) {
      final List <FilterGroup> filterBy = [];
      this.authService.getCurrentDbUser().subscribe((user) {
        final FilterGroup filtersGroup1 = new FilterGroup ("default");
        final FilterGroup filtersGroup2 = new FilterGroup ("assigned-role");
        if (user.userRole && user.userRole.roleLevel) {
          if (identical(user.userRole.roleLevel.id, "super_admin")) {
            filterBy.add(filtersGroup1);
          } else {
            filtersGroup1.filters.add(Filter( "roleLevel.access_level",
                opStr: "<=",
                value: user.userRole.roleLevel.access_level);
            */ /**
                  * user will always see the role that assigned to user. it is treated as an OR query.
                  * therefore separate filter group should be created.
                  */ /*
            filtersGroup2.filters.add(Filter( "roleLevel.id",
                opStr: "==",
                value: user.userRole.roleLevel.id);
            filterBy.add(filtersGroup2);
            filterBy.add(filtersGroup1);
          }
          resolve(filterBy);
        } else {
          reject("Invalid role");
        }
      }, (error) => reject(error));
    });
  }
*/
  //check authorization
  Future<CRUDPermission> isRoleAuthorized(String collectionName) async {
    CRUDPermission rolePermission = new CRUDPermission(false, false);
    User user = await this.authService.getCurrentDbUser();
    if (user.userRole.allowedPermissions[collectionName] != null) {
      rolePermission.hasView =
          user.userRole.allowedPermissions[collectionName]["view"];
      rolePermission.hasEdit =
          user.userRole.allowedPermissions[collectionName]["edit"];
    }
    return rolePermission;
  }
/*
  //user functions are identical to firestore rules
  Future<bool> isAuthorizedToEditUsers(mainPermission, targetUser,
      updatedTargetUser) {
    return new Promise ((resolve, reject) {
      this.authService.getCurrentDbUser().subscribe((user) {
        resolve(this.isAuthtorisedToUser(mainPermission, user, targetUser) &&
            this.isAuthtorisedToUser(mainPermission, user, updatedTargetUser) &&
            updatedTargetUser.email == targetUser.email &&
            updatedTargetUser.uid == targetUser.uid &&
            (user.userRole.roleLevel.access_level > targetUser.userRole
                ? . roleLevel ? . access_level || user . userRole . roleLevel . id == "super_admin" && user . email != updatedTargetUser . email || ( user . email == updatedTargetUser . email && user . userRole == updatedTargetUser . userRole)
                : :) );
      }, (error) {
        reject(error);
      });
    });
  }

  Future<bool> isAuthorizedToEditHosts(Host host) {
    return new Promise ((resolve, reject) {
      bool editable = false;
      this.authService.getCurrentDbUser().subscribe((user) {
        editable =
            user.userRole.permissionLevelGroup [ "edit" ].id == "global" ||
                (identical(user.userRole.permissionLevelGroup [ "edit" ].id,
                    "country") && identical(
                    host.addressInfo.city.state.country.id, user.addressInfo)
                    ? .city .state .country .id :) ||
                (user.userRole.permissionLevelGroup [ "edit" ].id ==
                    "district" && host.addressInfo
                    ? . city . state . id == user . addressInfo ? . city . state ? . id : : : ) ||
                (user.userRole.permissionLevelGroup [ "edit" ].id == "city" &&
                    host.addressInfo
                    ? . city ? . id == user . addressInfo ? . city ? .id : : : :) ||
                (user.userRole.permissionLevelGroup [ "edit" ].id ==
                    "organization" && user
                    ? identical(. organizationInfo .id, host .id)
                    :);
        resolve(editable);
      }, (error) => resolve(editable));
    });
  }

  isAuthorizedToCreateUsers(mainPermission, user, newUser) {
    return new Promise ((resolve, reject) {
      this.authService.getCurrentDbUser().subscribe((user) {
        resolve(this.isAuthtorisedToUser(mainPermission, user, newUser) &&
            user.userRole.roleLevel.access_level >= 30);
      }, (error) {
        reject(error);
      });
    });
  }

  isAuthtorisedToUser(mainPermission, user, targetUser) {
    return (user.userRole.isActive &&
        ((user.userRole.roleLevel.access_level > targetUser.userRole
            ? .roleLevel ? .access_level : :) ||
            user.userRole.roleLevel.id == "super_admin") && user.userRole
        .allowedPermissions [ "collection_users" ].getProp(mainPermission) &&
        (user.userRole.permissionLevelGroup.getProp(mainPermission).id == "global" ||
            user
            ? . organizationInfo . id == targetUser ? . organizationInfo ? . id || ( ( targetUser ? . organizationInfo ? && ( ( user . userRole . permissionLevelGroup.getProp(mainPermission) . id == "country" && user . addressInfo . country . id == targetUser . addressInfo . country .id) ||
        (user.userRole.permissionLevelGroup.getProp(mainPermission).id ==
            "district" &&
            user.addressInfo.state.id == targetUser.addressInfo.state.id) ||
        (user.userRole.permissionLevelGroup.getProp(mainPermission).id == "city" &&
            user.addressInfo.city.id == targetUser.addressInfo.city.id) ||
        (user.userRole.permissionLevelGroup.getProp(mainPermission).id ==
            "organization" && user.organizationInfo
            ? . id == targetUser . organizationInfo ? . id : : )) : : ) ) : : : ) ) || user .
    uid
    ==
    targetUser
    .
    uid;
  }

  Future<bool> isAuthorizedToRole(String collection,
      dynamic */ /* | */ /* mainPermission) {
    return new Promise ((resolve, reject) {
      this.authService.getCurrentDbUser().subscribe((user) {
        // if (user.userRole.roleLevel.id == 'super_admin' && user?.userRole?.allowedPermissions[collection][mainPermission]) {
        if (user.userRole.roleLevel.id == "super_admin") {
          resolve(true);
        } else {
          resolve(false);
        }
      }, (error) => reject(error));
    });
  }*/
}
