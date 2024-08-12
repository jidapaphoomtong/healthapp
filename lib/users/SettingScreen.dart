import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:health/users/login_screen.dart';

class SettingScreen extends StatefulWidget{
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:  SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            // ElevatedButton.icon(
            //   onPressed: (){}, 
            //   icon: Icon(Icons.arrow_back), 
            //   label: Text('Setting')),
            Center(child: Text('Setting', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold))),
            SettingsGroup(
              title: 'GENERAL', 
              children: <Widget>[
                buildAccount(context),
                buildNotification(context),
                builLogout(context),
                builDeleteAccount(context),
              ]
            ),
            SizedBox(height: 32,),
            SettingsGroup(
              title: 'FEEDBACK', 
              children: <Widget>[
                buildReport(context),
                buildSendfeedback(context),
              ],
            ),
          ],
        ), 
      ),
    );
  }
  Widget builLogout(context){
    return SimpleSettingsTile(
    title: 'Logout',
    subtitle: '',
    leading: Icon(Icons.delete),
    onTap: (){
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=>LoginScreen()
        ),
      );
    },
    );
  }
  Widget builDeleteAccount(context){
    return SimpleSettingsTile(title: 'Delete Account',
    subtitle: '',
    leading: Icon(Icons.logout),
    onTap: (){},
    );
  }
  Widget buildReport(context){
    return SimpleSettingsTile(title: 'Report',
    subtitle: '',
    leading: Icon(Icons.bug_report),
    onTap: (){},
    );
  }
  Widget buildSendfeedback(context){
    return SimpleSettingsTile(title: 'Send Feedback',
    subtitle: '',
    leading: Icon(Icons.thumb_up),
    onTap: (){},
    );
  }
  Widget buildAccount(context){
    return SimpleSettingsTile(title: 'Account Setting',
    subtitle: 'Privacy, Security, Language',
    leading: Icon(Icons.person),
    onTap: (){
      // Navigator.push(context, MaterialPageRoute(
      // builder: (context)=> AccountScreen()
      // ),);
      },
    // appBar: AppBar(
    //   title: Text('Settings', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
    //   leading: IconButton(
    //     onPressed: (){
    //       // Navigator.push(context, MaterialPageRoute(
    //       //   builder: (context)=> HomeScreen()
    //       // ));  
    //     },
    //     icon: Icon(Icons.arrow_back),
    //   ),
    // ),
    // body: Container(
    //   padding: const EdgeInsets.all(10),
    //   child: ListView(
    //     children: [
    //       SizedBox(height: 40),
    //       Row(
    //         children: [
    //           Icon(Icons.person,
    //           color: Colors.blue,
    //           size: 24,
    //           ),
    //           SizedBox(width: 24,),
    //           Text('Account', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
    //         ],
    //       ),
    //       Divider(height: 20, thickness: 1,),
    //       SizedBox(height: 10,),

    //     ],
    //   ),
    // ),
    );
  }
  Widget buildNotification(context){
    return SimpleSettingsTile(
    title: 'Notification',
    subtitle: 'Newsletter, Add Update',
    leading: Icon(Icons.notifications_active),
    onTap: (){
      //  Navigator.push(context, MaterialPageRoute(
      // builder: (context)=> NotificationScreen()
      // ),);
    },
    );
  }
}