import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();

  void newPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "password") {
        try {
          String email = auth.currentUser!.email!;
          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: email, password: newPassC.text);

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar(
                "Terjadi Kesalahan", "The password provided is too weak.");
          }
        } catch (e) {
          Get.snackbar("Terjadi Kesalahan", "Silahkan Hubungi Admin");
        }
      } else {
        Get.snackbar("Terjadi Kesalahan", "Password tidak boleh sama");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password tidak boleh Kosong");
    }
  }
}
