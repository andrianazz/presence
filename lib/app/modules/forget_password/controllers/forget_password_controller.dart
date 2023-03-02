import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.snackbar(
          "Berhasil",
          "Reset Pasword telah dikirimkan ke Email Anda",
        );
        Get.back();
      } catch (e) {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Tidak dapat mengirimkan Reset Password",
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Email Tak Boleh Kosong",
      );
    }
  }
}
