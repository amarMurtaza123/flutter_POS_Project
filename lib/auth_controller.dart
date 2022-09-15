import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pos_system/login_page.dart';
import 'package:pos_system/wellcome_page.dart';

class AuthController extends GetxController{
  //AuthController.instance
  static AuthController instance = Get.find();
  //include email,password,name....
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    // our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);


  }

  _initialScreen(User? user){
    if(user==null){
      print('login page');
      Get.offAll(() => LoginPage());
    }else{
      Get.offAll(() => WellcomePage(email:user.email!));
    }
  }
  void register(String email, password)async{
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);



    }catch(e){
      Get.snackbar('About User','User message',
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          'Account Creation failed'
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white
          ),
        ),
      );
    }
  }

  Future addUserDetails(String name, int phone, String email, String address, String city) async {
    await FirebaseFirestore.instance.collection('customers').add({
      'name' : name,
      'phone' : phone,
      'email' : email,
      'address' : address,
      'city' : city,

    });

  }
  void login(String email, password)async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);


    }catch(e){
      Get.snackbar('About login','login message',
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
            'Login failed',
          style: TextStyle(
              color: Colors.white
          ),
        ),
        messageText: Text(
          e.toString(),

        ),
      );
    }
  }
  void logout()async{
    auth.signOut();
  }

}