import 'package:e_tourism/controller/TourProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/tour.dart';
import 'package:flutter/material.dart';

class TourDetailPage extends ConsumerWidget {
  final Tour tour;

  TourDetailPage({required this.tour});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programmeAsync = ref.watch(programmeProvider(tour.programmeId));
    final guideAsync = ref.watch(guideProvider(tour.guideId));
    final vehicleAsync = ref.watch(vehicleProvider(tour.driverId));

    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الجولة: ${tour.id}'),
        backgroundColor: Colors.teal, // لون شريط التطبيق
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[50]!, Colors.white], // خلفية متدرجة
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('السعر:', '${tour.price} ج.م', Icons.money),
            SizedBox(height: 10),
            _buildInfoRow('عدد المشاركين:', '${tour.number}', Icons.group),
            SizedBox(height: 10),
            _buildInfoRow('تاريخ الجولة:', '${tour.date}', Icons.calendar_today),
            SizedBox(height: 20),
            Text('معلومات البرنامج:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
            programmeAsync.when(
              data: (programme) => Text('اسم البرنامج: ${programme.name}', style: TextStyle(fontSize: 18)),
              loading: () => CircularProgressIndicator(),
              error: (error, stack) => Text('حدث خطأ في تحميل البرنامج', style: TextStyle(color: Colors.red)),
            ),
            SizedBox(height: 20),
            Text('معلومات المرشد:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
            guideAsync.when(
              data: (guide) => Text('اسم المرشد: ${guide.lName}', style: TextStyle(fontSize: 18)),
              loading: () => CircularProgressIndicator(),
              error: (error, stack) => Text('حدث خطأ في تحميل المرشد', style: TextStyle(color: Colors.red)),
            ),
            SizedBox(height: 20),
            Text('معلومات المركبة:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
            vehicleAsync.when(
              data: (vehicle) => Text('طراز المركبة: ${vehicle.plateNumber}', style: TextStyle(fontSize: 18)),
              loading: () => CircularProgressIndicator(),
              error: (error, stack) => Text('حدث خطأ في تحميل المركبة', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal), // أيقونة بجانب النص
        SizedBox(width: 10),
        Expanded(
          child: Text(
            '$title $value',
            style: TextStyle(fontSize: 18, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }
}