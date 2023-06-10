import 'dart:developer' as developer;

import './CollectionService.dart';
import './FirebaseConstants.dart';
import './model/User.dart';

class UsersService extends CollectionService<User> {
  static String collectionName = "users";

  UsersService(): super(UsersService.collectionName,
            (snapshot, [id]) => User.fromSnapshot(snapshot, id)) {
    /* super call moved to initializer */
  }

  /**
   * return users under specific organization
   */
  getAllowedUsers(String orgType) {
    return this.queryCollection(
        (query) => query.where("organizationInfo", isEqualTo: orgType));
  }

  filterData(customfilters) {
    developer.log("filtering by quick filters " +
        customfilters.field +
        customfilters.criteria +
        customfilters.filtervalue);
    /*return new Promise((resolve, reject) {
      if (identical(customfilters.criteria, "")) reject();
      if (identical(customfilters.filtervalue, "")) reject();
      resolve(this
          .fireStore
          .collection(
              this.collection,
              (ref) => ref.where(customfilters.field, customfilters.criteria,
                  customfilters.filtervalue))
          .valueChanges());
    });*/
  }

  /**
   * Update photo URL
   */
  updatePhotoUrl(String photoUrl, User user) {
    user.photoURL = photoUrl;
    this.update(user.email, user);
  }

  /**
   * Load image from the given URL
   */
  Future<String> getPhotoUrl(User user) async {
    final String? imageUrl = user.photoURL;
    if (imageUrl != null && imageUrl.trim().isNotEmpty) {
      if (imageUrl.contains(FirebaseConstants.USER_IMAGE_FOLDER)) {
        return await this.getFileDownloadPath(
            imageUrl, FirebaseConstants.DEFAULT_USER_IMAGE);
      } else {
        return imageUrl;
      }
    } else {
      return FirebaseConstants.DEFAULT_USER_IMAGE;
    }
  }

  /**
   * Get download path from firebase storage service
   */
  Future<String> getFileDownloadPath(String urlPath, String defaultPath) async {
    return urlPath != null
        ? await this.storage.ref(urlPath).getDownloadURL()
        : defaultPath;
  }
}
