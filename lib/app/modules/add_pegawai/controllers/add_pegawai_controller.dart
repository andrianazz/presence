import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingPegawai = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addPegawai() async {
    if (nameC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      Get.defaultDialog(
        title: 'Validasi Admin',
        content: Column(
          children: [
            const Text("Masukkan Password untuk Konfirmasi Admin"),
            const SizedBox(height: 10),
            TextField(
              controller: passAdminC,
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            )
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              isLoading.value = false;
              Get.back();
            },
            child: const Text("CANCEL"),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (isLoadingPegawai.isFalse) {
                  await prosesAddPegawai();
                }
              },
              child: Text(
                isLoadingPegawai.isFalse ? "Add Pegawai" : "Loading....",
              ),
            ),
          ),
        ],
      );
    } else {
      isLoading.value = false;
      Get.snackbar(
          "Terjadi Kesalahan", "Nama , NIP, dan Email tak boleh kosong");
    }
  }

  Future<void> prosesAddPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingPegawai.value = true;
      try {
        String oldEmail = auth.currentUser!.email!;

        await auth.signInWithEmailAndPassword(
            email: oldEmail, password: passAdminC.text);

        final credentialPegawai = await auth.createUserWithEmailAndPassword(
            email: emailC.text, password: "password");

        if (credentialPegawai.user != null) {
          String uid = credentialPegawai.user!.uid;

          await firestore.collection("pegawai").doc(uid).set({
            'uid': uid,
            'nama': nameC.text,
            'email': emailC.text,
            'nip': nipC.text,
            'role': "pegawai",
            'createdAt': DateTime.now().toIso8601String(),
          });

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
            email: oldEmail,
            password: passAdminC.text,
          );

          isLoading.value = false;
          isLoadingPegawai.value = false;

          Get.back();
          Get.back();
          Get.snackbar("Berhasil", "Berhasil Menambahkan Pegawai");
        }
      } on FirebaseAuthException catch (e) {
        isLoadingPegawai.value = false;
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi Kesalahan", "No user found for that email.");
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              "Terjadi Kesalahan", "Wrong password provided for that user.");
        } else {
          isLoadingPegawai.value = false;
          isLoading.value = false;
          Get.snackbar("Terjadi Kesalahan", e.code);
        }
      } catch (e) {
        isLoading.value = false;
        isLoadingPegawai.value = false;
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat Menambahkan Pegawai");
      }
    } else {
      isLoading.value = false;
      isLoadingPegawai.value = false;
      Get.snackbar("Terjadi Kesalahan", "Password Admin tidak boleh kososng");
    }
  }
}
