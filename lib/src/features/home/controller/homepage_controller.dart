import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traver/src/features/home/screens/home_page.dart';
import 'package:traver/src/features/profile/screens/profile.dart';
import 'package:traver/src/features/trips/screens/trips.dart';
import 'package:traver/src/features/wishlist/screens/wishlist.dart';

class HomePageController extends GetxController {
  RxString name = "1".obs;
  RxString email = "2".obs;
  RxString phone = "3".obs;
  RxList<String> intrests = <String>[].obs;
  RxInt currentPageIndex  = 0.obs;

  List pages = [
    const HomePage(),
    const Trips(),
    const WishList(),
    const Profile()
  ];

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString("name") ?? "";
    email.value = prefs.getString("email") ?? "";
    phone.value = prefs.getString("phone") ?? "";
    intrests.value = prefs.getStringList("intrests")??["Empty"];

  }

  // void refresh(String name, String)
}
