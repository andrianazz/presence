import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  void changePage(int i) {
    switch (i) {
      case 1:
        pageIndex.value = 1;
        print("ABSEN");
        break;
      case 2:
        pageIndex.value = 2;
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        pageIndex.value = 0;
        Get.offAllNamed(Routes.HOME);
    }
  }
}
