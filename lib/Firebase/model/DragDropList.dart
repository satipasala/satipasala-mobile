import "DragDropListItem.dart" show DragDropListItem;
import "fields/FireArrayField.dart" show FireArrayField;

abstract class DragDropList<T extends DragDropListItem> {
  String? id;
  String? name;
  num? cols;
  num? rows;
  String? color;
  FireArrayField<T>? list;
}
