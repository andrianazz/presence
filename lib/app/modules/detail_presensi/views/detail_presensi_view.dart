import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  const DetailPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                const Text("19.17287981273, -12898321"),
                Text(DateFormat.jms().format(DateTime.now())),
                const SizedBox(height: 10),
                const Text("Keluar"),
                const Text("1.376872, -2783.387"),
                Text(DateFormat.jms().format(DateTime.now())),
              ],
            ),
          )
        ],
      ),
    );
  }
}
