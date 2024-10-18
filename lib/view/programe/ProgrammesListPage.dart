import '../../model/program.dart';
import '../../widget/DatePickerWidget.dart';
import 'addUpdateProgramme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controller/ProgrammeProvider.dart';

class ProgrammesListPage extends ConsumerStatefulWidget {
  @override
  _ProgrammesPageState createState() => _ProgrammesPageState();


}

class _ProgrammesPageState extends ConsumerState<ProgrammesListPage> {
  DateTime? startDate;
  DateTime? endDate;



    @override
    void initState() {
      super.initState();
      // تأجيل تصفير القائمة بعد بناء الواجهة
      Future.delayed(Duration.zero, () {
        ref.read(programmeListProvider.notifier).clearProgrammes();
      });

  }
  @override
  Widget build(BuildContext context) {
    final programmes = ref.watch(programmeListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('البرامج السياحية')),
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
              onPressed: () {
                if (startDate != null && endDate != null) {
                  // استخدم التواريخ المحددة لعرض البرامج
                  ref.read(programmeListProvider.notifier).fetchProgrammeBetweenDates(startDate!, endDate!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('يرجى تحديد تواريخ البدء والانتهاء')),
                  );
                }
              },
              child: Text('عرض البرامج'),
            ),
            Expanded(
              child: programmes.isEmpty
                  ? Center(child: Text('لا توجد برامج متاحة في هذا التاريخ'))
                  : ListView.builder(
                itemCount: programmes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(programmes[index].name),
                    subtitle: Text(programmes[index].type),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // اذهب إلى صفحة تعديل البرنامج
                            Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => ProgrammeFormPage(programme: programmes[index]),
                                ));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            ref.read(programmeListProvider.notifier).deleteProgramme(programmes[index].id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // اذهب إلى صفحة إضافة برنامج جديد
          Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => ProgrammeFormPage(programme: Programme.empty()),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}