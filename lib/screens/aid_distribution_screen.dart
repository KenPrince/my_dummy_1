// lib/screens/aid_distribution_screen.dart
import 'package:flutter/material.dart';
import '../services/beneficiary_service.dart';
import '../models/beneficiary.dart';

class AidDistributionScreen extends StatefulWidget {
  @override
  _AidDistributionScreenState createState() => _AidDistributionScreenState();
}

class _AidDistributionScreenState extends State<AidDistributionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _quantityController = TextEditingController();
  Beneficiary? _currentBeneficiary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aid Distribution')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'Beneficiary ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Beneficiary ID';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: Text('Verify ID'),
                onPressed: _verifyBeneficiary,
              ),
              if (_currentBeneficiary != null) ...[
                Text('Name: ${_currentBeneficiary!.name}'),
                Text('Age: ${_currentBeneficiary!.age}'),
                Text('Location: ${_currentBeneficiary!.location}'),
                Text('Gender: ${_currentBeneficiary!.gender}'),
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'Aid Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the aid quantity';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  child: Text('Record Distribution'),
                  onPressed: _recordDistribution,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _verifyBeneficiary() async {
    if (_formKey.currentState!.validate()) {
      try {
        final beneficiary = await BeneficiaryService().getBeneficiary(_idController.text);
        setState(() {
          _currentBeneficiary = beneficiary;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Beneficiary not found')),
        );
      }
    }
  }

  void _recordDistribution() async {
    if (_formKey.currentState!.validate() && _currentBeneficiary != null) {
      try {
        await BeneficiaryService().recordAidDistribution(
          _currentBeneficiary!.id!,
          int.parse(_quantityController.text),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Aid distribution recorded successfully')),
        );
        _clearForm();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error recording aid distribution')),
        );
      }
    }
  }

  void _clearForm() {
    _idController.clear();
    _quantityController.clear();
    setState(() {
      _currentBeneficiary = null;
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}