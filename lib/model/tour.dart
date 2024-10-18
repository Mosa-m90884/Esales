import 'package:cloud_firestore/cloud_firestore.dart';

class Tour {
  String id;
  String guideId;
  String driverId;
  String programmeId;
  String date;

  double price;
  int number;

  Tour({required this.id, required this.guideId, required this.driverId, required this.programmeId, required this.price, required this.number,required this.date});
  Tour.empty()
      : id = '',
        guideId = '',
        driverId = '',
        programmeId = '',date ='',price=0,number=0;
  factory Tour.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Tour(
      id: doc.id,
      guideId: data['guide_id'],
      driverId: data['driver_id'],
      programmeId: data['programme_id'],
      price: data['price'],
      number: data['number'], date: data['date'],
    );

  }

  Map<String, dynamic> toMap() {
    return {
      'guide_id': guideId,
      'driver_id': driverId,
      'programme_id': programmeId,
      'price': price,
      'number': number,
      'date': date
    };
  }
}