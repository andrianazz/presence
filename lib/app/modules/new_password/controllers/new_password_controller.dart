import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController currC = TextEditingController();
  TextEditingController newC = TextEditingController();
  TextEditingController confirmC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePassword() async {
    if (currC.text.isEmpty || newC.text.isEmpty || confirmC.text.isEmpty) {
      Get.snackbar("Terjadi Kesalahan", "Semua Field tidak boleh kosong");
    }

    if (newC.text != confirmC.text) {
      Get.snackbar("Terjadi Kesalahan", "Password Baru tidak sama");
    }

    try {
      String email = auth.currentUser!.email!;
      await auth.signInWithEmailAndPassword(email: email, password: currC.text);

      await auth.currentUser!.updatePassword(newC.text);

      auth.signOut();

      await auth.signInWithEmailAndPassword(email: email, password: newC.text);

      Get.back();
      Get.snackbar("Berhasil", "Password berhasil diubah");
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        Get.snackbar("Terjadi Kesalahan", "Password Lama Salah");
      }
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "$e pada update password");
    } finally {
      isLoading.value = false;
    }
  }
}
