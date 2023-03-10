import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  const DetailPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL PRESENSI'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMEd().format(DateTime.now()),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Masuk",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "lat and long : ${data['masuk']['latitude']}, ${data['masuk']['longitude']}",
                ),
                Text(
                  DateFormat.jms().format(
                    DateTime.parse(
                      data['masuk']['date'],
                    ),
                  ),
                ),
                Text("address : ${data['masuk']['address']}"),
                Text(
                    "distance : ${data['masuk']['distance'].toString().split(".").first}"),
                Text("status : ${data['masuk']['status']}"),
                const SizedBox(height: 10),
                const Text(
                  "Keluar",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data["keluar"] != null || data["keluar"] != null
                      ? "lat and long : ${data['keluar']['latitude']}, ${data['keluar']['longitude']}"
                      : "lat and long : - ",
                ),
                Text(
                  data['keluar'] != null
                      ? DateFormat.jms().format(
                          DateTime.parse(
                            data['keluar']['date'],
                          ),
                        )
                      : "-",
                ),
                Text(
                  data['keluar'] != null
                      ? "address : ${data['keluar']['address']}"
                      : "address : -",
                ),
                Text(
                  data['keluar'] != null
                      ? "distance : ${data['keluar']['distance'].toString().split(".").first}"
                      : "distance : -",
                ),
                Text(
                  data['keluar'] != null
                      ? "status : ${data['keluar']['status']}"
                      : "status : -",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
