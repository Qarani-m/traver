import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  List pages = [HomePage(), Trips(),  WishList(), Profile()];
 
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
        print(data["gallery"].runtimeType);

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
            gallery: data["gallery"].map((item) => item.toString()).toList(),
            cords: LatLng(
              data['cords'].latitude,
              data['cords'].longitude,
            ),
            whatsIncluded: convertedData);
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
  Future<void> booking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    personResponsibleControlller.text = prefs.getString("name") ?? "-";
    phoneNumberController.text = prefs.getString("phone") ?? "-";
    emailController.text = prefs.getString("email") ?? "-";
    datesController.text = prefs.getString("email") ?? "-";
    idNumberController.text = prefs.getString("idNumber") ?? "-";
    numberOfMembersController.text = prefs.getString("email") ?? "-";
    numberOfChildrenController.text = prefs.getString("email") ?? "-";
    pwdController.text = prefs.getString("email") ?? "-";

    BookingModel();
  }

  RxString reviewCountHeader = "0".obs;

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return 'today';
    } else if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      return 'yesterday';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year % 100}';
    }
  }

  Future<List<ReviewModel>> getReviews(String id) async {
    try {
      final CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('reviews');
      QuerySnapshot querySnapshot = await collectionReference
          .where('destinationId', isEqualTo: "12")
          .get();

      List<ReviewModel> reviews = [];

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          // DateTime date = timestampToDateTime(data['date'] as Timestamp);
          // DateTime date = formatTimestamp(data['date'] as TimeStamp);
          String formattedDate = formatTimestamp(data['date'] as Timestamp);

          ReviewModel review = ReviewModel(
            name: data['name'] ?? "Unknown",
            imageUrl: data['imageUrl'] ?? "DefaultImageUrl",
            date: formattedDate.toString(),
            starCount: data['starCount'] ?? "0",
            review: data['review'] ?? "No review available",
          );

          reviews.add(review);
        }
      }

      print(reviews);

      return reviews;
    } catch (e) {
      print('Error fetching reviews: $e');
      return [];
    }
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
