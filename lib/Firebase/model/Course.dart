import 'MediaFiles.dart';
import "Questionnaire.dart" show Questionnaire;
import "Location.dart" show Location;
import "Host.dart" show Host;
import "Activity.dart" show Activity;
import "User.dart" show UserInfo;
import 'base/FirestoreDocument.dart';

class Course extends CourseInfo {
  num? facilitatorsCount;
  num? numberOfFeedback;
  Questionnaire? questionnaire;
  Location? location;
  Host? organization;
  UserInfo? /* UserInfo | null */ teacherInfo;
  Course.fromSnapshot(Map<String, dynamic> snapshot, [String? id])
      :  super.fromSnapshot(snapshot,id);
}

class CourseInfo extends FirestoreDocument {
  String? id;
  String name;
  String? description;
  String? endDate;
  String? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic? /*  "started" | "completed" | "notstarted" | "rejected" */ status;
  FirestoreDocument? feedbacks; //object key is user.uid+"_"+course.id+"_"+occurrence.number;
  bool? mandatory;
  dynamic activities;
  MediaFiles? mediaFiles;
  CourseInfo.fromSnapshot(Map<String, dynamic> snapshot, [String? id])
      : id = snapshot['id'],
        name = snapshot['name'],
        description = snapshot['description'],
        endDate = snapshot['endDate'],
        createdAt = snapshot['createdAt'],
        activities = snapshot['activities'],
        updatedAt = snapshot['updatedAt'],
        active = snapshot['active'],
        mediaFiles = MediaFiles.fromSnapshot(snapshot['mediaFiles'] ?? {}, id),
        super.fromSnapshot(snapshot,id);
}
