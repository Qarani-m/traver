import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:traver/src/features/home/models/destination_model.dart';

class SearchPageController extends GetxController {
  Rx<SfRangeValues> values = SfRangeValues(5000.0, 100000.0).obs;

  TextEditingController searchPageController = TextEditingController();

  void onEditingComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemList = prefs.getStringList('searchList') ?? [];
    int maxCapacity = 5;
    itemList.add(searchPageController.text);

    if (itemList.length > maxCapacity) {
      itemList = itemList.sublist(itemList.length - maxCapacity);
    }

    await prefs.setStringList('searchList', itemList);
  }


RxList<String> searchList = <String>[].obs;


  Future<List<String>> getRecentSerches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemList = prefs.getStringList('searchList') ?? [];
    searchList.value = itemList;
    return itemList;
  }

  RxBool showRecentSearches = true.obs;

  RxList<DestinationModel> dmodels = <DestinationModel>[].obs;

  Future<void> beginSearch(String val) async {
    // Future<List<DestinationModel>> beginSearch(String val) async {
    val.isNotEmpty
        ? showRecentSearches.value = false
        : showRecentSearches.value =
            true; // getDese('capital', isEqualTo: truetinations(destinations);

    try {
      dmodels.value = <DestinationModel>[];

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('destinations');

      QuerySnapshot querySnapshot = await collectionReference.get();
      List<QueryDocumentSnapshot> destinationDocs = querySnapshot.docs;

      List<DestinationModel> destinationList = destinationDocs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        print(data['name']);

        if ((data['name'].contains(val) ||
                data['price'].contains(val) ||
                data['location'].contains(val)) &&
            val.length > 0) {
          // dmodels.value = <DestinationModel>[];
          DestinationModel destinationModel = DestinationModel(
              name: data['name'],
              price: data['price'],
              starCount: data['starCount'],
              mantra: data['mantra'],
              destinationId: data["destinationId"],
              imageUrl: data["imageUrl"],
              location: data["location"]);
          dmodels.add(destinationModel);
        } else {
          dmodels.value = <DestinationModel>[];
        }

        DestinationModel destinationModel = DestinationModel(
            name: data['name'],
            price: data['price'],
            starCount: data['starCount'],
            mantra: data['mantra'],
            destinationId: data["destinationId"],
            imageUrl: data["imageUrl"],
            location: data["location"]);
        print(destinationModel);

        return destinationModel;
      }).toList();

      // return destinationList;
    } catch (e) {
      print('Error fetching destinations: $e');
    }
  }
}
