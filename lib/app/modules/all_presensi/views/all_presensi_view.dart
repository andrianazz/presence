import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/all_presensi_controller.dart';

class AllPresensiView extends GetView<AllPresensiController> {
  const AllPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALL PRESENSI'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Material(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.DETAIL_PRESENSI);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Masuk"),
                            Text(DateFormat.yMMMEd().format(DateTime.now()))
                          ],
                        ),
                        Text(DateFormat.jms().format(DateTime.now())),
                        const SizedBox(height: 10),
                        const Text("Keluar"),
                        Text(DateFormat.jms().format(DateTime.now()))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
