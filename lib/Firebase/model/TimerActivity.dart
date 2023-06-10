import 'package:mobile/Firebase/model/referencedata/RefData.dart';
import 'base/FirestoreDocument.dart';

class TimerActivity extends FirestoreDocument {
  String? id;
  String? type;
  String? sessionTime;
  var timestamp;

  TimerActivity.fromSnapshot(Map<String, dynamic> snapshot, [String? id])
      : this.id = id,
        type = snapshot['type'],
        sessionTime = snapshot['sessionTime'],
        timestamp = snapshot['timestamp'],
        super.fromSnapshot(snapshot, id);
}
