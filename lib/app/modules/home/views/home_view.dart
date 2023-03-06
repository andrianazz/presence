import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence/app/controllers/page_index_controller.dart';
import 'package:presence/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageC = Get.find<PageIndexController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: const Icon(Icons.person),
          ),
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

          if (snapshot.hasData) {
            String role = snapshot.data!.data()!["role"];

            if (role == "admin") {
              return FloatingActionButton(
                onPressed: () => Get.toNamed(Routes.ADD_PEGAWAI),
                child: const Icon(Icons.admin_panel_settings),
              );
            } else {
              return const SizedBox();
            }
          } else {
            return const SizedBox();
          }
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.fingerprint, title: 'ABSEN'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        style: TabStyle.fixedCircle,
        initialActiveIndex: 1,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
