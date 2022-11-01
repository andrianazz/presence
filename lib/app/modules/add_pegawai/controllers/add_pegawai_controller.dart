import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void addPegawai() async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      try {
        final credential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password234",
        );

        print(credential);

        if (credential.user != null) {
          CollectionReference pegawai = firestore.collection("pegawai");
          String uid = credential.user!.uid;

          await pegawai.doc(uid).set({
            'nip': nipC.text,
            'name': nameC.text,
            'email': emailC.text,
            'uid': uid,
            'created_at': DateTime.now().toIso8601String(),
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Terjadi Kesalahan", "Password yang digunakan lemah");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Terjadi Kesalahan", "Email sudah digunakan");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat menambahkan pegawai");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "NIP, Nama dan Email harus diisi");
    }
  }
}
