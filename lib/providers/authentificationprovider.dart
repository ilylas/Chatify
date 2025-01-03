//packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../services/Database_service.dart';
import '../services/navigation_service.dart';

import 'package:chatify_app/models/chat_user.dart';


class AuthentificationProvider extends ChangeNotifier{

  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;

  late ChatUser user;

  AuthentificationProvider(){
    _auth=FirebaseAuth.instance;
    _navigationService=GetIt.instance.get<NavigationService>();
    _databaseService=GetIt.instance.get<DatabaseService>();
    _auth.signOut();

    _auth.authStateChanges().listen((_user) {
      if (_user != null){
        print("Logged in");
        _databaseService.updateUserLastSeenTime(_user.uid);
        _databaseService.getUser(_user.uid).then(
            (snapshot){
              Map<String, dynamic> userData = snapshot.data()! as Map<String, dynamic>;

              user = ChatUser.fromJSON({
                "uid":_user.uid,
                "name":userData["name"],
                "email": userData["email"],
                "last_active": userData["last_active"],
                "image":userData["image"],
              },
              );
              //print("User initialized: ${user?.name}");
              print(user.toMap());
              _navigationService.removeAndNavigatorTORoute('/home');
            }
        );
      }
      else {
        _navigationService.removeAndNavigatorTORoute('/login');
        print("Not Authenticated");
      }
    });

  }

  Future<void> loginUsingEmailAndPassword(
      String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //print(_auth.currentUser);
    }
    on FirebaseException{
      print('Error logging user into Firebase');
    }
    catch(e){
      print(e);
    }
  }

  Future<String?> registerUserUsingEmailAndPassword(String email, String password) async{
     try{
       UserCredential _credentials= await _auth.createUserWithEmailAndPassword(email: email, password: password);
       return _credentials.user!.uid;
     }
     on FirebaseException{
       print('Error registring user into Firebase');
     }
     catch(e){
       print(e);
     }
  }
  Future<void> logout() async {
    try{
      await _auth.signOut();
    }
    catch(e){
      print(e);
    }
  }

}