import "RefData.dart" show RefData;

abstract class EventCategory implements RefData {
  String? id;
  String? name;
  String? active;
  String? description;

  EventCategory.fromSnapshot(Map<String?, dynamic> snapshot, [String? id])
      : name = snapshot['name'],
        active = snapshot['active'];
}
