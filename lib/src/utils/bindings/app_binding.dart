import 'package:get/get.dart';
import 'package:traver/src/features/auth/controllers/signup_controller.dart';

class AppBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() =>SignUpController() );
    // Get.lazyPut(() => );
    // Get.lazyPut(() => );
    // Get.lazyPut(() => );
    // Get.lazyPut(() => );
  }

}