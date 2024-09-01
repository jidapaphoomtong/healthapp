import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health/healthcheck/condition_Pressure.dart';
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
                    _showSnackBar("กรุณากรอกข้อมูลให้ครบถ้วน");
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
                buttonText: "ประเมินผลความดัน",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _PressureScreenState extends State<PressureScreen> {
//   final _sysController = TextEditingController();
//   final _diaController = TextEditingController();
//   final _pulController = TextEditingController();
//   bool _isFinished = false;

//   void _showPressurePop(String sys, String dia, String pul) {
//     int sysValue = int.parse(sys);
//     int diaValue = int.parse(dia);
//     int pulValue = int.parse(pul);
//     String condition = determineCondition(sysValue, diaValue, pulValue);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Blood Pressure'),
//           content: Text(
//               'SYS: $sys mmHg\nDIA: $dia mmHg\nPUL: $pul min\nCondition: $condition'),
//           actions: <Widget>[
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK')),
//             TextButton(
//                 onPressed: () async {
//                   if (_sysController.text.isNotEmpty &&
//                       _diaController.text.isNotEmpty &&
//                       _pulController.text.isNotEmpty) {
//                     try {
//                       var res = await http.post(Uri.parse(API.pressure), body: {
//                         "sys": _sysController.text,
//                         "dia": _diaController.text,
//                         "pul": _pulController.text,
//                         "cond": condition.toString(),
//                       });
//                       var response = jsonDecode(res.body);
//                       if (response["success"] == true) {
//                         await showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: Center(child: Text("Data Saved Successfully")),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text(
//                                     'OK',
//                                     style: TextStyle(fontSize: 16),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                         _sysController.clear();
//                         _diaController.clear();
//                         _pulController.clear();
//                       } else {
//                         print("Error: ${response["message"]}");
//                       }
//                     } catch (e) {
//                       print(e);
//                     }
//                   } else {
//                     await showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Center(child: Text("Please fill all fields")),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text(
//                                 'OK',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   }
//                 },
//                 child: Text('Save')),
//           ],
//         );
//       },
//     );
//   }
  
//   void _showSnackBar(String message) {
//     final snackBar = SnackBar(
//       content: Text(message),
//       backgroundColor: Colors.redAccent,
//       duration: Duration(seconds: 1),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(centerTitle: true,
//         title: const Text("Blood Pressure"),),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: 240,
//                 child: Image.asset('images/hypertension-01.png'),
//               ),
//               SizedBox(height: 15),
//               Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'SYS (mmHg)',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.number,
//                         controller: _sysController,
//                       ),
//                     ),
//                   ),
//               SizedBox(height: 10),
//               Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'DIA (mmHg)',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.number,
//                         controller: _diaController,
//                       ),
//                     ),
//                   ),
//               SizedBox(height: 10),
//                Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'PUL (min.)',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.number,
//                         controller: _pulController,
//                       ),
//                     ),
//                   ),
//               SizedBox(height: 20),
//               SwipeableButtonView(
//                 isFinished: _isFinished,
//                 onFinish:  () {
//                   if (_sysController.text.isEmpty && _diaController.text.isEmpty && _pulController.text.isEmpty) {
//                   _showSnackBar("กรุณากรอกข้อมูลให้ครบถ้วน");
//                   setState(() {
//                     _isFinished = false;
//                   });
//                 } else {
//                   // Navigate to DiabetesAdvScreen
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PressureAdvScreen(),
//                     ),
//                   );

//                   setState(() {
//                     _isFinished = false;
//                   });
//                 }
//                 },
//                 onWaitingProcess: () {
//                   Future.delayed(Duration(seconds: 1), () {
//                     setState(() {
//                       _isFinished = true;
//                     });
//                   });
//                 },
//                 activeColor: Colors.blue,
//                 buttonWidget: const Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   color: Colors.black,
//                 ),
//                 buttonText: "ประเมินผลความดัน",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }