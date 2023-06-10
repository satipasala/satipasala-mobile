import "Types.dart" show LandType;
import "../referencedata/State.dart" show State;
import "../base/FirestoreDocument.dart";
abstract class Province implements ProvinceInfo {
  num? locationCount;
  List<State>? districts;
}

abstract class ProvinceInfo implements FirestoreDocument{
  String? id;
  String? name;
  LandType? type;
}
