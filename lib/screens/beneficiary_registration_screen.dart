// lib/screens/beneficiary_registration_screen.dart
import 'package:flutter/material.dart';
import '../services/beneficiary_service.dart';
import '../models/beneficiary.dart';

class BeneficiaryRegistrationScreen extends StatefulWidget {
  @override
  _BeneficiaryRegistrationScreenState createState() => _BeneficiaryRegistrationScreenState();
}

class _BeneficiaryRegistrationScreenState extends State<BeneficiaryRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register Beneficiary')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              // Camera placeholder (implement actual camera functionality)
              Container(
                height: 200,
                color: Colors.grey,
                child: Center(child: Text('Camera Placeholder')),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Register'),
                onPressed: _registerBeneficiary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerBeneficiary() async {
    if (_formKey.currentState!.validate()) {
      final beneficiary = Beneficiary(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        location: _locationController.text,
        gender: _genderController.text,
      );

      try {
        await BeneficiaryService().addBeneficiary(beneficiary);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Beneficiary registered successfully')),
        );
        _clearForm();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error registering beneficiary')),
        );
      }
    }
  }

  void _clearForm() {
    _nameController.clear();
    _ageController.clear();
    _locationController.clear();
    _genderController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _locationController.dispose();
    _genderController.dispose();
    super.dispose();
  }
}