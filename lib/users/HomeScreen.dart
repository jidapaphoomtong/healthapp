// import 'dart:convert';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:health/healthcheck/BMI.dart';
// import 'package:health/healthcheck/Diabetes.dart';
// import 'package:health/healthcheck/Pressure.dart';
// import 'package:http/http.dart' as http;


// class HomeScreen extends StatefulWidget{
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List icon =[Icons.medical_information,
//               Icons.health_and_safety,
//               Icons.local_hospital, 
//               Icons.bloodtype,
//               Icons.group,
//               Icons.support_agent];

//   List title = ['Medical','Health and safe','Hospital','Bloodtype','Group','Support'];

//    final List<String> imgList = [
//     'https://via.placeholder.com/600x400.png?text=Image+1',
//     'https://via.placeholder.com/600x400.png?text=Image+2',
//     'https://via.placeholder.com/600x400.png?text=Image+3',
//   ];


//   String name = '';

//   Future<void> fetchName() async {
//     String url = "http://10.160.40.13/myapp/get_name.php?user_id=1"; // Update user_id as needed
//     try {
//       var res = await http.get(Uri.parse(url));
//       var response = jsonDecode(res.body);
//       if (response['success'] == true) {
//         setState(() {
//           name = response['name'];
//         });
//       } else {
//         print("Error: ${response['message']}");
//       }
//     } catch (e) {
//       print("Exception: $e");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchName();
//   }

//   @override
//   Widget build(BuildContext context){
//     return SingleChildScrollView(
//       padding: EdgeInsets.only(top: 40),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(padding: EdgeInsets.symmetric(horizontal: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Hello $name", 
//               style: TextStyle(
//                 fontSize: 35,
//                 fontWeight: FontWeight.w500,
//               ) ,),
//           //     SizedBox( height: 15,),
//           //     CarouselSlider(
//           // options: CarouselOptions(
//           //   height: 400.0,
//           //   enlargeCenterPage: true,
//           //   autoPlay: true,
//           //   aspectRatio: 16 / 9,
//           //   autoPlayCurve: Curves.fastOutSlowIn,
//           //   enableInfiniteScroll: true,
//           //   autoPlayAnimationDuration: Duration(milliseconds: 800),
//           //   viewportFraction: 0.8,
//           // ),
//           // items: imgList.map((item) => Container(
//           //   child: Center(
//           //     child: Image.network(item, fit: BoxFit.cover, width: 1000),
//           //   ),
//           // )).toList()),
//               ],
//           ),
//           ),
//           SizedBox(height: 30,),
//           Padding(
//             padding: EdgeInsets.only(left: 15),
//             child: Text('Do you want to check your health?',
//             style: TextStyle(
//               fontSize: 23,
//               fontWeight: FontWeight.w500,
//               color: Colors.black54,
//             ),),
//             ),
//           SizedBox(height: 20),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [Material(
//           color: Color.fromARGB(255, 4, 73, 192),
//           borderRadius: BorderRadius.circular(10),
//           child: InkWell(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context)=>ShowdataPopup()
//               ));
//             },
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
//               child : Center (child: Text("Pressure",
//               style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
//             ),
//           ),
//           ),
//         ),
//         SizedBox(height: 10),
//         Material(
//           color: Color.fromARGB(255, 4, 73, 192),
//           borderRadius: BorderRadius.circular(10),
//           child: InkWell(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context)=>BMIScreen()
//               ));
//             },
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
//               child : Center (child: Text("BMI",
//               style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
//             ),
//           ),
//           ),
//         ),
//         SizedBox(height: 10),
//         Material(
//           color: Color.fromARGB(255, 4, 73, 192),
//           borderRadius: BorderRadius.circular(10),
//           child: InkWell(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context)=>DiabetesScreen()
//               ));
//             },
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
//               child : Center (child: Text("Diabetes",
//               style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
//             ),
//           ),
//           ),
//         ),
//         ],
//         ),
//         SizedBox(height: 15),
//         Padding(padding: EdgeInsets.only(left: 15),
//         child: Text('Other',
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.w500,
//               color: Colors.black54,
//         ),),
//         ),
//         GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3),
//             itemCount: icon.length,
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(), 
//             itemBuilder: (context, index){
//               return InkWell(
//                 onTap: (){},
//                 child: Container(
//                   margin: EdgeInsets.all(10),
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   // decoration: BoxDecoration(
//                   //   boxShadow: [
//                   //     BoxShadow(
//                   //       color:Colors.black12,
//                   //       blurRadius: 4,
//                   //       spreadRadius: 2, 
//                   //     ),
//                   //   ],
//                   // ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Icon(icon[index]),
//                       Text(title[index],
//                       // style:TextStyle(
//                       //   fontSize: 18),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:health/healthcheck/BMI.dart';
import 'package:health/healthcheck/Diabetes.dart';
import 'package:health/healthcheck/Pressure.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<IconData> icons = [
    Icons.medical_information,
    Icons.health_and_safety,
    Icons.local_hospital,
    Icons.bloodtype,
    Icons.group,
    Icons.support_agent
  ];

  List<String> titles = [
    'Medical', 'Health and Safe', 'Hospital', 'Bloodtype', 'Group', 'Support'
  ];

  final List<String> imgList = [
    'images/B1.jpg',
    'images/P1.jpg',
    'images/F1.jpg',
  ];

  String name = '';

  Future<void> fetchName() async {
    String url = "http://10.160.40.13/myapp/get_name.php?user_id=1"; // Update user_id as needed
    try {
      var res = await http.get(Uri.parse(url));
      var response = jsonDecode(res.body);
      if (response['success'] == true) {
        setState(() {
          name = response['name'];
        });
      } else {
        print("Error: ${response['message']}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello Michel",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Image.asset('images/4042356.png',width: 35,)
                ],
              ),
            ),
            SizedBox(height: 15),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: imgList.map((item) => Container(
                child: Center(
                  child: Image.asset(item, fit: BoxFit.cover, ),
                ),
              )).toList(),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Do you want to check your health?',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildHealthCheckButton(context, "Pressure",PressureScreen() ),
                SizedBox(height: 10),
                _buildHealthCheckButton(context, "BMI", BMIScreen()),
                SizedBox(height: 10),
                _buildHealthCheckButton(context, "Diabetes", DiabetesScreen()),
              ],
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Other',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: icons.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(icons[index]),
                        Text(titles[index]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthCheckButton(BuildContext context, String text, Widget screen) {
    return Material(
      color: Color.fromARGB(255, 4, 73, 192),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
