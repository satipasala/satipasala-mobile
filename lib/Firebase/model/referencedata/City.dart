import "RefData.dart" show RefData;
import "Country.dart" show Country;
import "State.dart" show State;
import "GeoLocation.dart" show GeoLocation;

abstract class City implements CityInfo, RefData {
  String? id;
  String? active;
  String? name;
  GeoLocation? geoLocation;
  State? state;
  Country? country;
  String? description;
}

abstract class CityInfo {
  String? id;
  String? name;
  GeoLocation? geoLocation;
  String? description;
}
