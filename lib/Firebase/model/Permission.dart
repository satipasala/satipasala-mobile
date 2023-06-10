import "referencedata/RefData.dart" show RefData;

 class Permission extends RefData {
  String? id;
  String? name;
  String? description;
  dynamic /* Date | null */ createdAt;
  dynamic /* Date | null */ updatedAt;
  dynamic /* dynamic | null */ types;
  bool? disabled;
  bool? edit;
  bool? view;
  String? active;

  Permission.fromSnapshot(Map<String, dynamic> snapshot,String? id) : super.fromSnapshot(snapshot,id);
}
