import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  void addPegawai() async {
    if (nameC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password",
        );

        if (credential.user != null) {
          String uid = credential.user!.uid;

          firestore.collection("pegawai").doc(uid).set({
            'nip': nipC.text,
            'nama': nameC.text,
            'email': emailC.text,
            'uid': uid,
            'createdAt': DateTime.now().toIso8601String(),
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar(
              "Terjadi Kesalahan", "The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Terjadi Kesalahan",
              "The account already exists for that email.");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat menambahkan pegawai");
      }
    } else {
      Get.snackbar(
          "Terjadi Kesalahan", "Nama , NIP, dan Email tak boleh kososng");
    }
  }
}
