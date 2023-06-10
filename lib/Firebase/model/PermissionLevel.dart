import "referencedata/RefData.dart" show RefData;

class PermissionLevel extends RefData {
  String? id;
  String? name;
  num? access_level;
  String? description;
  dynamic /* Date | null */ createdAt;
  dynamic /* Date | null */ updatedAt;
  String? active;

  PermissionLevel.fromSnapshot(Map<String, dynamic> snapshot,String? id) : super.fromSnapshot(snapshot,id);
}
