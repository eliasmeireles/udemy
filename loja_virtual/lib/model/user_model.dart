import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String password,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    _notifyUserModelListeners(isLoading: true);

    _firebaseAuth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: password)
        .then((firebaseUser) {
      this.firebaseUser = firebaseUser;
      _saveUserData(userData);
      _notifyUserModelListeners();
      onSuccess();
    }).catchError((error) {
      _notifyUserModelListeners();
      onFail();
    });
  }

  Future signIn(
      {@required String email,
      @required String password,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    _notifyUserModelListeners(isLoading: true);

    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((firebaseUser) async {
      this.firebaseUser = firebaseUser;
      await _loadCurrentUser();
      _notifyUserModelListeners();
      onSuccess();
    }).catchError((error) {
      print(error);
      _notifyUserModelListeners();
      onFail();
    });
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = await _firebaseAuth.currentUser();
    }
    if (firebaseUser != null && userData["name"] == null) {
      DocumentSnapshot snapshot = await Firestore.instance
          .collection("users")
          .document(firebaseUser.uid)
          .get();
      userData = snapshot.data;
    }
    _notifyUserModelListeners();
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
    firebaseUser = null;
    notifyListeners();
  }

  void _notifyUserModelListeners({bool isLoading = false}) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void passwordRecover(String email) {
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

abstract class ModelResponse {
  void onSuccess({String title, String message});

  void onFail({String title, String message});
}
