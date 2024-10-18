import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_tourism/model/Guide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class GuideProvider extends StateNotifier<List<Guide>> {
  GuideProvider() : super([]);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchGuides() async {
    final snapshot = await _firestore.collection('guides').get();
    state = snapshot.docs.map((doc) => Guide.fromFirestore(doc)).toList();
  }

  Future<void> addGuide(Guide guide) async {
    await _firestore.collection('guides').add(guide.toMap());
    await fetchGuides(); // تحديث القائمة بعد الإضافة
  }

  Future<void> updateGuide(Guide guide) async {
    await _firestore.collection('guides').doc(guide.id).update(guide.toMap());
    await fetchGuides(); // تحديث القائمة بعد التحديث
  }

  Future<void> deleteGuide(String id) async {
    await _firestore.collection('guides').doc(id).delete();
    await fetchGuides(); // تحديث القائمة بعد الحذف
  }
}

final guideListProvider = StateNotifierProvider<GuideProvider, List<Guide>>((ref) {
  return GuideProvider();
});