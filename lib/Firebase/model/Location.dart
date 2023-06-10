import "Course.dart" show Course;
import "User.dart" show UserInfo;
import "referencedata/LocationType.dart" show LocationType;

//for de normalizing purpose
abstract class LocationInfo {
  String? id;
  String? hostId;
  String? hostName;
  String? name;
  String? description;
}

abstract class Location implements LocationInfo {
  // parentLocation:String? //: document Id of the parent location - Indexed",
  LocationType? locationType;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Course>? courses;
  List<UserInfo>? teachers;
  bool? isDisabled;
}
