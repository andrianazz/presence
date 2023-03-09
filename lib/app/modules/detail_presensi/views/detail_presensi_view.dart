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
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMEd().format(DateTime.now()),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text("Masuk"),
                Text(
                  "lat and long : ${data['masuk']['lat']}, ${data['masuk']['long']}",
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
                const Text("Keluar"),
                Text(
                  data["keluar"]["lat"] != null ||
                          data["keluar"]["long"] != null
                      ? "lat and long : ${data['keluar']['lat']}, ${data['keluar']['long']}"
                      : "lat and long : - ",
                ),
                Text(
                  data['keluar']['date'] != null
                      ? DateFormat.jms().format(
                          DateTime.parse(
                            data['keluar']['date'],
                          ),
                        )
                      : "-",
                ),
                Text(
                  data['keluar']['address'] != null
                      ? "address : ${data['keluar']['address']}"
                      : "address : -",
                ),
                Text(
                  data['keluar']['distance']
                      ? "distance : ${data['keluar']['distance'].toString().split(".").first}"
                      : "distance : -",
                ),
                Text(
                  data['keluar']['status'] != null
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
