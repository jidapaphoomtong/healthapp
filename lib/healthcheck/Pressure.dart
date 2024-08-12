import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/api_connection/api_connetion.dart';
import 'package:health/healthcheck/condition_Pressure.dart';
import 'package:http/http.dart' as http;

class PressureScreen extends StatefulWidget {

  @override
  State<PressureScreen> createState() => _PressureScreenState();
  
}

class _PressureScreenState extends State<PressureScreen> {
  final _sysController = TextEditingController();
  final _diaController = TextEditingController();
  final _pulController = TextEditingController();

  void _ShowPressurePop(String sys, String dia, String pul){
  int sysValue = int.parse(sys);
  int diaValue = int.parse(dia);
  int pulValue = int.parse(pul);
  String condition = determineCondition(sysValue, diaValue, pulValue);

  showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text('BloodPressure'),
        content: Text('SYS: $sys mmHg\nDIA: $dia mmHg\nPUL: $pul min\nสภาวะ: $condition'),
        actions: <Widget>[
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            }, 
            child: Text('OK')),
            TextButton(
            onPressed: () async {
              // Navigator.of(context).pop();
              if (_sysController !="" && _diaController !="" && _pulController !="" ) {
    try {
      // Update this IP address to your computer's local network IP if needed
      // String url = "http://10.160.40.13/myapp/pressure.php";
      var res = await http.post(Uri.parse(API.pressure),
        body: {
          "sys" : _sysController.text,
          "dia" : _diaController.text,
          "pul" : _pulController.text,
          "cond" : condition.toString()
          // "cond": determineCondition
        }
      );
      var response = jsonDecode(res.body);
      if (response["success"] == true) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
           return AlertDialog(
              title: Center(child: Text("บันทึกข้อมูลสำเร็จ")),
              actions: [
                TextButton(
                  onPressed: () {
                   Navigator.of(context).pop();
                  },
                  child: Text('OK', style: TextStyle(fontSize: 16),),
                ),
              ],
            );
          },
        );
        _sysController.clear();
        _diaController.clear();
        _pulController.clear();
      } else {
        print("พบข้อผิดพลาด: ${response["message"]}");
      }
    } catch (e) {
      print(e);
    }
  } else {
   await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(child: Text("กรุณากรอกข้อมูลให้ครบถ้วน")),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK',style: TextStyle(fontSize: 16),),
                ),
              ],
            );
          },
        );
  }
            }, 
            child: Text('Save')),
          ],
        );
      }
    );
  }

//   Future<void> Record() async {
//   if (_sysController !="" && _diaController !="" && _pulController !="" ) {
//     try {
//       // Update this IP address to your computer's local network IP if needed
//       String url = "http://172.20.10.5/myapp/pressure.php";
//       var res = await http.post(Uri.parse(url),
//         body: {
//           "sys" : _sysController.text,
//           "dia" : _diaController.text,
//           "pul" : _pulController.text,
//           // "cond": determineCondition
//         }
//       );
//       var response = jsonDecode(res.body);
//       if (response["success"] == true) {
//         await showDialog(
//           context: context,
//           builder: (BuildContext context) {
//            return AlertDialog(
//               title: Center(child: Text("บันทึกข้อมูลสำเร็จ")),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                    Navigator.of(context).pop();
//                   },
//                   child: Text('OK', style: TextStyle(fontSize: 16),),
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         print("พบข้อผิดพลาด: ${response["message"]}");
//       }
//     } catch (e) {
//       print(e);
//     }
//   } else {
//    await showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Center(child: Text("กรุณากรอกข้อมูลให้ครบถ้วน")),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('OK',style: TextStyle(fontSize: 16),),
//                 ),
//               ],
//             );
//           },
//         );
//   }
// }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title : Text('Bloodpressure')),
      body: 
      SingleChildScrollView( 
        child: Padding(padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),

        child: Column(
          children: <Widget>[
          SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 240,
                    child: Image.asset('images/hypertension-01.png'),
                  ),
          SizedBox(height: 15),
          TextField(
            controller: _sysController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
            labelText: "SYS (mmHg)",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide : const BorderSide(
              color: Colors.blue,
              width: 5,
            ),
            ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _diaController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
            labelText: "DIA (mmHg)",
           focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide : const BorderSide(
              color: Colors.blue,
              width: 5,
            ),
            ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _pulController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
            labelText: "PUL (mmHg)",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide : const BorderSide(
              color: Colors.blue,
              width: 5,
            ),
            ),
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue ),
            onPressed: () async {
              String sys = _sysController.text;
              String dia = _diaController.text;
              String pul = _pulController.text;
              if (sys.isNotEmpty && dia.isNotEmpty && pul.isNotEmpty){
                _ShowPressurePop(sys, dia, pul);
              }else{
                await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("กรุณากรอกข้อมูลให้ครบถ้วน",
              style: TextStyle(fontSize: 18),),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK',style: TextStyle(fontSize: 16),),
                ),
              ],
            );
          },
        );
              };
            }, 
            child: Text('ประเมินค่าความดัน', style: TextStyle(fontSize: 18),))
          ],
        )
      ),
    ),
    );
  }
}

