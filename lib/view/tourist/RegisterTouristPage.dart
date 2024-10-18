import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/TourProvider.dart';
import '../../controller/TouristProvider.dart';
import '../../model/tourist.dart';

class registerTouristPage extends ConsumerStatefulWidget {
  @override
  _TouristPageState createState() => _TouristPageState();
}

class _TouristPageState extends ConsumerState<registerTouristPage> {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedTourId;
  String? selectedTouristId = "";

  @override
  void initState() {
    super.initState();
    ref.read(touristProvider.notifier).fetchTourists();
    ref.read(tourListProvider.notifier).fetchTours();
  }

  @override
  Widget build(BuildContext context) {
    final tourists = ref.watch(touristProvider);
    final tours = ref.watch(tourListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('إدارة السياح وتسجيلهم في جولات')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: fNameController,
              decoration: InputDecoration(labelText: 'الاسم الأول'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: lNameController,
              decoration: InputDecoration(labelText: 'الاسم الأخير'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'الوصف'),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'اختر جولة'),
              value: selectedTourId,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTourId = newValue;
                });
              },
              items: tours.map((tour) {
                return DropdownMenuItem<String>(
                  value: tour.id,
                  child: Text('رقم ${tour.id} - تاريخ: ${tour.date}'),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final tourist = Tourist(
                  id: selectedTouristId ?? '',
                  fName: fNameController.text,
                  lName: lNameController.text,
                  description: descriptionController.text,
                  tourId: selectedTourId!,
                );

                if (selectedTouristId == '') {
                  ref.read(touristProvider.notifier).addTourist(tourist);
                } else {
                  ref.read(touristProvider.notifier).updateTourist(tourist);
                }

                // Clear inputs
                fNameController.clear();
                lNameController.clear();
                descriptionController.clear();
                setState(() {
                  selectedTourId = null;
                  selectedTouristId = "";
                });
              },
              child: Text(selectedTouristId == '' ? 'إضافة سائح' : 'تعديل سائح',style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                primary: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tourists.length,
                itemBuilder: (context, index) {
                  final tourist = tourists[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('${tourist.fName} ${tourist.lName}'),
                      subtitle: Text(tourist.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              selectedTouristId = tourist.id;
                              fNameController.text = tourist.fName;
                              lNameController.text = tourist.lName;
                              descriptionController.text = tourist.description;
                              setState(() {
                                selectedTourId = tourist.tourId;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              ref.read(touristProvider.notifier).deleteTourist(tourist.id);
                            },
                          ),
                        ],
                      ),
                    ),
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