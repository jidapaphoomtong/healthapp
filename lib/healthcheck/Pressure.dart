import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health/healthcheck/pressure_advice.dart';
import 'package:http/http.dart' as http;
import 'package:swipeable_button_view/swipeable_button_view.dart';

class PressureScreen extends StatefulWidget {
  @override
  State<PressureScreen> createState() => _PressureScreenState();
}

class _PressureScreenState extends State<PressureScreen> {
  final _sysController = TextEditingController();
  final _diaController = TextEditingController();
  final _pulController = TextEditingController();
  bool _isFinished = false;

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _navigateToPressureAdvScreen() {
    final int sys = int.tryParse(_sysController.text) ?? 0;
    final int dia = int.tryParse(_diaController.text) ?? 0;
    final int pul = int.tryParse(_pulController.text) ?? 0;
    final String condition = determineCondition(sys,dia,pul); // Replace with your condition logic

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PressureAdvScreen(
          sys: sys,
          dia: dia,
          pul: pul,
          condition: condition,
        ),
      ),
    );

    _sysController.clear();
    _diaController.clear();
    _pulController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Blood Pressure"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 240,
                child: Image.asset('images/hypertension-01.png'),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'SYS (mmHg)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _sysController,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'DIA (mmHg)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _diaController,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'PUL (min.)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _pulController,
                ),
              ),
              SizedBox(height: 20),
              SwipeableButtonView(
                isFinished: _isFinished,
                onFinish: () {
                  if (_sysController.text.isEmpty ||
                      _diaController.text.isEmpty ||
                      _pulController.text.isEmpty) {
                    _showSnackBar("Please fill in all information completely");
                    setState(() {
                      _isFinished = false;
                    });
                  } else {
                    _navigateToPressureAdvScreen();
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
                buttonText: "Calculate",
              ),
            ],
          ),
        ),
      ),
    );
  }

    String determineCondition(int sys, int dia, int pul) {
    if (sys > 180 || dia > 110) {
      return 'ความดันโลหิตสูงมาก';
    } else if (sys >= 160 && sys <= 179 || dia >= 100 && dia <= 109) {
      return 'ความดันโลหิตสูงปานกลาง';
    } else if ((sys >= 140 && sys <= 159) || (dia >= 90 && dia <= 99)) {
      return 'ความดันโลหิตสูงเล็กน้อย';
    } else if ((sys >= 130 && sys <= 139) || (dia >= 85 && dia <= 89)) {
      return 'ความดันโลหิตค่อนข้างสูง';
    } else if (sys >= 120 && sys <= 129 || dia >= 80 && dia <= 84) {
      return 'ความดันโลหิตปกติ'; 
    } else {
      return 'ไม่สามารถประมวลผลได้';
    }
  }
}