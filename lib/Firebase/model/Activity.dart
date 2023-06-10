import "referencedata/ActivityType.dart" show ActivityType;
import 'package:mobile/Firebase/model/referencedata/RefData.dart';
import 'base/FirestoreDocument.dart';

class Activity extends FirestoreDocument {
  String? id;
  String name;
  String? active;
  String? description;
  ActivityType? type;
  num? maxPoints;
  dynamic? contentType;
  String? gradable;
  dynamic resource;
  dynamic mediaFiles;

  Activity.fromSnapshot(Map<String, dynamic> snapshot, [String? id])
      : this.id = id,
        name = snapshot['name'],
        active = snapshot['active'],
        description = snapshot['description'],
        resource = snapshot['resource'],
        mediaFiles = snapshot['mediaFiles'],
        type = ActivityType.fromSnapshot(snapshot['type'],id),
        super.fromSnapshot(snapshot, id);
}
