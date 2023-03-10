import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
            onPressed: () => {
              Get.toNamed(Routes.PROFILE),
              pageC.changePage(2),
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            Map<String, dynamic> user =
                snapshot.data!.data() as Map<String, dynamic>;
            String defaultImage =
                "https://ui-avatars.com/api/?name=${user['nama'].toString().split(' ').join('+')}";

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 70,
                        height: 70,
                        color: Colors.grey[300],
                        child: Center(
                          child: Image.network(user['profile'] ?? defaultImage),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Welcome, ${user['nama']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            user['address'] ?? 'Tidak ada data',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.grey[300],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user['job']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${user['nip']}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${user['nama']}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.grey[300],
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: controller.streamPresenceToday(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      var dataPresence = snapshot.data?.data();
                      String masukPresence = dataPresence?['masuk'] != null
                          ? DateFormat.jms().format(
                              DateTime.parse(dataPresence!['masuk']['date']))
                          : "-";
                      String keluarPresence = dataPresence?['keluar'] != null
                          ? DateFormat.jms().format(
                              DateTime.parse(dataPresence!['keluar']['date']))
                          : "-";

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Masuk",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(masukPresence),
                            ],
                          ),
                          Container(
                            width: 2,
                            height: 20,
                            color: Colors.black26,
                          ),
                          Column(
                            children: [
                              const Text(
                                "Keluar",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(keluarPresence),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Divider(
                  thickness: 2,
                  color: Colors.grey[200],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Last 5 days"),
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.ALL_PRESENSI),
                      child: const Text("Show More"),
                    )
                  ],
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamPresence(),
                  builder: (context, snapshotPresence) {
                    if (snapshotPresence.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (!snapshotPresence.hasData) {
                      return const SizedBox(
                        height: 150,
                        child: Center(
                          child: Text("Tidak ada data"),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshotPresence.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data =
                            snapshotPresence.data!.docs[index].data();

                        return Material(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.DETAIL_PRESENSI,
                                arguments: data,
                              );
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Masuk"),
                                      Text(
                                        DateFormat.yMMMEd().format(
                                          DateTime.parse(data['date']),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    DateFormat.jms().format(
                                      DateTime.parse(data['masuk']['date']),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text("Keluar"),
                                  Text(
                                    data['keluar'] == null
                                        ? "-"
                                        : DateFormat.jms().format(
                                            DateTime.parse(
                                              data['keluar']['date'],
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          } else {
            return const Text("Tidak Memiliki Data");
          }
        },
      ),
      floatingActionButton:
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
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
        initialActiveIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
