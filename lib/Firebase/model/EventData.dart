import 'dart:collection';

import 'package:mobile/Firebase/model/Program.dart';
import 'package:mobile/Firebase/model/base/FirestoreDocument.dart';
import 'base/FirestoreDocument.dart';

class EventData extends FirestoreDocument {
  String? id;
  String title;
  String type;
  String description;
  String createdBy;
  var startDate;
  dynamic participation;
  var imgUrls;
  EventData.fromSnapshot(Map<String, dynamic> snapshot, [String? id])
      : this.id = id,
        title = snapshot['title'].trim(),
        type = snapshot['type'],
        description = snapshot['description'],
        createdBy = snapshot['createdBy'],
        startDate = snapshot['date'],
        imgUrls = snapshot['imgUrls'],
        participation = snapshot['participation'],
        super.fromSnapshot(snapshot, id);
}
