import "RefData.dart" show RefData;

abstract class Language implements RefData {
  String? id;
  String? name;
  String? native;
  String? shortName;
  String? active;
  String? description;
}
