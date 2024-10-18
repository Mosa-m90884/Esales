import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/TourProvider.dart';
import '../../controller/DriverProvider.dart';
import '../../controller/GuideProvider.dart';
import '../../controller/ProgrammeProvider.dart';
import '../../model/tour.dart';
import '../../widget/DateInputField.dart';

class TourFormPage extends ConsumerStatefulWidget {
  final Tour tour;

  TourFormPage({required this.tour});

  @override
  _TourFormPageState createState() => _TourFormPageState();
}

class _TourFormPageState extends ConsumerState<TourFormPage> {
  late String? selectedDriverId;
  late String? selectedGuideId;
  late String? selectedProgrammeId;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ref.read(driverListProvider.notifier).fetchDrivers();
    ref.read(guideListProvider.notifier).fetchGuides();
    ref.read(programmeListProvider.notifier).fetchProgrammes();

    selectedDriverId = widget.tour.driverId.isNotEmpty ? widget.tour.driverId : null;
    selectedGuideId = widget.tour.guideId.isNotEmpty ? widget.tour.guideId : null;
    selectedProgrammeId = widget.tour.programmeId.isNotEmpty ? widget.tour.programmeId : null;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController priceController = TextEditingController(text: '${widget.tour.price}');
    final TextEditingController numberController = TextEditingController(text: '${widget.tour.number}');
    final TextEditingController dateController = TextEditingController(text: widget.tour.date);

    final drivers = ref.watch(driverListProvider);
    final guides = ref.watch(guideListProvider);
    final programmes = ref.watch(programmeListProvider);

    return Scaffold(
      appBar: AppBar(title: Text(widget.tour.id == '' ? 'إضافة جولة' : 'تعديل جولة')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('اختيار المرشد', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: selectedGuideId,
                hint: Text('اختر المرشد'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGuideId = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'يرجى اختيار مرشد';
                  }
                  return null;
                },
                items: guides.map((guide) {
                  return DropdownMenuItem<String>(
                    value: guide.id,
                    child: Text(guide.lName),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              Text('اختيار السائق', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: selectedDriverId,
                hint: Text('اختر السائق'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDriverId = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'يرجى اختيار سائق';
                  }
                  return null;
                },
                items: drivers.map((driver) {
                  return DropdownMenuItem<String>(
                    value: driver.id,
                    child: Text(driver.lName),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              Text('اختيار البرنامج', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: selectedProgrammeId,
                hint: Text('اختر البرنامج'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedProgrammeId = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'يرجى اختيار برنامج';
                  }
                  return null;
                },
                items: programmes.map((programme) {
                  return DropdownMenuItem<String>(
                    value: programme.id,
                    child: Text(programme.name),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'السعر',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال السعر';
                  }
                  if (double.tryParse(value) == null) {
                    return 'يرجى إدخال رقم صحيح';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: numberController,
                decoration: InputDecoration(
                  labelText: 'عدد المشاركين',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال عدد المشاركين';
                  }
                  if (int.tryParse(value) == null) {
                    return 'يرجى إدخال رقم صحيح';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              DateInputField(controller: dateController, label: 'تاريخ الجولة'),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.tour.id == '') {
                      final newTour = Tour(
                        id: '',
                        guideId: selectedGuideId!,
                        driverId: selectedDriverId!,
                        programmeId: selectedProgrammeId!,
                        price: double.parse(priceController.text),
                        number: int.parse(numberController.text),
                        date: dateController.text,
                      );
                      ref.read(tourListProvider.notifier).addTour(newTour);
                    } else {
                      final updatedTour = Tour(
                        id: widget.tour.id,
                        guideId: selectedGuideId!,
                        driverId: selectedDriverId!,
                        programmeId: selectedProgrammeId!,
                        price: double.parse(priceController.text),
                        number: int.parse(numberController.text),
                        date: dateController.text,
                      );
                      ref.read(tourListProvider.notifier).updateTour(updatedTour);
                    }
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: Text(widget.tour.id == '' ? 'إضافة' : 'تحديث'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}