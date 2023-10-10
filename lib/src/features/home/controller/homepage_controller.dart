import 'dart:ffi';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    likedDestinations.value =
        prefs.getStringList("likedDestinations") ?? [];
  }

  void placeDetails(String placeId){
    
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
