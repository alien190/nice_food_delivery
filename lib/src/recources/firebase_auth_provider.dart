import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'resources.dart';

class FirebaseAuthProvider implements AuthProvider {
  final BehaviorSubject<String> _authUserId = BehaviorSubject();

  static final _instance = FirebaseAuthProvider._internal();

  Stream<String> get authUserId => _authUserId.stream;

  FirebaseAuthProvider._internal() {
    _singIn();
  }

  factory FirebaseAuthProvider() => _instance;

  void _singIn() async {
    FirebaseUser curUser = await FirebaseAuth.instance.currentUser();
    if (curUser == null) {
      await FirebaseAuth.instance.signInAnonymously();
      curUser = await FirebaseAuth.instance.currentUser();
    }
    _authUserId.add(curUser.uid);
  }

  void dispose() {
    _authUserId.close();
  }
}
