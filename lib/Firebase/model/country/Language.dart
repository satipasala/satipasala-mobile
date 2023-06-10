import "../base/FirestoreDocument.dart";
abstract class Language implements FirestoreDocument{
  String? id;
  String? shortName;
  String? name;
  String? native;
}
