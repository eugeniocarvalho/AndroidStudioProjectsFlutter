import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

//usuario atual

class UserModel extends Model {
  // isso serve pra nao ter que escrever 'FirebaseAuth.instance' o tempo todo
  FirebaseAuth _auth = FirebaseAuth.instance;

  //isso vai ser o usuario que estiver logado no momento, caso nao tenha é null
  FirebaseUser firebaseUser;

  //Esse map vai ter os dados mais importantes do usuario, ex: email, nome, etc
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData['email'], password: pass)
        .then((user) async {
      firebaseUser = user;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((deuRuim) {
      onFail();

      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {

    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then(
       (user){
         firebaseUser = user;

         onSuccess();
         isLoading = false;
         notifyListeners();

       }).catchError((e){
         onFail();
         isLoading = false;
         notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    //salvando os dados do usuario aqui na classe
    this.userData = userData;
    //salvando no firebase para que possa usar no futuro
    await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .setData(userData);
  }
}
