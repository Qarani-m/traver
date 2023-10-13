import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:traver/src/features/home/models/destination_model.dart';

class WishListController extends GetxController {
  Future<void> getLiked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getStringList("likedDestinations") ?? []);
    List<String> destinations = prefs.getStringList("likedDestinations") ?? [];
    getDestinations(destinations);

   
  }

   Future<List<DestinationModel>> getDestinations(
        List<String> destinationIDs) async {
      try {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('destinations');

    QuerySnapshot querySnapshot = await collectionReference.where('destinationId', whereIn: destinationIDs).get();

    List<DocumentSnapshot> destinationDocs = querySnapshot.docs;

    List<DestinationModel> destinationList = [];

    destinationDocs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DestinationModel destinationModel = DestinationModel.fromJson(data);
      destinationList.add(destinationModel);
    });

    return destinationList;
  } catch (e) {
        // Handle any potential errors here
        print('Error fetching destinations: $e');
        return [];
      }
    }
}
