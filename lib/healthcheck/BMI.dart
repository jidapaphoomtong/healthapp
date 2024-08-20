import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:flutter_3d_choice_chip/flutter_3d_choice_chip.dart';
import 'package:health/healthcheck/score_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class BMIScreen extends StatefulWidget {
  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String result = '';

  void _BMI(){
    final double weight = double.tryParse(weightController.text) ?? 0;
    final double height = double.tryParse(heightController.text) ?? 0;

    if(weight<=0 || height <=0){
      setState(() {
        result = 'Please enter weight and height value';
      });
      return;
    }

    final double bmi = weight / ((height/100)*(height/100));
    showDialog(context: context, 
  builder: (BuildContext context){
    return AlertDialog(
      title: Center(child: Text('ค่าดัชนีมวลกาย')),
      content: Text('You BMI is ${bmi.toStringAsFixed(2)}'),
      actions: <Widget>[
        TextButton(
            onPressed: (){Navigator.of(context).pop();
            }, 
            child: Text('OK')),
        TextButton(
            onPressed: (){
              bmiRecord();
            }, 
            child: Text('Save')),
      ],
    );
  }
  );
  }

  Future<void> bmiRecord() async {
  if (weightController !="" && heightController!="" ) {
    try {
      // Update this IP address to your computer's local network IP if needed
      String url = "http://172.20.10.5/myapp/bmi.php";
      var res = await http.post(Uri.parse(url),
        body: {
          "weight" : weightController.text,
          "height" : heightController.text,
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
}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title : Text('BMI')),
      body: 
      SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
            child: Column(
              children: <Widget>[
              SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Image.asset('images/bmi.png'),
                        ),
              SizedBox(height: 20,),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                labelText: "Weight (kg)",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide : const BorderSide(
                  color: Colors.blue,
                  width: 5,
                ),),),
              ),
              SizedBox(height: 10),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                labelText: "Height (cm)",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide : const BorderSide(
                  color: Colors.blue,
                  width: 5,
                  )
                ),
              ),),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _BMI,
                child: Text('Calculate BMI'),),
              SizedBox(height: 20,),
              Text(result,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,)
            ],
          )
          )
        )
      );
    }
  }
// class BMIScreen extends StatefulWidget {
//   const BMIScreen({Key? key}) : super(key: key);

//   @override
//   _BMIScreenState createState() => _BMIScreenState();
// }
// class _BMIScreenState extends State<BMIScreen> {
//   int _gender = 0;
//   int _height = 150;
//   int _age = 30;
//   int _weight = 50;
//   bool _isFinished = false;
//   double _bmiScore = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text("BMI Calculator"),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             child: Card(
//               elevation: 12,
//               shape: const RoundedRectangleBorder(),
//               child: Column(
//                 children: [
//                   //Lets create widget for gender selection
//                   GenderWidget(
//                     onChange: (genderVal) {
//                       _gender = genderVal;
//                     },
//                   ),
//                   SizedBox(height: 20,),
//                   HeightWidget(
//                     onChange: (heightVal) {
//                       _height = heightVal;
//                     },
//                   ),
//                   SizedBox(height: 20,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       AgeWeightWidget(
//                           onChange: (ageVal) {
//                             _age = ageVal;
//                           },
//                           title: "Age",
//                           initValue: 30,
//                           min: 0,
//                           max: 100),
//                       AgeWeightWidget(
//                           onChange: (weightVal) {
//                             _weight = weightVal;
//                           },
//                           title: "Weight(Kg)",
//                           initValue: 50,
//                           min: 0,
//                           max: 200)
//                     ],
//                   ),
//                   SizedBox(height: 20,),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 20, horizontal: 60),
//                     child: SwipeableButtonView(
//                         isFinished: _isFinished,
//                         onFinish: () async {
//                           await Navigator.push(
//                               context,
//                               PageTransition(
//                                   child: ScoreScreen(
//                                     bmiScore: _bmiScore,
//                                     age: _age,
//                                   ),
//                                   type: PageTransitionType.fade));

//                           setState(() {
//                             _isFinished = false;
//                           });
//                         },
//                         onWaitingProcess: () {
//                           //Calculate BMI here
//                           calculateBmi();

//                           Future.delayed(Duration(seconds: 1), () {
//                             setState(() {
//                               _isFinished = true;
//                             });
//                           });
//                         },
//                         activeColor: Colors.blue,
//                         buttonWidget: const Icon(
//                           Icons.arrow_forward_ios_rounded,
//                           color: Colors.black,
//                         ),
//                         buttonText: "CALCULATE"),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   void calculateBmi() {
//     _bmiScore = _weight / pow(_height / 100, 2);
//   }
// }


