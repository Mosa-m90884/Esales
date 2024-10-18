import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_tourism/model/program.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class ProgrammeProvider extends StateNotifier<List<Programme>> {
  ProgrammeProvider() : super([]);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchProgrammes() async {
    final snapshot = await _firestore.collection('programmes').get();
    state = snapshot.docs.map((doc) => Programme.fromFirestore(doc)).toList();
  }
  Future<void> fetchProgrammeBetweenDates(DateTime start, DateTime end) async {
    // تحويل التواريخ إلى تنسيق مناسب
    String startString = start.toIso8601String();
    String endString = end.toIso8601String();

    final snapshot = await _firestore
        .collection('programmes')
        .where('start_date', isGreaterThan: startString) // أكبر من تاريخ البداية
        .where('start_date', isLessThan: endString)     // أصغر من تاريخ النهاية
        .get();

    // تحويل المستندات إلى كائنات Programme
    state = snapshot.docs.map((doc) => Programme.fromFirestore(doc)).toList();
  }
  // دالة لتصفير القائمة
  void clearProgrammes() {
    state = []; // إعادة تعيين الحالة إلى قائمة فارغة
  }
  Future<void> addProgramme(Programme programme) async {
    await _firestore.collection('programmes').add(programme.toMap());
    await fetchProgrammes();
  }

  Future<void> updateProgramme(Programme programme) async {
    await _firestore.collection('programmes').doc(programme.id).update(programme.toMap());
    await fetchProgrammes();
  }

  Future<void> deleteProgramme(String id) async {
    await _firestore.collection('programmes').doc(id).delete();
    await fetchProgrammes();
  }
}

final programmeListProvider = StateNotifierProvider<ProgrammeProvider, List<Programme>>((ref) {
  return ProgrammeProvider();
});