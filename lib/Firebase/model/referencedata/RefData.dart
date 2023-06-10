import 'package:mobile/Firebase/model/base/FirestoreDocument.dart';

abstract class RefData extends FirestoreDocument {
  String? name;
  String? active;
 
  RefData.fromSnapshot(Map<String, dynamic> snapshot, String? id): super.fromSnapshot(snapshot, id);
}
