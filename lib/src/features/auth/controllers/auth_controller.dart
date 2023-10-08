import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traver/src/constants/colors.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Future.delayed(const Duration(seconds: 1), () {
        prefs.getBool("goToHomePage") ?? false
            ? Get.offNamed("/homepage")
            : Get.offNamed("/registerSucces");
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstTimeUser = prefs.getBool("isFirstTimer") ?? true;
      if (isFirstTimeUser) {
        prefs.setBool("isFirstTimer", false);
        Get.offNamed("/onboarding");
      } else {
        Get.offNamed("/login");
      }
    }
  }

  Future<void> createUser(
      String name, String email, String phone, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await saveToFireStore(
        name,
        email,
        phone,
      );
    } on FirebaseAuthException catch (e) {
      warningSnackBar("Sign-up failed", e.code);
    } catch (e) {
      warningSnackBar("Sign-up failed", e.toString());
    }
  }

  Future<void> saveToFireStore(String name, String email, String phone) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      "name": name,
      "email": email,
      "phone": phone,
      "imageUrl": "",
      "location": "",
      "idNumber": "",
      "intresets": []
    }).then((value) => print("User Added"));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
    prefs.setString("email", email);
    prefs.setString("phone", phone);
    prefs.setString("idNumber", "");
    prefs.setString("location", "");
    prefs.setString("imageUrl", "");
    prefs.setStringList("intrest", ([]) as List<String>);

    Get.offAllNamed("/registerSucces");
  }

  Future<void> login(String email, String password) async {}
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      warningSnackBar("Unknow User", "User does not exist");
    } catch (e) {
      warningSnackBar("Unknow User", "User does not exist");
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("goToHomePage", true);
      if (firebaseUser.value != null) {
        await getUserByEmail(email);

        Get.offNamed("/homepage");
      } else {
        Get.offNamed("/login");
      }
    } on FirebaseAuthException catch (ex) {
      warningSnackBar("Auth Failed", ex.code);
    } catch (_) {
      warningSnackBar("Auth Failed", "Unknow email / password");
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserByEmail(
      String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users') // Replace with your collection name
              .where('email', isEqualTo: email)
              .limit(1)
              .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>>? userDoc =
            querySnapshot.docs.first;
        if (userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data()!;
          prefs.setString("name", userData['name']);
          prefs.setString("email", userData['email']);
          prefs.setString("phone", userData['phone']);
          prefs.setString("idNumber", userData['idNumber']);
          prefs.setString("location", userData['location']);
          prefs.setString("imageUrl", userData['imageUrl']);
print("-------------------->  ${prefs.getString("idNumber")}");
         
        } else {
          warningSnackBar("Auth Failed", "User not found");
        }
        return querySnapshot.docs.first;
      } else {
        return null;
      }
    } catch (e) {
      warningSnackBar("Auth Failed", e.toString());

      return null;
    }
  }

  Future<void> signoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setBool("goToHomePage", true);
     prefs.setBool("isFirstTimer", false);
    _auth.signOut();

  }

  warningSnackBar(String title, String message) {
    return Get.snackbar(
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(bottom: 5.h),
        maxWidth: 327.w,
        title,
        message,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.white,
        ),
        backgroundColor: AppColors.darkColor.withOpacity(0.8));
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    try {
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Access the user's email from the User object
      final User? user = authResult.user;
      if (user != null) {
        final userEmail = user.email;
      }
      // ignore: empty_catches
    } catch (error) {}
  }



   @override
void dispose() {
  Get.delete<AuthController>(); // Dispose of the controller
  super.dispose();
}
}









//  User(
//   displayName: Martin Karani, 
//   email: emqarani@gmail.com, 
//   isEmailVerified: true, 
//   isAnonymous: false, 
//   metadata: 
//   UserMetadata(creationTime: 2023-10-03 18:10:40.861Z, lastSignInTime: 2023-10-05 13:03:46.041Z), phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/ACg8ocLca4WqYX69P1L1yalAK0zpXAqVH4bLUzKs2y_Ok7_D=s96-c, providerData, [UserInfo(displayName: Martin Karani, email: emqarani@gmail.com, phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/ACg8ocLca4WqYX69P1L1yalAK0zpXAqVH4bLUzKs2y_Ok7_D=s96-c, providerId: google.com, uid: 106548302917374348355), UserInfo(displayName: Martin Karani, email: emqarani@gmail.com, phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/ACg8ocLca4WqYX69P1L1yalAK0zpXAqVH4bLUzKs2y_Ok7_D=s96-c, providerId: password, uid: emqarani@gmail.com)], refreshToken: null, tenantId: null, uid: VVflGnIkg7RKVLfYgVqgBBvirRO2)
