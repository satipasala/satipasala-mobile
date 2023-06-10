import "Course.dart" show Course;
import "User.dart" show User;
import 'base/FirestoreDocument.dart';
import "referencedata/Language.dart" show Language;
import "referencedata/LocationType.dart" show LocationType;
import "referencedata/OrgnizationType.dart" show OrganizationType;
import "AddressInfo.dart" show AddressInfo;

//for de normalizing purpose
 class HostInfo extends FirestoreDocument{
  String? id;
  String? name;
  String? description;
  bool? disabled;
  OrganizationType? type;

  HostInfo.fromSnapshot(Map<String, dynamic> snapshot,String? id) : super.fromSnapshot(snapshot,id);
}

 class Host extends HostInfo {
  FirestoreDocument? locations;
  List<LocationType>? locationTypes;
  Language? medium;
  String? phone_number;
  String? business_reg_no;
  String? website;
  String? email;
  // Person In Charge
  String? personInChargeName;
  String? personInChargeDesignation;
  String? personInChargePhone;
  String? personInChargeEmail;
  // Primary coordinator
  String? coordinator1Name;
  String? coordinator1Designation;
  String? coordinator1Phone;
  String? coordinator1Email;
  // Secondary coordinator
  String? coordinator2Name;
  String? coordinator2Designation;
  String? coordinator2Phone;
  String? coordinator2Email;
  AddressInfo? addressInfo;
  List<Course>? courses;
  List<User>? teachers;

  Host.fromSnapshot(Map<String, dynamic> snapshot,String? id) : super.fromSnapshot(snapshot,id);
}
