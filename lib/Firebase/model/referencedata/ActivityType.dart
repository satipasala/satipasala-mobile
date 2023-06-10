import "RefData.dart" show RefData;

class ActivityType extends RefData {
  String description;
  String? active;
  String? name;
  dynamic type;
  dynamic contentType;

  ActivityType.fromSnapshot(Map<String, dynamic> snapshot,String? id)
      : description = snapshot['description'],
        active = snapshot['active'],
        name = snapshot['name'],
        type = snapshot['type'],
        contentType = snapshot['contentType'],
        super.fromSnapshot(snapshot,id);
}
