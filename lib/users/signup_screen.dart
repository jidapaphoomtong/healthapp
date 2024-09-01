import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health/api_connection/api_connetion.dart';
// import 'package:health/api_connection/api_connetion.dart';
import 'package:health/users/login_screen.dart';
// import 'package:health/users/model/user.dart';
import 'package:health/widget/navbar.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({Key? key}) :super(key: key);
  
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
  var formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var isObsecure = true.obs;

  Future<void> insertrecord() async {
  if (name.text != "" && email.text != "" && password.text != "") {
    // AlertDialog(
    //       title:Text("บันทึกข้อมูลสำเร็จ"),
    //       actions: [TextButton(
    //         onPressed: (){Navigator.push(context, MaterialPageRoute(
    //                   builder: (context)=> LoginScreen()
    //                 ));}, 
    //         child: Text('OK')),],
    //     );
    try {
      // Update this IP address to your computer's local network IP if needed
      // String url = "http://10.160.40.13/myapp/signup.php";
      var res = await http.post(Uri.parse(API.signUp),
        body: {
          "name": name.text,
          "email": email.text,
          "password": password.text
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
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LoginScreen()
                    ));
                  },
                  child: Text('OK', style: TextStyle(fontSize: 16),),
                ),
              ],
            );
          },
        );
        name.clear();
        email.clear();
        password.clear();
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

  // validateUserEmail() async{
  //   try
  //   {
  //     var res = await http.post(
  //       Uri.parse(API.validateEmail),
  //       body: {
  //         'u_email':email.text.trim(),
  //       }
  //     ); 
  //     if(res.statusCode == 200) //from flutter app the connection with api to server -- successfully
  //     {
  //       var resBody = jsonDecode(res.body);      
  //       if(resBody['emailFound'] == true)
  //       {
  //         // Fluttertoast.showToast(msg: "อีเมลนี้มีบัญชีผู้ใช้แล้ว โปรดลองอีเมลอื่น");
  //          AlertDialog(
  //         title:Center(child: Text("อีเมลนี้มีบัญชีผู้ใช้แล้ว โปรดลองอีเมลอื่น")),
  //         actions: [TextButton(
  //           onPressed: (){
  //             // Navigator.push(context, MaterialPageRoute(
  //             //         builder: (context)=> LoginScreen(),
  //             //       ));
  //             Navigator.of(context).pop();
  //           }, 
  //           child: Center(child: Text('OK'))),],
  //         );
  //       }
  //       else
  //       {
  //         registerAndSaveUserRecord();
  //       }
  //     }
  //   }
  //   catch(e)
  //   {
  //     print(e.toString());
  //     Fluttertoast.showToast(msg:e.toString());
  //   }
  // }

  // registerAndSaveUserRecord() async
  // {
  //   User userModel = User(
  //     name.text.trim(), 
  //     email.text.trim(), 
  //     password.text.trim(),
  //   );

  //   try
  //   {
  //     var res = await http.post(
  //       Uri.parse(API.signUp),
  //       body:userModel.toJson(),
  //     );

  //     if(res.statusCode == 200)
  //     {
  //       var resBodyOfSignUp = jsonDecode(res.body);
  //       if(resBodyOfSignUp['success'] == true)
  //       {
  //         AlertDialog(
  //         title:Center(child: Text("บันทึกข้อมูลสำเร็จ")),
  //         actions: [TextButton(
  //           onPressed: (){Navigator.push(context, MaterialPageRoute(
  //                     builder: (context)=> LoginScreen(),
  //                   ));}, 
  //           child: Center(child: Text('OK'))),],
  //         );
  //         setState(() {
  //         name.clear();
  //         email.clear();
  //         password.clear();
  //         },);
  //       }
  //     }
  //     else
  //     {
  //       // Fluttertoast.showToast(msg: "เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้ง");
  //       AlertDialog(
  //         title:Center(child: Text("เกิดข้อผิดพลาด โปรดลองใหม่อีกครั้ง")),
  //         actions: [TextButton(
  //           onPressed: (){
  //             // Navigator.push(context, MaterialPageRoute(
  //             //         builder: (context)=> LoginScreen()
  //             //       ));
  //             Navigator.of(context).pop();
  //           }, 
  //           child: Center(child: Text('OK'))),
  //         ],
  //       );
  //     }
  //   }
  //   catch(e)
  //   {
  //     print(e.toString());
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }


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
                                //name
                                TextField(
                                  controller: name,
                                  // validator:(val) => val == ""? "Please write email" : null,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    hintText: "Full Name",
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
                                      // if(formKey.currentState!.validate()){
                                      //   // validated the email
                                      //   validateUserEmail();
                                      // }
                                      insertrecord(); 
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 28,
                                      ),
                                      child: Text(
                                        "SignUp",
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
                                const Text("Already have an Account?"),
                                TextButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>LoginScreen()
                                      )
                                    );
                                  }, 
                                  child: const Text("Login here",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                            // const Text("or",
                            // style: TextStyle(
                            //   color: const Color.fromARGB(255, 4, 51, 89),
                            //   fontSize: 16,  
                            //   ),
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text("Are you an admin?"),
                            //     TextButton(
                            //       onPressed: (){}, 
                            //       child: const Text("SignUp here",
                            //         style: TextStyle(color: Colors.blue),
                            //       ),
                            //     ),
                            //   ],
                            // ),
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
