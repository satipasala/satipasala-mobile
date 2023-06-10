import "Occurrence.dart" show Occurrence;
import "User.dart" show UserInfo;
import "Course.dart" show CourseInfo;
import "Questionnaire.dart" show Questionnaire;

abstract class Feedback {
  dynamic /* String | null */ id;
  String? subscriptionId;
  CourseInfo? courseInfo;
  UserInfo? userInfo;
  dynamic /* UserInfo | null */ teacherInfo;
  dynamic /* bool | null */ isMandatory;
  Questionnaire? feedback;
  Occurrence? occurrence;
  String? updatedAt;
  num? year;
}
