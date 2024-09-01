import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health/api_connection/api_connetion.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class ScoreScreen extends StatelessWidget {
  final double bmiScore;

  final int age;

  String? bmiStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;

  ScoreScreen({Key? key, required this.bmiScore, required this.age})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    setBmiInterpretation();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BMI Score"),
      ),
      body: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Text(
                    //   "คะแนนของคุณ",
                    //   style: TextStyle(fontSize: 30, color: Colors.blue),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrettyGauge(
                      gaugeSize: 300,
                      minValue: 0,
                      maxValue: 40,
                      segments: [
                        GaugeSegment('UnderWeight', 18.5, Color.fromARGB(255, 166, 229, 168)),
                        GaugeSegment('Normal', 6.4, Colors.green),
                        GaugeSegment('OverWeight', 5, Colors.yellow),
                        GaugeSegment('fat', 5, Colors.orange),
                        GaugeSegment('Obese', 5.1, Colors.red),
                      ],
                      valueWidget: Text(
                        bmiScore.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 40),
                      ),
                      currentValue: bmiScore.toDouble(),
                      needleColor: Colors.blue,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      bmiStatus!,
                      style: TextStyle(fontSize: 20, color: bmiStatusColor!),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                      child: Text(
                        bmiInterpretation!,
                        style: const TextStyle(fontSize: 15,),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("ประเมินอีกครั้ง")),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
  onPressed: () async {
    // String url = "http://10.160.40.13/myapp/bmi.php";
    try {
      var res = await http.post(
        Uri.parse(API.bmi),
        body: {
          "bs": bmiScore.toStringAsFixed(1),
          "bi": bmiStatus.toString()
        },
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
              title: Center(child: Text("พบข้อผิดพลาด")),
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
            title: Center(child: Text("พบข้อผิดพลาด")),
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
  child: const Text("บันทึกข้อมูล"),
),
                        const SizedBox(
                          width: 10,
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       // Share.share(
                        //       //     "Your BMI is ${bmiScore.toStringAsFixed(1)} at age $age");
                        //     },
                        //     child: const Text("Share")),
                      ],
                    )
                  ]
                )
              );
  }

  void setBmiInterpretation() {
    if (bmiScore > 30) {
      bmiStatus = "น้ำหนักอยู่ในเกณฑ์อ้วนมาก";
      bmiInterpretation = "ควรเข้าปรึกษาแพทย์เพื่อรับยาในการควบคุมปริมาณน้ำตาลในเลือด พร้อมปรับเปลี่ยนพฤติกรรมการรับประทานอาหารที่ดีต่อสุขภาพ \n ไม่รับประทานอาหารที่เพิ่มมวลไขมันแก่ร่างกาย และหมั่นออกกำลังกายเป็นกิจวัตรประจำวันอย่างสม่ำเสมอ พักผ่อนให้เพียงพอ \n และดื่มน้ำอย่างต่ำ 10-12 แก้วต่อวัน และติดตามผล BMI ตลอดในช่วงควบคุมน้ำหนักอยู่เสมอ";
      bmiStatusColor = Colors.red;
    } else if (bmiScore >= 25) {
      bmiStatus = "น้ำหนักอยู่ในเกณฑ์อ้วน";
      bmiInterpretation = "ควรควบคุมปริมาณไขมันในร่างกายตัวเองแบบเร่งด่วน ทานอาหารที่มีประโยชน์ ออกกำลังกายอย่างสม่ำเสมอ \n ดื่มน้ำให้เพียงพอต่อร่างกาย การพักผ่อนให้เพียงพอ และติดตามผล BMI ตลอดในช่วงควบคุมน้ำหนักอยู่เสมอ";
      bmiStatusColor = Colors.orange;
    } else if(bmiScore >= 23.0){
      bmiStatus = "น้ำหนักเกินมาตรฐาน";
      bmiInterpretation = "เลือกทานอาหารที่มีโปรตีนสูง ออกกำลังกาย และพักผ่อนให้เพียงพอ \n เพื่อลดระดับไขมันให้กลับมาอยู่ในเกณฑ์มาตรฐาน";
      bmiStatusColor = Colors.yellow;
    }else if (bmiScore >= 18.5) {
      bmiStatus = "น้ำหนักสมส่วน";
      bmiInterpretation = "รับประทานอาหารที่มีประโยชน์ และออกกำลังกายอย่างสม่ำเสมอเพื่อคงความสมดุล";
      bmiStatusColor = Colors.green;
    } else if (bmiScore < 18.5) {
      bmiStatus = "น้ำหนักต่ำกว่าเกณฑ์";
      bmiInterpretation = "ออกกำลังกายควบคู่กับการรับประทานอาหารที่มีส่วนประกอบโปรตีนสูง \n ช่วยทำให้กล้ามเนื้อแข็งแรงและมีสารอาหารมากพอไปซ่อมแซมการทำงานของอวัยวะภายในได้อย่างเพียงพอ";
      bmiStatusColor =Color.fromARGB(255, 166, 229, 168);
    }
  }
}
