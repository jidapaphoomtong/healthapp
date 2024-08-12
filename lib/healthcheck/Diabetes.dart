import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health/api_connection/api_connetion.dart';
import 'package:health/healthcheck/condition_diabetes.dart';
import 'package:http/http.dart' as http;

class DiabetesScreen extends StatefulWidget {
  @override
  State<DiabetesScreen> createState() => _DiabetesScreenState();
}

class _DiabetesScreenState extends State<DiabetesScreen> {
  final TextEditingController _fpgController = TextEditingController();
  
  void _ShowDiabetes(String fpg){
  int fpgValue = int.parse(fpg);

  String condition = determineCondition(fpgValue);

  showDialog(context: context, 
  builder: (BuildContext context){
    return AlertDialog(
      title: Center(child: Text('ข้อมูลน้ำตาลในเลือด')),
      content: Text('FPG: $fpg Mg/dl\nสภาวะ: $condition'),
      actions: <Widget>[
        TextButton(
            onPressed: (){Navigator.of(context).pop();
            }, 
            child: Text('OK')),
        TextButton(
            onPressed: () async {
              if (_fpgController !="" ) {
    try {
      // Update this IP address to your computer's local network IP if needed
      // String url = "http://10.160.40.13/myapp/diabetes.php";
      var res = await http.post(Uri.parse(API.diabetes),
        body: {
          "fpg" : _fpgController.text,
          "descrip":condition.toString()
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
  

 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title : Text('Bloodpressure')),
      body: 
      Padding(padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
        child: Column(
          children: <Widget>[
          SizedBox(height: 15),
          SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 240,
                    child: Image.asset('images/dibetes.jpg'),
                  ),
          SizedBox(height: 30),
          TextField(
            controller: _fpgController,
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
          SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue ),
            onPressed: (){
              String fpg = _fpgController.text;
              if (fpg.isNotEmpty){
                _ShowDiabetes(fpg);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('กรุณากรอกค่าให้ครบถ้วน'),));
              };
            }, 
            child: Text('ประเมินค่าน้ำตาลในเลือด',style: TextStyle(fontSize: 18)))
        ],
      )
        
      ),
    );
  }
}