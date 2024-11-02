import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:health/api_connection/api_connetion.dart';

class DiabetesAdvScreen extends StatelessWidget {
  final int fpg;
  final String Dcond;

  const DiabetesAdvScreen({
    super.key,
    required this.fpg,
    required this.Dcond,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Diabetes Score"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Image.asset('images/crop.jpg'),
              ),
              const SizedBox(height: 25),
              Text(
                'FPG: $fpg mg/dL',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'ผลการประเมิน : $Dcond',
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
      Uri.parse(API.diabetes),
      body: {
        'fpg': fpg.toString(),
        'Dcond': Dcond,
      },
    );

    if (res.statusCode == 200) {  // Check for successful response
      try {
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
        // JSON decoding failed, handle the error
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(child: Text("Error")),
              content: Text("Invalid JSON response: ${res.body}"),
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
    } else {
      // Server returned a non-200 status code
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Error")),
            content: Text("Server error: ${res.statusCode}"),
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
    // Network or other error occurred
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