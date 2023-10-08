import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:traver/src/features/auth/controllers/auth_controller.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController= TextEditingController();

  AuthController authController  = Get.put(AuthController());
  RxBool isAuth = false.obs;
  var email = "";
  var password="";


  RxBool obscureText  = true.obs;



  Future<void> loginAction()async{
    isAuth.value = true;
    email = emailController.text;
    password=passwordController.text;
    await authController.loginUser(email, password);
    isAuth.value = false;
  }
  void forgotPassword(){
    Get.toNamed("forgotPassword");
  }
  void createAccount(){
    Get.toNamed('register');
  }

  void toggleVisibility(){
    obscureText.value = !obscureText.value;
  }




Future<void> signInWithGoogle() async {
  isAuth.value = true;

  final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication gAuth = await gUser!.authentication;
  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken,
    idToken: gAuth.idToken,
  );

  try {
    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = authResult.user;
    if (user != null) {
      final userEmail = user.email??"";
      final userName = user.displayName??"";
      final userPhone = user.phoneNumber??"";
      checkIfUserExist(userEmail, userName, userPhone);
      // await authController.getUserByEmail(email);
    }
  } catch (error) {
   authController.warningSnackBar("Auth failed", "Error signing in with Google: $error");
  }
}


Future<void> checkIfUserExist(String email, String userName, String userPhone) async{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
 try {
    final QuerySnapshot querySnapshot = await firestore
        .collection('users') // Replace with your collection name
        .where('email', isEqualTo: email)
        .get();
    
    if (querySnapshot.docs.isNotEmpty) {
      print("Found");
      await authController.getUserByEmail(email);
      Get.toNamed("/homepage");
      } else {
      print("not Found");

     await authController.saveToFireStore(userName, email, userPhone);

      }
    
  } catch (e) {
  }



}



 @override
void dispose() {
  Get.delete<LoginController>(); // Dispose of the controller
  super.dispose();
}





}
