// lib/models/beneficiary.dart
class Beneficiary {
  final String? id;
  final String name;
  final int age;
  final String location;
  final String gender;

  Beneficiary({
    this.id,
    required this.name,
    required this.age,
    required this.location,
    required this.gender,
  });

  factory Beneficiary.fromMap(Map<String, dynamic> data, String id) {
    return Beneficiary(
      id: id,
      name: data['name'] ?? '',
      age: data['age'] ?? 0,
      location: data['location'] ?? '',
      gender: data['gender'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'location': location,
      'gender': gender,
    };
  }
}