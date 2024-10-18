import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_tourism/model/Guide.dart';
import 'package:e_tourism/model/driver.dart';
import 'package:e_tourism/model/program.dart';
import 'package:e_tourism/model/tour.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class TourProvider extends StateNotifier<List<Tour>> {
  TourProvider() : super([]);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchTours() async {
    final snapshot = await _firestore.collection('tours').get();
    state = snapshot.docs.map((doc) => Tour.fromFirestore(doc)).toList();
  }

  Future<void> addTour(Tour tour) async {
    await _firestore.collection('tours').add(tour.toMap());
    await fetchTours();
  }

  Future<void> updateTour(Tour tour) async {
    await _firestore.collection('tours').doc(tour.id).update(tour.toMap());
    await fetchTours();
  }

  Future<void> deleteTour(String id) async {
    await _firestore.collection('tours').doc(id).delete();
    await fetchTours();
  }

  Future<void> fetchToursBetweenDates(DateTime startDate, DateTime endDate) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('tours')
        .where('date', isGreaterThan: startDate.toIso8601String())
        .where('date', isLessThan: endDate.toIso8601String())
        .get();

    state = snapshot.docs.map((doc) => Tour.fromFirestore(doc)).toList();
  }

  Map<String, int> getBusCountBetweenDates(DateTime startDate, DateTime endDate) {
    final Map<String, int> busCount = {};

    for (var tour in state) {
      if (DateTime.parse(tour.date).isAfter(startDate) && DateTime.parse(tour.date).isBefore(endDate)) {
        busCount[tour.driverId] = (busCount[tour.driverId] ?? 0) + 1; // استخدام driverId كمعرف للحافلة
      }
    }

    return busCount;
  }

}

final tourListProvider = StateNotifierProvider<TourProvider, List<Tour>>((ref) {
  return TourProvider();
});


final tourListProvider2 = FutureProvider<List<Tour>>((ref) async {
  final snapshot = await FirebaseFirestore.instance.collection('tours').get();
  return snapshot.docs.map((doc) => Tour.fromFirestore(doc)).toList();
});

final programmeProvider = FutureProvider.family<Programme, String>((ref, programmeId) async {
  final doc = await FirebaseFirestore.instance.collection('programmes').doc(programmeId).get();
  return Programme.fromFirestore(doc);
});

final guideProvider = FutureProvider.family<Guide, String>((ref, guideId) async {
  final doc = await FirebaseFirestore.instance.collection('guides').doc(guideId).get();
  return Guide.fromFirestore(doc);
});

final vehicleProvider = FutureProvider.family<Driver, String>((ref, driverId) async {
  final doc = await FirebaseFirestore.instance.collection('vehicles').doc(driverId).get();
  return Driver.fromFirestore(doc);
});