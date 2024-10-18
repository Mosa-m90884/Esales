import 'package:e_tourism/model/Guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controller/GuideProvider.dart';

class AddGuidePage extends ConsumerWidget {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('إضافة مرشد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: fNameController, decoration: InputDecoration(labelText: 'الاسم الأول')),
            TextField(controller: lNameController, decoration: InputDecoration(labelText: 'الاسم الأخير')),
            TextField(controller: addressController, decoration: InputDecoration(labelText: 'العنوان')),
            TextField(controller: mobileController, decoration: InputDecoration(labelText: 'رقم الهاتف')),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'الوصف')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newGuide = Guide(
                  id: DateTime.now().toString(),
                  fName: fNameController.text,
                  lName: lNameController.text,
                  address: addressController.text,
                  mobile: mobileController.text,
                  description: descriptionController.text,
                );
                ref.read(guideListProvider.notifier).addGuide(newGuide); // إضافة المرشد
                Navigator.pop(context);
              },
              child: Text('إضافة'),
            ),
          ],
        ),
      ),
    );
  }
}