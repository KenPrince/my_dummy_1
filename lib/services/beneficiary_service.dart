// lib/services/beneficiary_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/beneficiary.dart';

class BeneficiaryService {
  final CollectionReference beneficiariesCollection = FirebaseFirestore.instance.collection('beneficiaries');

  Future<void> addBeneficiary(Beneficiary beneficiary) async {
    await beneficiariesCollection.add(beneficiary.toMap());
  }

  Future<Beneficiary> getBeneficiary(String id) async {
    DocumentSnapshot doc = await beneficiariesCollection.doc(id).get();
    return Beneficiary.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  Future<void> recordAidDistribution(String beneficiaryId, int quantity) async {
    await beneficiariesCollection.doc(beneficiaryId).collection('aid_distributions').add({
      'quantity': quantity,
      'date': FieldValue.serverTimestamp(),
    });
  }
}