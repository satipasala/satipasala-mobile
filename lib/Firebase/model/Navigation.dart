import "NavigationItem.dart" show NavigationItem;

class Navigation {
  String? categoryName;
  String? icon;
  bool? dropDown;
  List<NavigationItem>? subCategory;
  String? categoryLink;
  bool? isActive;
  Navigation(String? _categoryName, String? _icon, bool _dropDown,
      [String? categoryLink = "", List<NavigationItem>? _subCategory]) {
    this.categoryName = _categoryName;
    this.icon = _icon;
    this.dropDown = _dropDown;
    this.subCategory = _subCategory;
    this.categoryLink = categoryLink;
    this.isActive = false;
  }
}
