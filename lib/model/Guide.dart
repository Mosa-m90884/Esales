import 'package:cloud_firestore/cloud_firestore.dart';

class Guide {
  String id;
  String fName;
  String lName;
  String address;
  String mobile;
  String description;

  Guide(
      {required this.id,
      required this.fName,
      required this.lName,
      required this.address,
      required this.mobile,
      required this.description});

  // تحويل من Firestore إلى Guide
  factory Guide.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Guide(
      id: doc.id,
      fName: data['fName'],
      lName: data['lName'],
      address: data['address'],
      mobile: data['mobile'],
      description: data['description'],
    );
  }

  // تحويل إلى Map لتخزينه في Firestore
  Map<String, dynamic> toMap() {
    return {
      'fName': fName,
      'lName': lName,
      'address': address,
      'mobile': mobile,
      'description': description,
    };
  }
}
