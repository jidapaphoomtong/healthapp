import 'package:flutter/material.dart';
import 'package:health/api_connection/api_connetion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminHealthcareScreen extends StatefulWidget {
  @override
  _AdminHealthcareScreenState createState() => _AdminHealthcareScreenState();
}

class _AdminHealthcareScreenState extends State<AdminHealthcareScreen> {
  final _titleController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _addMenu() async {
  final newMenu = {
    'title': _titleController.text,
    'imageUrl': _imageUrlController.text,
    'description': _descriptionController.text,
  };

  // Check if fields are correctly populated
  print(newMenu); // Add this line for debugging

  final response = await http.post(
    Uri.parse(API.add_health),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(newMenu),
  );

  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Menu added successfully!')),
    );
    // _titleController.clear();
    // _imageUrlController.clear();
    // _descriptionController.clear();
  } else {
    print('Failed to add menu. Response body: ${response.body}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Menu added successfully!')),
    );
  }

    _titleController.clear();
    _imageUrlController.clear();
    _descriptionController.clear();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Healthcare')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addMenu,
              child: Text('Add Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
