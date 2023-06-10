import "../country/Language.dart" show Language;
import "RefData.dart" show RefData;

abstract class Country implements RefData {
  String? id;
  String? name;
  String? native;
  String? active;
  String? phone;
  String? capital;
  String? currency;
  String? emoji;
  String? emojiU;
  String? continent;
  String? shortName;
  List<Language>? languages;
}
