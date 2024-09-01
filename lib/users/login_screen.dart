import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:health/admins/alogin.dart';
import 'package:health/admins/asignup.dart';
import 'package:health/api_connection/api_connetion.dart';
// import 'package:health/api_connection/api_connetion.dart';
// import 'package:health/users/model/user.dart';
import 'package:health/users/signup_screen.dart';
// import 'package:health/users/uerPreferences/user_preferences.dart';
import 'package:health/widget/navbar.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) :super(key: key);
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var isObsecure = true.obs;


   Future<void> Login() async {
  if (email.text != "" && password.text != "") {
    try {
      // Update this IP address to your computer's local network IP if needed
      // String url = "http://10.160.40.13/myapp/login.php";
      var res = await http.post(Uri.parse(API.login),
        body: {
          "email": email.text,
          "password": password.text
        }
      );
      var response = jsonDecode(res.body);
      if (response["success"] == true) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NavBarRoots()));
      } else {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(child: Text("ไม่สามารถเข้าสู่ระบบได้ \nโปรดตรวจสอบรหัสหรืออีเมล",
              style: TextStyle(fontSize: 18),)),
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
    } catch (e) {
      print(e);
    }
  } else {
   await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(child: Text("กรุณากรอกข้อมูลให้ครบถ้วน",
              style: TextStyle(fontSize: 18),)),
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
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, cons){
          return ConstrainedBox(
            constraints:BoxConstraints(
              minHeight: cons.maxHeight,

            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: 
                    TextButton(
                    onPressed: () {
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => NavBarRoots()));
                    },
                    child: Text(
                      'SKIP',
                      style: TextStyle(color: Color.fromARGB(255, 4, 73, 192), fontSize: 16),
                    ),
                    ),
                  ),
                  
                  //LoginScreen header
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 265,
                    child: Image.asset('images/logo1.png'),
                  ),
                  //LoginSceen Sign-in form
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      // decoration: BoxDecoration(
                      //   color: Color.fromARGB(255, 47, 139, 138),
                      //   // border: BorderRadius.all(
                      //   //   Redius.circular(60),
                      //   // ),
                      //   boxShadow:[BoxShadow(
                      //     blurRadius: 8,
                      //     color: Colors.black26,
                      //     offset: Offset(0, -3),
                      //   )] 
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                        child: Column(
                          children: [
                            Form(
                            key:formKey,
                            child: Column(
                              children: [
                                //email
                                TextField(
                                  controller: email,
                                  // validator:(val) => val == ""? "Please write email" : null,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    hintText: "Email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    fillColor: Color.fromARGB(255, 192, 227, 255),
                                    filled: true,
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                //password
                                Obx(() => 
                                TextField(
                                  controller: password,
                                  obscureText: isObsecure.value,
                                  // validator:(val) => val == ""? "Please write Password" : null,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.vpn_key_sharp,
                                      color: Colors.black,
                                    ),
                                    suffixIcon: Obx(() => GestureDetector(
                                      onTap: (){
                                        isObsecure.value = !isObsecure.value;
                                      },
                                      child: Icon(
                                        isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                        color: Colors.black,
                                      ),
                                    )),
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    fillColor:Color.fromARGB(255, 192, 227, 255),
                                    filled: true,
                                  ),
                                ),),
                                const SizedBox(height: 24,),
                                //button
                                Material(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    onTap: (){
                                      Login();
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 28,
                                      ),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ), 
                            ),
                            SizedBox(height: 18,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have Account?"),
                                TextButton(
                                  onPressed: (){
                                     Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=> SignUpScreen()
                                      )
                                    );
                                  }, 
                                  child: const Text("SignUp here",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                            const Text("or",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 4, 51, 89),
                              fontSize: 16,  
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Are you an admin?"),
                                TextButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=> ALoginScreen()
                                      )
                                    );
                                  }, 
                                  child: const Text("Click here",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ), 
          );
        }),
    );
  }
}

// class LoginScreen extends StatefulWidget{
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController email = TextEditingController();
//   final TextEditingController password = TextEditingController();
//   bool passToggle = true;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.white,
//       child: SingleChildScrollView(
//         child: SafeArea(
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {
//                     // Navigator.push(context, MaterialPageRoute(builder: (context) => NavBarRoots()));
//                   },
//                   child: Text(
//                     'SKIP',
//                     style: TextStyle(color: Color.fromARGB(255, 4, 73, 192), fontSize: 16),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Image.asset('images/health_check.jpg'),
//               ),
//               SizedBox(height: 10),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: TextField(
//                   controller: email,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     label: Text('Enter Email'),
//                     prefixIcon: Icon(Icons.email),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: TextField(
//                   controller: password,
//                   obscureText: passToggle ? true : false,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     label: Text('Enter Password'),
//                     prefixIcon: Icon(Icons.lock),
//                     suffixIcon: InkWell(
//                       onTap: () {
//                         setState(() {
//                           passToggle = !passToggle;
//                         });
//                       },
//                       child: passToggle
//                           ? Icon(CupertinoIcons.eye_slash_fill)
//                           : Icon(CupertinoIcons.eye_fill),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: Material(
//                     color: Color.fromARGB(255, 4, 73, 192),
//                     borderRadius: BorderRadius.circular(10),
//                     child: InkWell(
//                       // onTap: login,
//                       // child: Padding(
//                       //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
//                       //   child: Center(
//                       //     child: Text(
//                       //       "Log In",
//                       //       style: TextStyle(
//                       //           color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
//                       //     ),
//                       //   ),
//                       // ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Don't have any account?",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.blueGrey,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
//                     },
//                     child: Text(
//                       'Create Account',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 4, 235, 112),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Are you admin",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.blueGrey,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Click here',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 4, 235, 112),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }