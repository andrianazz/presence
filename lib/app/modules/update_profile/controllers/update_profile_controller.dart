import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateProfile(String uid) async {
    isLoading.value = true;
    try {
      if (nipC.text.isNotEmpty &&
          nameC.text.isNotEmpty &&
          emailC.text.isNotEmpty) {
        await firestore.collection("pegawai").doc(uid).update({
          'name': nameC.text,
        });

        Get.snackbar("Berhasil", "Profile Berhasil di Update");
      }
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "$e Pada Update Profile");
    } finally {
      isLoading.value = false;
    }
  }
}
