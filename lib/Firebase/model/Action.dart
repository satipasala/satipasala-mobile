import "referencedata/ActivityType.dart" show ActivityType;
import 'package:mobile/Firebase/model/referencedata/RefData.dart';
import 'base/FirestoreDocument.dart';
import 'User.dart';

class UserAction extends FirestoreDocument {
  String? id;
  String? actionType;
  String? date;
  User user;
  dynamic record;

  UserAction.fromSnapshot(Map<String, dynamic> snapshot, [String? id])
      : this.id = id,
        actionType = snapshot['actionType'],
        date = snapshot['date'],
        user = User.fromSnapshot(snapshot['user']),
        record = snapshot['record'],
        super.fromSnapshot(snapshot, id);
}
