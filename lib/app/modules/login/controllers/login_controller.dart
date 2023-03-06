import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        final credentialPegawai = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passC.text);

        if (credentialPegawai.user != null) {
          if (credentialPegawai.user!.emailVerified == true) {
            isLoading.value = false;
            if (passC.text == "password") {
              Get.toNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: "Belum Verifikasi",
              middleText: "Silahkan Verifikasi Email Terlebih Dahulu",
              actions: [
                ElevatedButton(
                  onPressed: () {
                    isLoading.value = false;
                    Get.back();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    try {
                      credentialPegawai.user!.sendEmailVerification();
                      isLoading.value = false;
                      Get.back();
                      Get.snackbar(
                        "Berhasil",
                        "Kami telah mengirimkan verifikasi email",
                      );
                    } catch (e) {
                      isLoading.value = false;
                      Get.snackbar(
                          "Terjadi Kesalahan", "Verifikasi Gagal Dikirimkan");
                    }
                  },
                  child: const Text("Verifikasi Email"),
                )
              ],
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi Kesalahan", "No user found for that email.");
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              "Terjadi Kesalahan", "Wrong password provided for that user.");
        } else {
          isLoading.value = false;
          Get.snackbar("Terjadi Kesalahan", e.code);
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat Login");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email dan Password Harus Diisi");
    }
  }
}
