import 'dart:collection';

import 'package:mobile/Firebase/model/Program.dart';
import 'package:mobile/Firebase/model/base/FirestoreDocument.dart';
import 'base/FirestoreDocument.dart';

class EventSession extends FirestoreDocument {
  String? id;
  String name;
  String eventId;
  var startDate;
  String? startTime;
  dynamic status;
  Program program;
  dynamic participation;
  var imgUrls;
  EventSession.fromSnapshot(Map<String, dynamic> snapshot, [String? id])
      : this.id = id,
        eventId = snapshot['eventId'],
        name = snapshot['name'].trim(),
        startDate = snapshot['startDate'],
        imgUrls = snapshot['imgUrls'],
        status = snapshot['status'],
        program = Program.fromSnapshot(snapshot['program'],id),
        participation = snapshot['participation'],
        super.fromSnapshot(snapshot, id);
}
