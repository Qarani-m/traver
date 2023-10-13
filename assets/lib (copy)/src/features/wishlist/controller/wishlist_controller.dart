import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:traver/src/features/home/models/destination_model.dart';

class WishListController extends GetxController {
  Future<List<DestinationModel>> getLiked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> destinations = prefs.getStringList("likedDestinations") ?? [];
    return await getDestinations(["12", "13"]);
    // getDestinations(destinations);
  }

  Future<List<DestinationModel>> getDestinations(
      List<String> destinationIDs) async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('destinations');

      QuerySnapshot querySnapshot = await collectionReference
          .where('destinationId', whereIn: destinationIDs)
          .get();

      List<QueryDocumentSnapshot> destinationDocs = querySnapshot.docs;

      List<DestinationModel> destinationList = destinationDocs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        DestinationModel destinationModel = DestinationModel(
          name: data['name'],
          price: data['price'],
          starCount: data['starCount'],
          mantra: data['mantra'],
          destinationId: data["destinationId"],
          imageUrl: data["imageUrl"],
          location: data["location"]
        );
        return destinationModel;
      }).toList();


      return destinationList;

    } catch (e) {
      print('Error fetching destinations: $e');
      return [];
    }
  }
}
