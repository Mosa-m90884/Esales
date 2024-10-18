import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controller/GuideProvider.dart'; // تأكد من استيراد Provider
import '../../model/Guide.dart';
class EditGuidePage extends ConsumerWidget {
  final Guide guide;

  EditGuidePage({required this.guide});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fNameController = TextEditingController(text: guide.fName);
    final lNameController = TextEditingController(text: guide.lName);
    final addressController = TextEditingController(text: guide.address);
    final mobileController = TextEditingController(text: guide.mobile);
    final descriptionController = TextEditingController(text: guide.description);

    return Scaffold(
      appBar: AppBar(title: Text('تعديل مرشد')),
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
                final updatedGuide = Guide(
                  id: guide.id,
                  fName: fNameController.text,
                  lName: lNameController.text,
                  address: addressController.text,
                  mobile: mobileController.text,
                  description: descriptionController.text,
                );
                ref.read(guideListProvider.notifier).updateGuide(updatedGuide); // تحديث المرشد
                Navigator.pop(context);
              },
              child: Text('تحديث'),
            ),
          ],
        ),
      ),
    );
  }
}