abstract class Stat {
  String? id;
}

abstract class DocumentCountStat implements Stat {
  num? users;
  num? hosts;
  num? permissions;
  num? questionnaires;
  num? questions;
  num? roles;
  num? courses;
}
