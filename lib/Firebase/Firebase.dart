// Import the firebase_core and cloud_firestore plugin

enum WhereFilterOp {
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
  arrayContains,
  arrayContainsAny,
  whereIn,
  whereNotIn,
  isNull
}

enum OrderByDirection { desc, asc }

class Filter {
    dynamic field;
    dynamic isEqualTo;
    dynamic isNotEqualTo;
    dynamic isLessThan;
    dynamic isLessThanOrEqualTo;
    dynamic isGreaterThan;
    dynamic isGreaterThanOrEqualTo;
    dynamic arrayContains;
    List<dynamic>? /*?*/ arrayContainsAny;
    List<dynamic>? /*?*/ whereIn;
    List<dynamic>? /*?*/ whereNotIn;
    bool? /*?*/ isNull;

  Filter(
    this.field, {
    this.isEqualTo,
    this.isNotEqualTo,
    this.isLessThan,
    this.isLessThanOrEqualTo,
    this.isGreaterThan,
    this.isGreaterThanOrEqualTo,
    this.arrayContains,
    this.arrayContainsAny,
    this.whereIn,
    this.whereNotIn,
    this.isNull,
  });

  
}

class FilterGroup {
  String key;
  List<Filter>? filters = [];

  FilterGroup(this.key, [this.filters]);
}

class OrderBy {
  String fieldPath;
  OrderByDirection directionStr;
  OrderBy(this.fieldPath, this.directionStr);
}

abstract class SearchFilter {
  String field;
  String value;
  SearchFilter(this.field, this.value);
}

abstract class SubCollectionInfo {
  String documentId;
  String subCollection;
  SubCollectionInfo(this.documentId, this.subCollection);
}
