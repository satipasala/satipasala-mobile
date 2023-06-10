import "referencedata/QuestionType.dart" show QuestionType;
import "fields/FormField.dart" show FormField;
import "referencedata/QuestionLabel.dart" show QuestionLabel;
import "Chip.dart" show Chip;

abstract class ScoringMechanism {
  String? id;
  String? name;
  String? description;
  dynamic /* | */ type;
}

abstract class Question<VALUE_TYPE> implements FormField<VALUE_TYPE> {
  String? description;
  QuestionType? questionType;
  List<QuestionLabel>? labels;
  ScoringMechanism? scoringMechanism;
  QuestionLevel? questionLevel;
}

abstract class QuestionLevel implements Chip {
  String? description;
}
