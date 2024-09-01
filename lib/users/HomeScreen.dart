import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/healthcheck/BMI.dart';
import 'package:health/healthcheck/Diabetes.dart';
import 'package:health/healthcheck/Pressure.dart';
import 'package:http/http.dart' as http;
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> imgList = [
    'images/B1.jpg',
    'images/P1.jpg',
    'images/F1.jpg',
  ];

  final hospital = 'https://med.msu.ac.th/suddhavej/';
  final medicien = 'https://www.facebook.com/UniPharmMSU';
  final healthS = 'https://www.thaihealth.or.th/category/%E0%B8%82%E0%B9%88%E0%B8%B2%E0%B8%A7%E0%B8%AA%E0%B8%A3%E0%B9%89%E0%B8%B2%E0%B8%87%E0%B8%AA%E0%B8%B8%E0%B8%82/%E0%B8%82%E0%B9%88%E0%B8%B2%E0%B8%A7%E0%B8%AA%E0%B8%B8%E0%B8%82%E0%B8%A0%E0%B8%B2%E0%B8%9E/';
  final group = 'https://www.facebook.com/profile.php?id=100063732813635';
  final emergency = 'https://www.facebook.com/rcpmsu';
  
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

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
                    "Hello Tester",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // SizedBox(width: 10,),
                  // Image.asset('images/4042356.png',width: 35,)
                  // Icon(Icons.circle, weight: 35,),
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
            Row(
              children: [
                SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: (){
                        _launchURL(medicien);
                      }, 
                      icon: Icon(Icons.medical_information),
                      iconSize: 40,
                      color: Color.fromARGB(255, 14, 34, 149),
                    ),
                    Text('Medical'),
                    SizedBox(height: 18,),
                    IconButton(
                      onPressed: (){
                         _launchURL(healthS);
                      }, 
                      icon: Icon( Icons.health_and_safety),
                      iconSize: 40,
                      color: Color.fromARGB(255, 14, 34, 149),
                    ),
                    Text('Health and Safety'),
                  ],
                ),
                SizedBox(width: 40,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: (){
                         _launchURL(hospital);
                      }, 
                      icon: Icon(Icons.home_work),
                      iconSize: 40,
                      color: Color.fromARGB(255, 14, 34, 149),
                    ),
                    Text('Hospital'),
                    SizedBox(height: 18,),
                     IconButton(
                      onPressed: (){
                         _launchURL(group);
                      }, 
                      icon: Icon(Icons.group),
                      iconSize: 40,
                      color: Color.fromARGB(255, 14, 34, 149),
                    ),
                    Text('Group'),
                  ],
                ),
                SizedBox(width: 45,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: (){
                        _launchURL(emergency);
                      }, 
                      icon: Icon(IconData(0xE9A7,
  fontFamily: 'HumanitarianIcons',
  fontPackage: 'humanitarian_icons',
),
),
                      iconSize: 40,
                      color: Color.fromARGB(255, 14, 34, 149),
                    ),
                    Text('Emergency'),
                    SizedBox(height: 18,),
                     IconButton(
                      onPressed: (){
                        // Navigator.of(context).pop();
                      },
                      icon: Icon( Icons.support_agent),
                      iconSize: 40,
                      color: Color.fromARGB(255, 14, 34, 149),
                    ),
                    Text('Support'),
                  ],
                ),
              ],
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