// class AgeWeightWidget extends StatefulWidget {
//   final Function(int) onChange;
//   final String title;
//   final int initValue;
//   final int min;
//   final int max;
//   const AgeWeightWidget(
//       {Key? key,
//       required this.onChange,
//       required this.title,
//       required this.initValue,
//       required this.min,
//       required this.max})
//       : super(key: key);

//   @override
//   _AgeWeightWidgetState createState() => _AgeWeightWidgetState();
// }

// class _AgeWeightWidgetState extends State<AgeWeightWidget> {
//   int counter = 0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     counter = widget.initValue;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Card(
//             elevation: 12,
//             shape: const RoundedRectangleBorder(),
//             child: Column(children: [
//               Text(
//                 widget.title,
//                 style: const TextStyle(fontSize: 20, color: Colors.grey),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     InkWell(
//                       child: const CircleAvatar(
//                         radius: 12,
//                         backgroundColor: Colors.blue,
//                         child: Icon(Icons.remove, color: Colors.white),
//                       ),
//                       onTap: () {
//                         setState(() {
//                           if (counter > widget.min) {
//                             counter--;
//                           }
//                         });
//                         widget.onChange(counter);
//                       },
//                     ),
//                     const SizedBox(
//                       width: 15,
//                     ),
//                     Text(
//                       counter.toString(),
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                           color: Colors.black87,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     const SizedBox(
//                       width: 15,
//                     ),
//                     InkWell(
//                       child: const CircleAvatar(
//                         radius: 12,
//                         backgroundColor: Colors.blue,
//                         child: Icon(Icons.add, color: Colors.white),
//                       ),
//                       onTap: () {
//                         setState(() {
//                           if (counter < widget.max) {
//                             counter++;
//                           }
//                         });
//                         widget.onChange(counter);
//                       },
//                     ),
//                   ],
//                 ),
//               )
//             ])));
//   }
// }

// class GenderWidget extends StatefulWidget {
//   final Function(int) onChange;
//   const GenderWidget({Key? key, required this.onChange}) : super(key: key);
//   @override
//   _GenderWidgetState createState() => _GenderWidgetState();
// }

// class _GenderWidgetState extends State<GenderWidget> {
//   int _gender = 0;

//   final ChoiceChip3DStyle selectedStyle = ChoiceChip3DStyle(
//       topColor: Colors.grey[200]!,
//       backColor: Colors.grey,
//       borderRadius: BorderRadius.circular(20));

//   final ChoiceChip3DStyle unselectedStyle = ChoiceChip3DStyle(
//       topColor: Colors.white,
//       backColor: Colors.grey[300]!,
//       borderRadius: BorderRadius.circular(20));

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ChoiceChip3D(
//               border: Border.all(color: Colors.grey),
//               style: _gender == 1 ? selectedStyle : unselectedStyle,
//               onSelected: () {
//                 setState(() {
//                   _gender = 1;
//                 });
//                 widget.onChange(_gender);
//               },
//               onUnSelected: () {},
//               selected: _gender == 1,
//               child: Column(
//                 children: [
//                   Image.asset(
//                     "images/4042356.png",
//                     width: 50,
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   const Text("Male")
//                 ],
//               )),
//           const SizedBox(
//             width: 30,
//           ),
//           ChoiceChip3D(
//               border: Border.all(color: Colors.grey),
//               style: _gender == 2 ? selectedStyle : unselectedStyle,
//               onSelected: () {
//                 setState(() {
//                   _gender = 2;
//                 });
//                 widget.onChange(_gender);
//               },
//               selected: _gender == 2,
//               onUnSelected: () {},
//               child: Column(
//                 children: [
//                   Image.asset(
//                     "images/4042422.png",
//                     width: 50,
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   const Text("Female")
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }

// class HeightWidget extends StatefulWidget {
//   final Function(int) onChange;

//   const HeightWidget({Key? key, required this.onChange}) : super(key: key);

//   @override
//   _HeightWidgetState createState() => _HeightWidgetState();
// }

// class _HeightWidgetState extends State<HeightWidget> {
//   int _height = 150;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Card(
//           elevation: 12,
//           shape: const RoundedRectangleBorder(),
//           child: Column(
//             children: [
//               const Text(
//                 "Height",
//                 style: TextStyle(fontSize: 25, color: Colors.grey),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     _height.toString(),
//                     style: const TextStyle(fontSize: 40),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   const Text(
//                     "cm",
//                     style: TextStyle(fontSize: 20, color: Colors.grey),
//                   )
//                 ],
//               ),
//               Slider(
//                 min: 0,
//                 max: 240,
//                 value: _height.toDouble(),
//                 thumbColor: Color.fromARGB(255, 0, 27, 109),
//                 onChanged: (value) {
//                   setState(() {
//                     _height = value.toInt();
//                   });
//                   widget.onChange(_height);
//                 },
//               )
//             ],
//           )),
//     );
//   }
// }
