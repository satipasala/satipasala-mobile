import "Question.dart" show Question;
import 'base/FirestoreDocument.dart';

class Questionnaire extends FirestoreDocument {
  /*type:QuestionnaireType;*/
  String? name;
  String? id;
  FirestoreDocument? questions;
  List<String>? questionsIdArray;
  num? occurence;

  Questionnaire.fromSnapshot(Map<String, dynamic> snapshot,String? id) : super.fromSnapshot(snapshot,id);
}

enum QuestionnaireType { AGGRIGATED, INDIVIDUAL }
