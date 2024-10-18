import 'package:cloud_firestore/cloud_firestore.dart';

class Tourist {
  String id;
  String fName;
  String lName;
  String description;
  String tourId;

  Tourist({
    required this.id,
    required this.fName,
    required this.lName,
    required this.description,
    required this.tourId,
  });

  factory Tourist.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Tourist(
      id: doc.id,
      fName: data['fName'],
      lName: data['lName'],
      description: data['description'],
      tourId: data['tour_id'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fName': fName,
      'lName': lName,
      'description': description,
      'tour_id': tourId,
    };
  }
}