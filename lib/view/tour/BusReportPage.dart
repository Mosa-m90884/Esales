import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/TourProvider.dart';
import '../../widget/DatePickerWidget.dart';

class BusReportPage extends ConsumerStatefulWidget {
  @override
  _BusReportPageState createState() => _BusReportPageState();
}

class _BusReportPageState extends ConsumerState<BusReportPage> {
  DateTime? startDate;
  DateTime? endDate;
  Map<String, int> report = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تقرير عن عدد الجولات التي يقوم بها كل باص بين تاريخين',style: TextStyle(fontSize: 16),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DatePickerWidget(
                    label: 'تاريخ البدء',
                    selectedDate: startDate,
                    onDateSelected: (date) {
                      setState(() {
                        startDate = date;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DatePickerWidget(
                    label: 'تاريخ الانتهاء',
                    selectedDate: endDate,
                    onDateSelected: (date) {
                      setState(() {
                        endDate = date;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (startDate != null && endDate != null) {
                  await ref
                      .read(tourListProvider.notifier)
                      .fetchToursBetweenDates(startDate!, endDate!);
                  report = ref
                      .read(tourListProvider.notifier)
                      .getBusCountBetweenDates(startDate!, endDate!);
                  setState(() {});
                }
              },
              child: Text('توليد التقرير'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: report.isEmpty
                  ? Center(child: Text('لا توجد جولات في هذا التاريخ'))
                  : ListView.builder(
                      itemCount: report.length,
                      itemBuilder: (context, index) {
                        final driverId = report.keys.elementAt(index);
                        final count = report[driverId]!;
                        return ListTile(
                          title: Text('الباص: $driverId'),
                          subtitle: Text('عدد الجولات: $count'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
