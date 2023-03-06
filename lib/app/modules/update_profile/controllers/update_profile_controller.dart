import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  XFile? image;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Future<void> updateProfile(String uid) async {
    isLoading.value = true;
    try {
      if (nipC.text.isNotEmpty &&
          nameC.text.isNotEmpty &&
          emailC.text.isNotEmpty) {
        Map<String, dynamic> data = {
          'nama': nameC.text,
        };
        if (image != null) {
          String ext = image!.path.split(".").last;
          File file = File(image!.path);
          await storage.ref("$uid/profile.$ext").putFile(file);
          String urlImage =
              await storage.ref("$uid/profile.$ext").getDownloadURL();

          data.addAll({"profile": urlImage});
        }

        await firestore.collection("pegawai").doc(uid).update(data);

        Get.back();
        image = null;
        Get.snackbar("Berhasil", "Profile Berhasil di Update");
      }
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "$e Pada Update Profile");
    } finally {
      isLoading.value = false;
    }
  }

  void imagePicker() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      print(image!.name);
      print(image!.name.split(".").last);
      print(image!.path);
    } else {
      print(image);

      update();
    }
  }

  void deleteProfile(String uid) async {
    await firestore.collection("pegawail").doc(uid).update({
      'profile': FieldValue.delete(),
    });

    update();

    Get.back();
  }
}
