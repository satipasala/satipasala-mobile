class CRUDPermission {
  late bool _hasView;
  late bool _hasEdit;

  bool get hasView => _hasView;
  bool get hasEdit => _hasEdit;

  set hasView(bool hasView) {
    _hasView = hasView;
  }

  set hasEdit(bool hasEdit) {
    _hasEdit = hasEdit;
  }

  CRUDPermission(bool hasView, bool hasEdit) {
    this.hasEdit = hasEdit;
    this.hasView = hasView;
  }
}
