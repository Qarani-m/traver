import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final text = ["Personal Information", "FAQ", "Customer care", "Logout"];
  @override
  void onInit() async {
    super.onInit();
    await getPrefs();
    print(prefsList);
    personalInfoFieldFiller();
  }

  List<String> prefsList = [];
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController idNumbercontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  Future<List<String>> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name") ?? "";
    String email = prefs.getString("email") ?? "";
    String phone = prefs.getString("phone") ?? "";
    String idNumber = prefs.getString("idNumber") ?? "";
    String location = prefs.getString("location") ?? "";
    String imageUrl= prefs.getString("location") ?? "";

    prefsList.clear();
    prefsList.add(name); //0
    prefsList.add(email); //1
    prefsList.add(phone); //2
    prefsList.add(idNumber); //3
    prefsList.add(location); //4
    return prefsList;
  }

  void personalInfoFieldFiller() {
    namecontroller.text = prefsList[0].isEmpty ? "-" : prefsList[0];
    emailcontroller.text = prefsList[1].isEmpty ? "-" : prefsList[1];
    phonecontroller.text = prefsList[2].isEmpty ? "-" : prefsList[2];
    idNumbercontroller.text = prefsList[3].isEmpty ? "-" : prefsList[3];
    locationcontroller.text = prefsList[4].isEmpty ? "-" : prefsList[4];
  }

RxBool isUpdatingProfilePic = false.obs;


Future<void> changeProfilePic() async {
  PlatformFile? pickedFile;
  final result = await FilePicker.platform.pickFiles(type: FileType.image);
  if (result == null || result.files.isEmpty) return;

  pickedFile = result.files.first;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final path = "profileImages/${prefs.getString("email") ?? pickedFile.name}";
  final file = File(pickedFile.path!);
  final ref = FirebaseStorage.instance.ref().child(path);

  try {
    isUpdatingProfilePic.value=true;
    UploadTask uploadTask = ref.putFile(file);
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      double progress =
          (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      print('Upload progress: $progress%');

    });
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    isUpdatingProfilePic.value=false;


    print('Download URL: $downloadUrl');
  } catch (e) {
    print('Error uploading file: $e');
  }
}

Future<void>updateFirestoreImageUrl(String imageUrl, String email)async{
    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    // SharedPreferences prefs = await SharedPreferences.getInstance();

final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  try {
    await firestore.runTransaction((transaction) async {
      final userDocRef = firestore.collection('users').doc(email);
      final userDoc = await transaction.get(userDocRef);

      if (userDoc.exists) {
        transaction.update(userDocRef, {'imageurl': imageUrl});
      } else {
        // The document doesn't exist, create it with the 'imageurl' field
        transaction.set(userDocRef, {'imageurl': imageUrl});
      }
    });
    
    print('User image updated or created successfully.');
  } catch (e) {
    print('Error updating or creating user image: $e');
  }





    Get.offAllNamed("/registerSucces");

}



}
