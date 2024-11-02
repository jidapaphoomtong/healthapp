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
                      child: const Text("Re-calculate"),
                    ),
                    const SizedBox(width: 20),
                   ElevatedButton(
  onPressed: () async {
  try {
    var res = await http.post(
      Uri.parse(API.pressure),
      body: {
        'sys': sys.toString(),   // Convert int to String
        'dia': dia.toString(),   // Convert int to String
        'pul': pul.toString(),   // Convert int to String
        'cond': condition,       // This is already a String
      },
    );
    var response = jsonDecode(res.body);
    if (response["success"] == true) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Save complete")),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: TextStyle(fontSize: 16)),
              ),
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Error")),
            content: Text(response["message"]),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: TextStyle(fontSize: 16)),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text("Error")),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }
},
  child: const Text("Save"),
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
