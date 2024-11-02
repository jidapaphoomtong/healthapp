import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:health/admins/asignup.dart';
import 'package:health/api_connection/api_connetion.dart';
import 'package:health/users/login_screen.dart';
import 'package:health/widget/navbar.dart';
import 'package:http/http.dart' as http;

class ALoginScreen extends StatefulWidget{
  const ALoginScreen({Key? key}) :super(key: key);
  
  @override
  State<ALoginScreen> createState() => _ALoginScreenState();
}

class _ALoginScreenState extends State<ALoginScreen>{

  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var isObsecure = true.obs;


   Future<void> Login() async {
  if (email.text != "" && password.text != "") {
    try {
      // Update this IP address to your computer's local network IP if needed
      // String url = "http://10.160.40.13/myapp/alogin.php";
      var res = await http.post(Uri.parse(API.alogin),
        body: {
          "email": email.text,
          "password": password.text
        }
      );
      var response = jsonDecode(res.body);
      if (response["success"] == true) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NavBarRoots(role: 'admin')));
      } else {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(child: const Text("Can not log in \nPlease check your email or password",
              style: TextStyle(fontSize: 18),)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK',style: TextStyle(fontSize: 16),),
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
              title: const Center(child: Text("Please fill in all information completely",
              style: TextStyle(fontSize: 18),)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK',style: TextStyle(fontSize: 16),),
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
                  const SizedBox(height: 80,),
                  
                  //LoginScreen header
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 265,
                    child: Image.asset('images/1794749.png'),
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
                                      borderSide: const BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    fillColor: const Color.fromARGB(255, 192, 227, 255),
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
                                      borderSide: const BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.white60,
                                      )
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    fillColor:const Color.fromARGB(255, 192, 227, 255),
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
                            const SizedBox(height: 18,),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text("Don't have Account?"),
                            //     TextButton(
                            //       onPressed: (){
                            //          Navigator.push(context, MaterialPageRoute(
                            //           builder: (context)=> const AdminScreen()
                            //           )
                            //         );
                            //       }, 
                            //       child: const Text("SignUp here",
                            //         style: TextStyle(color: Colors.green),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const Text("or",
                            // style: TextStyle(
                            //   color: const Color.fromARGB(255, 4, 51, 89),
                            //   fontSize: 16,  
                            //   ),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Are you an user?"),
                                TextButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=> LoginScreen()
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