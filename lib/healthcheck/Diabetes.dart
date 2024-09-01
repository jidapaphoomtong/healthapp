import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health/api_connection/api_connetion.dart';
import 'package:health/healthcheck/condition_diabetes.dart';
import 'package:health/healthcheck/diabetes_advice.dart';
import 'package:http/http.dart' as http;
import 'package:swipeable_button_view/swipeable_button_view.dart';

class DiabetesScreen extends StatefulWidget {
  @override
  State<DiabetesScreen> createState() => _DiabetesScreenState();
}

class _DiabetesScreenState extends State<DiabetesScreen> {
  final TextEditingController _fpgController = TextEditingController();
  bool _isFinished = false;

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _navigateToDiabetesAdvScreen() {
    final int fpg = int.tryParse(_fpgController.text) ?? 0;
    final String condition = determineCondition(fpg); // Replace with your condition logic

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiabetesAdvScreen(
          fpg: fpg,
          Dcond: condition,
        ),
      ),
    );
  }

  

  // void _showSnackBar(String message) {
  //   final snackBar = SnackBar(
  //     content: Text(message),
  //     backgroundColor: Colors.redAccent,
  //     duration: Duration(seconds: 1),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blood Sugar')),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 240,
              child: Image.asset('images/dibetes.jpg'),
            ),
            SizedBox(height: 30),
             Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'FPG (mg/dL)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _fpgController,
                ),
              ),
            SizedBox(height: 20),
            SwipeableButtonView(
              isFinished: _isFinished,
              onFinish: () {
                if (_fpgController.text.isEmpty) {
                  _showSnackBar("กรุณากรอกข้อมูลให้ครบถ้วน");
                  setState(() {
                    _isFinished = false;
                  });
                } else {
                  // Navigate to DiabetesAdvScreen
                  _navigateToDiabetesAdvScreen();
                  setState(() {
                    _isFinished = false;
                  });
                }
              },
              onWaitingProcess: () {
                Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    _isFinished = true;
                  });
                });
              },
              activeColor: Colors.blue,
              buttonWidget: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
              buttonText: "ประเมินผลน้ำตาล",
            ),
          ],
        ),
      ),
    );
  }
}