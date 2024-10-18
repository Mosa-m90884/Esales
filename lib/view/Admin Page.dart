import 'package:e_tourism/view/driver/DriversPage.dart';
import 'package:e_tourism/view/programe/ProgrammesListPage.dart';
import 'package:e_tourism/view/programe/ProgrammesPage.dart';
import 'package:e_tourism/view/tour/ToursPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'guide/guides.dart';
import 'tour/BusReportPage.dart';
import 'tour/TourSearchPage.dart';
import 'tourist/RegisterTouristPage.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة المدير'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio:1.2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          children: [
            _buildButton(context, 'المرشدين(دليل سياحي)', Icons.person_add, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProviderScope(child: GuidesPage())),
              );
            }),
            _buildButton(context, 'السائقين والحافلات', Icons.drive_eta, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProviderScope(child: DriversPage())),
              );
            }),
            _buildButton(context, 'اليرامج السياحية', Icons.list, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProviderScope(child: ProgrammesPage())),
              );
            }),
            _buildButton(context, 'الجولات السياحية', Icons.rotate_left, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProviderScope(child: ToursPage())),
              );
            }),


            _buildButton(context, 'البرامج خلال فترة محددة', Icons.date_range, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProviderScope(child: ProgrammesListPage())),
              );
            }),


            _buildButton(context, 'تقارير عن الحافلات', Icons.car_crash, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProviderScope(child: BusReportPage())),
              );
            }),

          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // لون الخلفية
        onPrimary: Colors.white, // لون النص
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // زوايا مستديرة
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}