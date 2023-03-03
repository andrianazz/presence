import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile View'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://ui-avatars.com/api/?name=${user['nama']}"),
                ),
                const SizedBox(height: 20),
                Text(
                  user['nama'].toString().toUpperCase(),
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${user['email']}",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                if (user['role'] == "admin")
                  ListTile(
                    onTap: () => Get.toNamed(Routes.ADD_PEGAWAI),
                    leading: const Icon(Icons.person),
                    title: const Text("Add Pegawai"),
                  ),
                ListTile(
                  onTap: () => Get.toNamed(
                    Routes.UPDATE_PROFILE,
                    arguments: user,
                  ),
                  leading: const Icon(Icons.person),
                  title: const Text("Update Profile"),
                ),
                ListTile(
                  onTap: () => Get.toNamed(Routes.NEW_PASSWORD),
                  leading: const Icon(Icons.vpn_key),
                  title: const Text("Update Password"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                )
              ],
            );
          } else {
            return const Center(
              child: Text("Tidak Ada Data"),
            );
          }
        },
      ),
    );
  }
}
