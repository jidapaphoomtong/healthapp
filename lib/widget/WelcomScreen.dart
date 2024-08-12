import 'package:flutter/material.dart';
import 'package:health/users/login_screen.dart';
import 'package:health/users/signup_screen.dart';
import '../widget/navbar.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(10),
      child: Column(children: [
        SizedBox(height: 30),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>NavBarRoots()
              ));
            },
          child: Text(
            'SKIP',
            style: TextStyle(
              color: Color.fromARGB(255, 4, 73, 192),
              fontSize: 16 ),
            
          ),
          ),
        ),
        SizedBox(height: 50,),
        Padding(padding: EdgeInsets.all(20),
        child: Image.asset('images/health_check.jpg'),
        ),
        SizedBox(height: 50,),
        Text("Health App",
        style: TextStyle(
          color:Color.fromARGB(255, 4, 73, 192),
          fontSize: 35,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          wordSpacing: 2, 
        ),),
         SizedBox(height: 10,),
        Text("You can check your health",
        style: TextStyle(
          color:Color.fromARGB(255, 19, 48, 98),
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),),
        SizedBox(height: 60,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Material(
          color: Color.fromARGB(255, 4, 73, 192),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>LoginScreen()
              ));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
              child: Text("Log In",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
            ),
          ),
        ),
        Material(
          color: Color.fromARGB(255, 4, 73, 192),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: (){
                       Navigator.push(context, MaterialPageRoute(
                      builder: (context)=> SignUpScreen()
                    ));
                    }, 
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
              child: Text("Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
            ),
          ),
        ),
        ],
        ),
      ],),
      ) ,
    );
  }
}