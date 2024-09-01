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

  Future<void> _saveDiabetesData() async {
    try {
      var response = await http.post(
        Uri.parse(API.diabetes),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'fpg': fpg.toString(), // Fixed typo here
          'cond': Dcond,
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
                      child: const Text("ประเมินผลอีกครั้ง"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await _saveDiabetesData(); // Await the save operation
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


// void _showDiabetes(String fpg) {
//     int fpgValue = int.parse(fpg);
//     String condition = determineCondition(fpgValue);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Center(child: Text('ข้อมูลน้ำตาลในเลือด')),
//           content: Text('FPG: $fpg Mg/dl\nสภาวะ: $condition'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 if (_fpgController.text.isNotEmpty) {
//                   try {
//                     var res = await http.post(
//                       Uri.parse(API.diabetes),
//                       body: {
//                         "fpg": _fpgController.text,
//                         "descrip": condition,
//                       },
//                     );
//                     var response = jsonDecode(res.body);
//                     if (response["success"] == true) {
//                       await showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Center(child: Text("บันทึกข้อมูลสำเร็จ")),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: Text(
//                                   'OK',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     } else {
//                       print("พบข้อผิดพลาด: ${response["message"]}");
//                     }
//                   } catch (e) {
//                     print(e);
//                   }
//                 } else {
//                   _showSnackBar("กรุณากรอกข้อมูลให้ครบถ้วน");
//                 }
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }