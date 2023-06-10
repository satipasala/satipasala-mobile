
import "Location.dart" show LocationInfo;
import "AddressInfo.dart" show AddressInfo;
import "Host.dart" show HostInfo;
import "Role.dart" show Role;
import "TimerActivity.dart" show TimerActivity;
import "./base/FirestoreDocument.dart";

class User extends UserInfo {
  HostInfo? organizationInfo;
  dynamic /* String | null */ preferredMedium;
  bool? disabled;
  dynamic /* String | null */ createdAt;
  dynamic /* String | null */ updatedAt;
  Object courseSubscriptions;
  dynamic sessionSubscriptions;
  String? description;
  Role userRole;
  TimerActivity? timerActivity;
  Map<String, dynamic> snap;
  User.fromSnapshot(Map<String, dynamic> snapshot, [String? id])
      : organizationInfo = HostInfo.fromSnapshot(snapshot['organizationInfo']??{},id),
        preferredMedium = snapshot['preferredMedium'],
        courseSubscriptions = snapshot['courseSubscriptions'],
        sessionSubscriptions = snapshot['sessionSubscriptions'],
        userRole = Role.fromSnapshot(snapshot['userRole'],id),
        timerActivity = TimerActivity.fromSnapshot(Map<String, dynamic>.from(snapshot['timerActivity'] ?? {})),
        snap = snapshot,
        super.fromSnapshot(snapshot, id);
}

//abstract class UserInfo implements FirebaseAuth.User {
class UserInfo extends FirestoreDocument {
  String email;
  String displayName;
  String? emailVerified;
  String? isAnonymous;
  String? metadata;
  String? phoneNumber;
  String? photoURL;
  String? providerData;
  String? refreshToken;
  String? tenantId;
  String? uid;
  dynamic /* String | null */ userName;
  dynamic /* String | null */ firstName;
  dynamic /* String | null */ lastName;
  dynamic /* String | null */ dob;
  dynamic /* String | null */ nic;
  String? userRoleId;
  AddressInfo? addressInfo;
  HostInfo? organizationInfo;
  LocationInfo? locationInfo;

  UserInfo.fromSnapshot(Map<String, dynamic> snapshot, [String? id])
      : email = snapshot['email'],
        displayName = snapshot['displayName'],
        photoURL = snapshot['photoURL'],
        uid = snapshot['uid'],
        super.fromSnapshot(snapshot, id);
}
