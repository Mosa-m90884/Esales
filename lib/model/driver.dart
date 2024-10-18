import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  String id;
  String fName;
  String lName;
  String plateNumber;
  String description;

  Driver({required this.id, required this.fName, required this.lName, required this.plateNumber, required this.description});
  Driver.empty()
      : id = '',
        fName = '',
        lName = '',
        plateNumber = '',
        description = '';
  factory Driver.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Driver(
      id: doc.id,
      fName: data['fName'],
      lName: data['lName'],
      plateNumber: data['plateNumber'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fName': fName,
      'lName': lName,
      'plateNumber': plateNumber,
      'description': description,
    };
  }
}