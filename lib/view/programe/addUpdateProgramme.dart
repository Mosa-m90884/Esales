import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/ProgrammeProvider.dart';
import '../../model/program.dart';
import '../../widget/DateInputField.dart';

class ProgrammeFormPage extends ConsumerWidget {
   final Programme programme;

  ProgrammeFormPage({required this.programme});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final  typeController = TextEditingController(text: programme!.type);
    final  nameController = TextEditingController(text: programme!.name);
    final  descriptionController = TextEditingController(text: programme!.description);
    final  startDateController = TextEditingController(text: programme!.start_date);
    final  endDateController = TextEditingController(text: programme!.end_date);
    return Scaffold(
      appBar: AppBar(
          title: Text(programme.id == '' ? 'إضافة برنامج' : 'تعديل برنامج')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'نوع البرنامج')),
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'اسم البرنامج')),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'الوصف')),
            DateInputField(
                controller: startDateController, label: 'تاريخ البدء'),
            DateInputField(
                controller: endDateController, label: 'تاريخ الانتهاء'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (programme.id == '') {
                  final newProgramme = Programme(
                    id: '',
                    // سيتم تعيينه تلقائيًا في Firestore
                    type: typeController.text,
                    name: nameController.text,
                    description: descriptionController.text,
                    start_date: startDateController.text,
                    end_date: endDateController.text,
                  );
                  ref
                      .read(programmeListProvider.notifier)
                      .addProgramme(newProgramme);
                } else {
                  final updatedProgramme = Programme(
                    id: programme!.id,
                    type: typeController.text,
                    name: nameController.text,
                    description: descriptionController.text,
                    start_date: startDateController.text,
                    end_date: endDateController.text,
                  );
                  ref
                      .read(programmeListProvider.notifier)
                      .updateProgramme(updatedProgramme);
                }
                Navigator.pop(context);
              },
              child: Text(programme.id == '' ? 'إضافة' : 'تحديث'),
            ),
          ],
        ),
      ),
    );
  }
}
