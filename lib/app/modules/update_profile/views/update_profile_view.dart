import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

// ignore: must_be_immutable
class UpdateProfileView extends GetView<UpdateProfileController> {
  Map<String, dynamic> user = Get.arguments;
  UpdateProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.nipC.text = user['nip'];
    controller.nameC.text = user['name'];
    controller.emailC.text = user['email'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('UpdateProfileView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.nipC,
            decoration: const InputDecoration(
              labelText: 'NIP',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.nameC,
            decoration: const InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile(user['uid']);
                }
              },
              child: Text(
                controller.isLoading.isFalse ? "Add Pegawai" : "Loading....",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
