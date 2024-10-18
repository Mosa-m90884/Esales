import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_tourism/model/driver.dart';
import 'package:e_tourism/model/tour.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class DriverProvider extends StateNotifier<List<Driver>> {
  DriverProvider() : super([]);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchDrivers() async {
    final snapshot = await _firestore.collection('drivers').get();
    state = snapshot.docs.map((doc) => Driver.fromFirestore(doc)).toList();
  }

  Future<void> addDriver(Driver driver) async {
    await _firestore.collection('drivers').add(driver.toMap());
    await fetchDrivers();
  }

  Future<void> updateDriver(Driver driver) async {
    await _firestore.collection('drivers').doc(driver.id).update(driver.toMap());
    await fetchDrivers();
  }

  Future<void> deleteDriver(String id) async {
    await _firestore.collection('drivers').doc(id).delete();
    await fetchDrivers();
  }

  void generateReport(List<Tour> programmes, DateTime startDate, DateTime endDate) {
    final report = <String, int>{};
    String startString = startDate.toIso8601String();

    for (var programme in programmes) {
     // String startString = programme.date.toIso8601String();
     /** if (programme.date.isAfter(startDate) && programme.date.isBefore(endDate)) {
        report[programme.driverId] = (report[programme.driverId] ?? 0) + 1;
      }**/
    }

    state = report as List<Driver>;
  }
}

final driverListProvider = StateNotifierProvider<DriverProvider, List<Driver>>((ref) {
  return DriverProvider();
});