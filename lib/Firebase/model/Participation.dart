import 'package:mobile/Firebase/model/base/FirestoreDocument.dart';

abstract class ParticipationInfo extends FirestoreDocument {
  dynamic /* num |  */ numberOfParticipants = 0;
  dynamic /* num |  */ numberOfAdults = 0;
  dynamic /* num |  */ numberOfChildren = 0;
  dynamic /* num |  */ numberOfMales = 0;
  dynamic /* num |  */ numberOfFemales = 0;

  ParticipationInfo.fromSnapshot(Map<String, dynamic> snapshot,String? id) : super.fromSnapshot(snapshot,id);
}
