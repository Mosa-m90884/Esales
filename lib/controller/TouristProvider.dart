import 'package:e_tourism/model/tourist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final touristProvider = StateNotifierProvider<TouristNotifier, List<Tourist>>((ref) {
  return TouristNotifier();
});

class TouristNotifier extends StateNotifier<List<Tourist>> {
  TouristNotifier() : super([]);

  Future<void> fetchTourists() async {
    final snapshot = await FirebaseFirestore.instance.collection('tourists').get();
    state = snapshot.docs.map((doc) => Tourist.fromFirestore(doc)).toList();
  }

  Future<void> addTourist(Tourist tourist) async {
    print("object");
    await FirebaseFirestore.instance.collection('tourists').add(tourist.toFirestore());
    fetchTourists(); // تحديث القائمة
  }

  Future<void> updateTourist(Tourist tourist) async {
    await FirebaseFirestore.instance.collection('tourists').doc(tourist.id).update(tourist.toFirestore());
    fetchTourists(); // تحديث القائمة
  }

  Future<void> deleteTourist(String id) async {
    await FirebaseFirestore.instance.collection('tourists').doc(id).delete();
    fetchTourists(); // تحديث القائمة
  }
}