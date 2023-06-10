import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './model/User.dart' as firestore_user;
import 'UsersService.dart';
import 'model/MediaFiles.dart';

abstract class BaseAuth {
  Future<UserCredential> signInWithGoogle();

  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class AuthService implements BaseAuth {
  final FirebaseAuth _firebaseAuth;
  UsersService? _usersService;
  FirebaseStorage storage = FirebaseStorage.instance;

  AuthService(this._firebaseAuth) {
    this._usersService = UsersService();
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> getDefaultMediaPath(MediaFiles? mediaFiles) async {
    /*if (mediaFiles == null || mediaFiles.defaultMedia == null) {
      completer.complete(defaultPath);
    } else if (mediaFiles.defaultMedia['link'].trim()
        .startsWith('https://')) {
      completer.complete(mediaFiles.defaultMedia['link'].trim());
    } else {
      this.storage.ref(mediaFiles.defaultMedia['link'].trim()).getDownloadURL()
          .then((result) => {
        completer.complete(result)
      });
    }*/
    String result = "";
    if (mediaFiles != null && mediaFiles.defaultMedia != null) {
      result = await this.storage.ref(mediaFiles.defaultMedia['link'].trim()).getDownloadURL();
    }
    return result;
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      return Future.error(this.getMessageFromErrorCode(error));
    }
    // Once signed in, return the UserCredential
  }

  Future<String> signIn(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user!.uid;
    } catch (error) {
      return Future.error(this.getMessageFromErrorCode(error));
    }
  }

  String getMessageFromErrorCode(error) {
    switch (error.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
        break;
      case "sign_in_failed":
        return "Failed to login with Google.";
        break;
      default:
        return "Login failed. Please try again.";
        break;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user!.uid;
    } catch (error) {
      return Future.error(this.getMessageFromErrorCode(error));
    }
  }

  Future<User> getCurrentUser() async {
    User? user = _firebaseAuth.currentUser;
    return user!;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;
    user?.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User? user = _firebaseAuth.currentUser;
    return user!.emailVerified;
  }

  Future<firestore_user.User> getCurrentDbUser() async {
    Completer<firestore_user.User> completer =
        new Completer<firestore_user.User>();
    Stream<User?> stream = _firebaseAuth.authStateChanges();
    stream.forEach((user) {
      if (user != null) {
        var newUser = this._usersService?.get(user.email);
        newUser?.forEach((temp) {
          if (user != null && !completer.isCompleted) {
            completer.complete(temp);
          }
        });
      }
    });
    // for (User loggedInUser in stream) {
    //   if (loggedInUser == null) {
    //     completer.complete(null);
    //   } else {
    //     await for (firestore_user.User user
    //         in this._usersService.get(loggedInUser.email)) {
    //       if (user != null) {
    //         completer.complete(user);
    //         break;
    //       }
    //     }
    //   }
    // }
    return completer.future;
  }
}
