import 'package:mobile/Firebase/model/Course.dart';

import 'referencedata/RefData.dart' show RefData;

class Program extends RefData {
  String? id;
  String? name;
  String? description;

  // List<Activity> activities;
  List<Course> courses;

  // num facilitatorsCount;
  // num feedbackCollectionCount;
  // List<FeedbackForm> feedbackForms;
  Program.fromSnapshot(Map<String, dynamic> snapshot,String? id)
      : id = snapshot['id'],
        courses = snapshot['courses'].values.map((e) => Course.fromSnapshot(e)).toList().cast<Course>(),
        super.fromSnapshot(snapshot,id);
}
