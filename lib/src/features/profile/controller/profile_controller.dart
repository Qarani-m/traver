import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traver/src/features/profile/models/faqs.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController
    with CustomerCareMixin, FaqsMixin {
  final text = ["Personal Information", "FAQ", "Customer care", "Logout"];
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController idNumbercontroller = TextEditingController();
  TextEditingController locationController = TextEditingController();
  RxString profilePicImageUrl = "".obs;
  RxList<String> prefsList = <String>[].obs;
  String phoneNumer = "";
  String idNumber = "";
  String location = "";
  RxString errorValue = "".obs;
  RxBool errorStatus = false.obs;
  RxBool successStatus = false.obs;
  RxBool isUpdatingProfilePic = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getPrefs();
    personalInfoFieldFiller();
  }

  Future<String> getMixinEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") ?? "";
  }

  Future<List<String>> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name") ?? "";
    String email = prefs.getString("email") ?? "";
    String phone = prefs.getString("phone") ?? "";
    String idNumber = prefs.getString("idNumber") ?? "";
    String location = prefs.getString("location") ?? "";
    String imageUrl = prefs.getString("imageUrl") ?? "";
    profilePicImageUrl.value = imageUrl;
    prefsList.clear();
    prefsList.add(name); //0
    prefsList.add(email); //1
    prefsList.add(phone); //2
    prefsList.add(idNumber); //3
    prefsList.add(location); //4
    prefsList.add(imageUrl); //5
    return prefsList;
  }

  void updateFieldValues() async {
    phoneNumer = phonecontroller.text;
    idNumber = idNumbercontroller.text;
    location = locationController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (phoneNumer.length != 10 || !phoneNumer.startsWith("07")) {
      errorValue.value = "Phone Number";
      errorStatus.value = true;
      return;
    }
    if (idNumber.length != 8) {
      errorValue.value = "ID Number";
      errorStatus.value = true;
      return;
    }
    if (location.length < 3) {
      errorValue.value = "City Name";
      errorStatus.value = true;
      return;
    }
    errorStatus.value = false;
    prefs.setString("phone", phoneNumer);
    prefs.setString("idNumber", idNumber);
    prefs.setString("location", location);

    prefsList[2] = phoneNumer;
    prefsList[3] = idNumber;
    prefsList[4] = location;
    await updateFireStorePersonalinfor(phoneNumer, idNumber, location);
    personalInfoFieldFiller();
    successStatus.value = true;

    // getPrefs();
  }

  Future<void> updateFireStorePersonalinfor(
      String phoneNumber, String idNumber, String city) async {
    isUpdatingProfilePic.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    String email = prefs.getString("email")!;

    try {
      final QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Iterate through the matching documents (usually just one)
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          final DocumentReference docRef = doc.reference;
          await docRef.update({'phone': phoneNumer});
          await docRef.update({'idNumber': idNumber});
          await docRef.update({'location': city});
        }
      }
      isUpdatingProfilePic.value = false;
      return;
    } catch (e) {
      return;
    }
  }

  void personalInfoFieldFiller() {
    namecontroller.text = prefsList[0].isEmpty ? "-" : prefsList[0];
    emailcontroller.text = prefsList[1].isEmpty ? "-" : prefsList[1];
    phonecontroller.text = prefsList[2].isEmpty ? "-" : prefsList[2];
    idNumbercontroller.text = prefsList[3].isEmpty ? "-" : prefsList[3];
    locationController.text = prefsList[4].isEmpty ? "-" : prefsList[4];
  }

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
      isUpdatingProfilePic.value = true;
      UploadTask uploadTask = ref.putFile(file);
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        // double progress =
        //     (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      });
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      updateFirestoreImageUrl(downloadUrl);
      isUpdatingProfilePic.value = false;
      return;
    } catch (e) {
      return;
    }
  }

  Future<void> updateFirestoreImageUrl(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    String email = prefs.getString("email")!;

    try {
      final QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Iterate through the matching documents (usually just one)
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          final DocumentReference docRef = doc.reference;
          await docRef.update({'imageUrl': imageUrl.toString()});
          prefs.setString("imageUrl", imageUrl.toString());
          profilePicImageUrl.value = imageUrl;
        }
      }
      return;
    } catch (e) {
      return;
    }
  }

  @override
  void dispose() {
    Get.delete<ProfileController>(); // Dispose of the controller
    super.dispose();
  }
}

mixin CustomerCareMixin on GetxController {
  static String email = "";

  static String eemail(){return email;}
  final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection('cutomerCareMessages')
      .where('senderEmail', isEqualTo: eemail)
      .snapshots();

  TextEditingController messageController = TextEditingController();
  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString(email)!;
    super.onInit();
  }

  void callCC() async {
    final call = Uri.parse('tel:0704847676');
    if (await canLaunchUrl(call)) {
      launchUrl(call);
    } else {
      throw 'Could not launch $call';
    }
  }

  RxInt messageLength = 0.obs;

  String generateSequentialId() {
    DateTime now = DateTime.now();
    String formattedDateTime = now.toIso8601String();
    String documentId =
        formattedDateTime.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    return documentId;
  }

  void sendText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email") ?? "";
    var message = messageController.text;
    DateTime now = DateTime.now();
    Timestamp timeStamp = Timestamp.fromDate(now);
    Map<String, dynamic> userData = {
      'isFromAdmin': false,
      'message': message,
      'senderEmail': email,
      "time": timeStamp
    };

    try {
      messageController.text = "";
      messageLength.value = 0;

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore
          .collection('cutomerCareMessages')
          .doc(generateSequentialId())
          .set(userData);

      // ignore: empty_catches
    } catch (e) {}
  }
}

mixin FaqsMixin on GetxController {
  RxList<FaqsModel> faqsList = <FaqsModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await loadFaqs();
  }

  Future<void> loadFaqs() async {
    faqsList.value = <FaqsModel>[];

    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('faqs').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (final doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          faqsList.add(FaqsModel(
            question: data['question'],
            answer: data["answer"],
          ));
        }
      }
    } catch (e) {}
  }
}
