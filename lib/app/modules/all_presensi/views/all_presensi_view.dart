import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
      body: GetBuilder<AllPresensiController>(builder: (c) {
        return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: controller.futureAllPresence(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
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
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data!.docs[index].data();

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Material(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Masuk"),
                                Text(DateFormat.yMMMEd()
                                    .format(DateTime.parse(data['date'])))
                              ],
                            ),
                            Text(DateFormat.jms()
                                .format(DateTime.parse(data['masuk']['date']))),
                            const SizedBox(height: 10),
                            const Text("Keluar"),
                            Text(
                              data['keluar']['date'] == null
                                  ? "-"
                                  : DateFormat.jms().format(
                                      DateTime.parse(data['keluar']['date'])),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            Dialog(
              child: SizedBox(
                height: 400,
                child: SfDateRangePicker(
                  monthViewSettings:
                      const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  selectionMode: DateRangePickerSelectionMode.range,
                  showActionButtons: true,
                  onCancel: () => Get.back(),
                  onSubmit: (obj) {
                    if (obj != null) {
                      final obj1 = (obj as PickerDateRange);
                      Get.back();
                      controller.pickDate(obj1.startDate!, obj1.endDate!);
                    } else {
                      Get.snackbar(
                          "Terjadi Kesalahan", "Silahkan pilih tanggal");
                    }
                  },
                ),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.format_list_numbered_outlined,
        ),
      ),
    );
  }
}
