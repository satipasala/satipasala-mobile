import "Validator.dart" show Validator;
import "FireArrayField.dart" show FireArrayField;
import "../ChipList.dart" show ChipList;
import "Option.dart" show Option;
import "../Types.dart" show FormFieldType;

abstract class FormField<T> {
  String? id;
  num? order;
  FormFieldType? type;
  String? name;
  String? label;
  bool? disabled;
  T? value;
  String? hint;
  FireArrayField<Validator>? validators;
  ChipList? formChipList;
  String? icon;
  List<Option<T>>? options;
  bool? checked;
  bool? indeterminate;
  String? labelPosition;
}
