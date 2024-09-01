import 'package:flutter/material.dart';
import 'package:health/api_connection/api_connetion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PressureAdvScreen extends StatelessWidget {
  final int sys;
  final int dia;
  final int pul;
  final String condition;

  const PressureAdvScreen({
    super.key,
    required this.sys,
    required this.dia,
    required this.pul,
    required this.condition,
  });

  Future<void> _savePressureData() async {
    try {
      var response = await http.post(
        Uri.parse(API.pressure),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'sys': sys,
          'dia': dia,
          'pul': pul,
          'cond': condition, // Ensure this matches the server field name
        }),
      );
      if (response.statusCode == 200) {
        print('Data saved successfully');
      } else {
        print('Failed to save data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}'); // Log response body for debugging
      }
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pressure Details"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Image.asset('images/pressure.jpg'),
              ),
              const SizedBox(height: 25),
              Text(
                'SYS: $sys mmHg',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'DIA: $dia mmHg',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'PUL: $pul min',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'ผลการประเมิน: $condition',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("ประเมินผลอีกครั้ง"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await _savePressureData(); // Ensure data is saved before navigating back
                        Navigator.pop(context);
                      },
                      child: const Text("บันทึกข้อมูล"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
