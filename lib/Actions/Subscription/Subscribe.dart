import 'dart:collection';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/Firebase/AuthService.dart';
import 'package:mobile/Firebase/UsersService.dart';
import 'package:mobile/Firebase/model/EventSession.dart';
import '../../Firebase/CollectionService.dart';
import '../../Firebase/model/User.dart' as dbUser;

CollectionService? _collectionService;
UsersService? _usersService;
AuthService? _authService;
FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
Future<void> SubscribeToAction(EventSession session, String id) async {
  try {
    _usersService = new UsersService();
    _authService = new AuthService(_firebaseAuth);
    dbUser.User _user = await _authService!.getCurrentDbUser();
    var userSnap = _user.snap;
    print(userSnap['sessionSubscriptions']);
    if (userSnap['sessionSubscriptions'] == null) {
      Map<String, dynamic> map = {'sessionSubscriptions': {}};
      userSnap.addAll(map);
    }
    userSnap['sessionSubscriptions'][session.id] = {
      'id': session.id,
      'eventId': session.eventId,
      'name': session.name,
    };

    _usersService!
        .update(id, userSnap)
        .onError((error, stackTrace) => throw (error) as Object);
  } catch (ex) {
    print(ex);
  }
}

Future<bool> IsSubbedToSession(EventSession session, String id) async {
  try {
    _usersService = new UsersService();
    _authService = new AuthService(_firebaseAuth);
    dbUser.User _user = await _authService!.getCurrentDbUser();
    var userSnap = _user.snap;
    print(userSnap['sessionSubscriptions']);
    if (userSnap['sessionSubscriptions'] == null) {
      return false;
    } else if (userSnap['sessionSubscriptions'][session.id] == null) {
      return false;
    } else {
      return true;
    }
  } catch (ex) {
    print(ex);
    return false;
  }
}
