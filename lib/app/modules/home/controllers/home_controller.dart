import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> signOut() async {
    isLoading.value = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    isLoading.value = false;
    Get.offAllNamed(Routes.LOGIN);
  }
}
