import 'package:cloud_firestore/cloud_firestore.dart';

class Programme {
  String id;
  String type;
  String name;
  String description;
  String start_date;
  String end_date;

  Programme(
      {required this.id,
      required this.type,
      required this.name,
      required this.description,
      required this.start_date,
      required this.end_date});

  Programme.empty()
      : id = '',
        type = '',
        name = '',
        description = '',
        start_date = '',
        end_date = '';

  factory Programme.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Programme(
      id: doc.id,
      type: data['type'],
      name: data['name'],
      description: data['description'],
      start_date: data['start_date'],
      end_date: data['end_date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'description': description,'start_date':start_date,'end_date':end_date
    };
  }
}
