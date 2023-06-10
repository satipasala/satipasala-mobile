import "Chip.dart" show Chip;
import "fields/FireArrayField.dart" show FireArrayField;

abstract class ChipList implements FireArrayField<Chip> {
  bool? stacked;
}
