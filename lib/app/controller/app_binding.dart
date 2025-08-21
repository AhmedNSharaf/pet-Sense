import 'package:get/get.dart';
import 'package:pet_sense/app/view/app/modules/screens/auth/login_screen.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
