import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.signOut();
                }
              },
              icon: controller.isLoading.isFalse
                  ? const Icon(Icons.logout)
                  : const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton:
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          String role = snapshot.data!.data()!["role"];
          if (role == "admin") {
            return FloatingActionButton(
              onPressed: () => Get.toNamed(Routes.ADD_PEGAWAI),
              child: const Icon(Icons.admin_panel_settings),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
