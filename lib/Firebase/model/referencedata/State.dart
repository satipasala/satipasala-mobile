import "RefData.dart" show RefData;
import "Country.dart" show Country;

abstract class State implements StateInfo, RefData {
  String? id;
  String? name;
  String? shortName;
  Country? country;
  String? active;
  String? description;
}

abstract class StateInfo {
  String? id;
  String? name;
  String? shortName;
  String? description;
}
