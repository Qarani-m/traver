import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/features/home/models/booking_model.dart';
import 'package:traver/src/features/home/models/destination_model.dart';
import 'package:traver/src/features/home/models/review_model.dart';
import 'package:traver/src/features/home/screens/about_place.dart';
import 'package:traver/src/features/home/screens/home_page.dart';
import 'package:traver/src/features/profile/screens/profile.dart';
import 'package:traver/src/features/trips/screens/trips.dart';
import 'package:traver/src/features/wishlist/screens/wishlist.dart';

class HomePageController extends GetxController with HomePageMixin {
  RxString name = "1".obs;
  RxString email = "2".obs;
  RxString phone = "3".obs;
  RxList<String> intrests = <String>[].obs;
  RxInt currentPageIndex = 0.obs;

  List pages = [HomePage(), const Trips(), const WishList(), Profile()];

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString("name") ?? "";
    email.value = prefs.getString("email") ?? "";
    phone.value = prefs.getString("phone") ?? "";
    intrests.value = prefs.getStringList("intrests") ?? ["Empty"];
    likedDestinations.value = prefs.getStringList("likedDestinations") ?? [];
  }

  void placeDetails(String placeId) {
    Get.to(AboutPlace(), arguments: {"destinationId": placeId});
  }

  var included = [
    "Flight",
    "Hotel",
    "Transport",
  ];
  var includedIcons = [
    Icons.flight_outlined,
    Icons.business,
    Icons.directions_bus_outlined
  ];

 IconData? whatsIncludedIcons(String include) {
  List<Map<String, IconData>> allIncludes = [
    {"flight": Icons.flight_outlined},
    {"business": Icons.business},
    // Add more items as needed
  ];

  for (final item in allIncludes) {
    if (item.containsKey(include)) {
      return item[include]!;
    }
  }

  return null;
}



  Future<DestinationModel> getPlaceDetails(String destinationId) async {
    try {
      final CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('destinations');
      QuerySnapshot querySnapshot = await collectionReference
          .where('destinationId', isEqualTo: "12")
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> data =
            querySnapshot.docs[0].data() as Map<String, dynamic>;
        print(data['whatsIncluded'].runtimeType);

        final List<dynamic> dynamicData = data['whatsIncluded'];

        final List<Map<String, bool>> convertedData = dynamicData.map((item) {
          final Map<String, dynamic> itemData = Map<String, dynamic>.from(item);

          final Map<String, bool> boolData = {};

          itemData.forEach((key, value) {
            if (value is bool) {
              boolData[key] = value;
            }
          });

          return boolData;
        }).toList();

        return DestinationModel(
            destinationId: data['name'],
            name: data['name'],
            mantra: data['mantra'],
            price: data['price'],
            location: data['location'],
            starCount: data['starCount'],
            about: data['about'],
            gallery: [
              // App
              AppImageStrings.onboarding[0],
              AppImageStrings.onboarding[1],
              AppImageStrings.onboarding[2],
              AppImageStrings.onboarding[2],
              AppImageStrings.onboarding[2],
            ],
            cordinates: [45.521563, -122.677433],
            whatsIncluded: convertedData
            // whatsIncluded: [
            //   {
            //     "key1": Icons.flight_outlined,
            //   },
            //   {
            //     "key2": Icons.business,
            //   },
            //   // {"key3": Icons.directions_bus_outlined},
            // ],
            );
      } else {
        print('Document with destinationId $destinationId not found.');
        return DestinationModel();
      }
    } catch (e) {
      print('Error fetching document: $e');
      return DestinationModel();
    }
  }

  TextEditingController personResponsibleControlller = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController datesController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController numberOfMembersController = TextEditingController();
  TextEditingController numberOfChildrenController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  void booking() {
    BookingModel();
  }

  Future<List<ReviewModel>> getReviews(String id) async {
    // get from firebase and map the data to the model
    return [
      ReviewModel(
          name: "Some name",
          imageUrl: "-",
          date: "-",
          starCount: "2",
          review: "Some review"),
      ReviewModel(
          name: "Some name 1",
          imageUrl: "--->",
          date: "-",
          starCount: "2",
          review: "Some review")
    ];
  }

  @override
  void dispose() {
    Get.delete<HomePageController>(); // Dispose of the controller
    super.dispose();
  }
}

mixin HomePageMixin on GetxController {
  RxList<dynamic> likedDestinations = <String>[].obs;

  Future<void> toggleLike(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> existingList = prefs.getStringList('likedDestinations') ?? [];
    if (existingList.contains(id)) {
      existingList.remove(id);
      await prefs.setStringList('likedDestinations', existingList);
      likedDestinations.remove(id);
    } else {
      existingList.add(id);
      await prefs.setStringList('likedDestinations', existingList);
      likedDestinations.add(id);
    }
  }
}
