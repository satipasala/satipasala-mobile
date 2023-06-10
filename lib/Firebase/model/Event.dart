import 'package:mobile/Firebase/model/referencedata/RefData.dart';

import "Host.dart" show Host;
import "User.dart" show User;
import "AddressInfo.dart" show AddressInfo;
import "Participation.dart" show ParticipationInfo;
import "Course.dart" show Course;
import 'base/FirestoreDocument.dart';
import "referencedata/EventCategory.dart" show EventCategory;

class Event extends FirestoreDocument {
  String? id;
  String? name;
  dynamic /* bool |  */ disabled;
  List<String>? imgUrls;
  String? startDate;
  dynamic /* Date | null */ endDate;
  String? startTime;
  dynamic /* String | null */ endTime;
  dynamic /* String | null */ description;
  String? type;
  EventCategory? category;
  User? coordinatorInfo;
  String? phoneNumber;
  AddressInfo? addressInfo;
  ParticipationInfo? participants;
  Course? course;
  Host? host;
  FirestoreDocument? facilitators;

  Event.fromSnapshot(Map<String, dynamic> snapshot, [String? id])
      : this.id = id,
        name = snapshot['name'],
        coordinatorInfo = User.fromSnapshot(snapshot['coordinatorInfo']),
        host = Host.fromSnapshot(snapshot['host'],id),
        course = Course.fromSnapshot(snapshot['course']),
        startDate = snapshot['startDate'],
        // category = snapshot['category'],
        super.fromSnapshot(snapshot, id);
}
