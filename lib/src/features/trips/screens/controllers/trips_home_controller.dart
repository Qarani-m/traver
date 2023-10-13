import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traver/src/features/home/controller/homepage_controller.dart';
import 'package:traver/src/features/home/models/booking_model.dart';

class TripsController extends GetxController {
  String email = "";
  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email") ?? "";
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") ?? "";
  }

Future<List<Map<String, String>>> getBookedTours(String email) async {
  try {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot =
        await collectionReference.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          querySnapshot.docs[0].data() as Map<String, dynamic>;

      final List<dynamic> dynamicData = data['booked'];
      final List<Map<String, String>> convertedData = dynamicData.map((item) {
        final Map<String, dynamic> itemData = Map<String, dynamic>.from(item);
        final Map<String, String> bookedData = {};

        itemData.forEach((key, value) {
          if (value is String) {
            bookedData[key] = value;
          }
        });

        return bookedData;
      }).toList();

      print(convertedData);

      return convertedData; // Return the converted data
    }
  } catch (e) {
    // Handle any potential errors here
    print('Error fetching data: $e');
    return [];
  }

  return []; // Return an empty list if there's no data
}

}
