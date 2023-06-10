import "RefData.dart" show RefData;
import "LocationType.dart" show LocationType;

abstract class OrganizationType implements RefData {
  String? description;
  String? active;
  String? name;
  List<LocationType>? locations;
}
