import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> prosesAddPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      try {
        String emailAdmin = auth.currentUser!.email!;

        final credentialAdmin = await auth.createUserWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text,
        );

        final pegawaiCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password234",
        );

        print(pegawaiCredential);

        if (pegawaiCredential.user != null) {
          CollectionReference pegawai = firestore.collection("pegawai");
          String uid = pegawaiCredential.user!.uid;

          await pegawai.doc(uid).set({
            'nip': nipC.text,
            'name': nameC.text,
            'email': emailC.text,
            'uid': uid,
            'created_at': DateTime.now().toIso8601String(),
          });

          await pegawaiCredential.user!.sendEmailVerification();

          await auth.signOut();

          await auth.createUserWithEmailAndPassword(
            email: emailAdmin,
            password: passAdminC.text,
          );

          Get.back();
          Get.back();
          Get.snackbar("Berhasil", "Berhasil Menambahkan Pegawai");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Terjadi Kesalahan", "Password yang digunakan lemah");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Terjadi Kesalahan", "Email sudah digunakan");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi Kesalahan", "Password Salah");
        } else {
          Get.snackbar("Terjadi Kesalahan", e.code);
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat menambahkan pegawai");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password Admin harus diisi");
    }
  }

  Future<void> addPegawai() async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      Get.defaultDialog(
        title: 'Validasi Admin',
        content: Column(
          children: [
            const Text("Masukkan Password validasi admin"),
            TextField(
              controller: passAdminC,
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            )
          ],
        ),
        actions: [
          OutlinedButton(
              onPressed: () => Get.back(), child: const Text("CANCEL")),
          ElevatedButton(
              onPressed: () async {
                await prosesAddPegawai();
              },
              child: const Text("ADD PEGAWAI")),
        ],
      );
    } else {
      Get.snackbar("Terjadi Kesalahan", "NIP, Nama dan Email harus diisi");
    }
  }
}
