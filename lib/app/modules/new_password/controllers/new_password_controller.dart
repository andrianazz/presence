import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController newPassC = TextEditingController();

  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "password234") {
        try {
          String email = auth.currentUser!.email!;
          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: email, password: newPassC.text);

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            Get.snackbar("Terjadi Kesalahan", "Email belum terdaftar");
          } else if (e.code == 'wrong-password') {
            Get.snackbar("Terjadi Kesalahan", "Password Salah");
          } else if (e.code == 'weak-password') {
            Get.snackbar(
                "Terjadi Kesalahan", "Password Lemah, harus lebih 6 karakter");
          }
        } catch (e) {
          Get.snackbar("Terjadi Kesalahan", "Tidak dapat Login");
        }
      } else {
        Get.snackbar("Terjadi Kesalahan", "Password baru harus diubah");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password baru wajib diisi");
    }
  }
}
