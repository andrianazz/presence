import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewPasswordView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.currC,
            obscureText: true,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: "Current Password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller.newC,
            obscureText: true,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: "New Password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller.confirmC,
            obscureText: true,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: "Confirm Password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => ElevatedButton(
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  controller.updatePassword();
                }
              },
              child: Text(controller.isLoading.isFalse
                  ? "Update Password"
                  : "Loading...."),
            ),
          ),
        ],
      ),
    );
  }
}
