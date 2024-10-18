import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/DriverProvider.dart';
import '../../model/driver.dart';
class DriverFormPage extends ConsumerWidget {
  final Driver driver;

  DriverFormPage({required this.driver});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  fNameController = TextEditingController(text: driver.fName);
    final  lNameController = TextEditingController(text:  driver!.lName);
    final  plateNumberController = TextEditingController(text: driver!.plateNumber);
    final  descriptionController = TextEditingController(text: driver!.description);
    return Scaffold(
      appBar: AppBar(title: Text(driver.id == '' ? 'إضافة سائق' : 'تعديل سائق')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: fNameController, decoration: InputDecoration(labelText: 'الاسم الأول')),
            TextField(controller: lNameController, decoration: InputDecoration(labelText: 'الاسم الأخير')),
            TextField(controller: plateNumberController, decoration: InputDecoration(labelText: 'رقم اللوحة')),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'الوصف')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (driver.id == '') {
                  final newDriver = Driver(
                    id: '', // سيتم تعيينه تلقائيًا في Firestore
                    fName: fNameController.text,
                    lName: lNameController.text,
                    plateNumber: plateNumberController.text,
                    description: descriptionController.text,
                  );
                  ref.read(driverListProvider.notifier).addDriver(newDriver);
                } else {
                  final updatedDriver = Driver(
                    id: driver!.id,
                    fName: fNameController.text,
                    lName: lNameController.text,
                    plateNumber: plateNumberController.text,
                    description: descriptionController.text,
                  );
                  ref.read(driverListProvider.notifier).updateDriver(updatedDriver);
                }
                Navigator.pop(context);
              },
              child: Text(driver.id == '' ? 'إضافة' : 'تحديث'),
            ),
          ],
        ),
      ),
    );
  }
}