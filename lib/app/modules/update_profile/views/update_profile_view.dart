import 'dart:io';

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
    controller.nameC.text = user['nama'];
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
            controller: controller.nipC,
            readOnly: true,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: 'NIP',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.emailC,
            readOnly: true,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.nameC,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              GetBuilder<UpdateProfileController>(builder: (c) {
                if (c.image != null) {
                  return Column(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.file(
                            File(c.image!.path),
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          controller.deleteProfile(user["uid"]);
                        },
                        child: const Text("DELETE"),
                      ),
                    ],
                  );
                } else {
                  if (user['profile'] != null) {
                    return ClipOval(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(user['profile']),
                      ),
                    );
                  } else {
                    return const Text("No Choosen");
                  }
                }
              }),
              OutlinedButton(
                onPressed: () {
                  controller.imagePicker();
                },
                child: const Text("Choose File"),
              ),
            ],
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
