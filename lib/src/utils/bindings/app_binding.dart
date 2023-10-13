import 'package:get/get.dart';
import 'package:traver/src/features/auth/controllers/signup_controller.dart';
import 'package:traver/src/features/home/controller/homepage_controller.dart';
import 'package:traver/src/features/notifications/controller/notification_controller.dart';
import 'package:traver/src/features/profile/controller/profile_controller.dart';
import 'package:traver/src/features/trips/screens/controllers/trips_home_controller.dart';
import 'package:traver/src/features/wishlist/controller/wishlist_controller.dart';

class AppBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() =>SignUpController() );
    Get.lazyPut<ProfileController>(() =>ProfileController() );
    Get.lazyPut<HomePageController>(() =>HomePageController() );
    Get.lazyPut<TripsController>(() =>TripsController() );
    Get.lazyPut<WishListController>(() =>WishListController() );
    // Get.lazyPut(() => );
    // Get.lazyPut(() => );
  }

}