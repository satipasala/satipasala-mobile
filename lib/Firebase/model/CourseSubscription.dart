import "Location.dart" show LocationInfo;
import "Host.dart" show HostInfo;
import "User.dart" show UserInfo;
import "Course.dart" show Course;

abstract class CourseSubscription {
  String? id;
  UserInfo? userInfo;
  UserInfo? teacherInfo;
  LocationInfo? locationInfo;
  HostInfo? hostInfo;
  Course? course;
}
