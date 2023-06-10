import "RefData.dart" show RefData;
import "../Types.dart" show AnswerType;
import "../fields/FormField.dart" show FormField;

abstract class QuestionType implements RefData, FormField<dynamic> {
  String? id;
  String? label;
  String? fieldType;
  AnswerType? answerType;
}
