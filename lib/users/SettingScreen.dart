import 'package:flutter/material.dart';
import 'package:health/api_connection/api_connetion.dart';
import 'package:health/users/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;

class SettingScreen extends StatelessWidget {
  Future<void> _setLanguage(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', lang);
  }
    final TextEditingController _reportController = TextEditingController();
    final TextEditingController _feedbackController = TextEditingController();

  Future<void> submitReport() async {
    final reportProblem = _reportController.text;

    // ตรวจสอบให้แน่ใจว่าผู้ใช้ได้กรอกข้อมูลแล้ว
    if (reportProblem.isNotEmpty) {
      // แทนที่ด้วย URL ของ API สำหรับการบันทึกข้อมูล
      final url = Uri.parse(API.submit_report); 
      
      // ส่งข้อมูลไปยัง API โดย POST
      final response = await http.post(
        url,
        body: {'report_problem': reportProblem},
      );

      // ตรวจสอบว่า request สำเร็จหรือไม่
      if (response.statusCode == 200) {
        print('Report submitted successfully');
         SnackBar(content: Text('Report submitted successfully'));
      } else {
        print('Failed to submit report : ${response.body}');
      }
    }
  }

   Future<void> submitFeedback() async {
    final feedback = _feedbackController.text;

    // ตรวจสอบให้แน่ใจว่าผู้ใช้ได้กรอกข้อมูลแล้ว
    if (feedback.isNotEmpty) {
      // URL ของ API สำหรับการบันทึก Feedback
      final url = Uri.parse(API.submit_feedback); 

      // ส่งข้อมูลไปยัง API โดยใช้ POST
      final response = await http.post(
        url,
        body: {'feedback': feedback},
      );

      // ตรวจสอบว่า request สำเร็จหรือไม่
      if (response.statusCode == 200) {
        SnackBar(content: Text('Feedback submitted successfully'));
        print('Feedback submitted successfully');
      } else {
        print('Failed to submit feedback: ${response.body}');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 18.0, left: 16.0, right: 16.0, bottom: 16.0),
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SettingsGroup(
              title: 'GENERAL',
              children: <Widget>[
                buildLogout(context),
                buildDeleteAccount(context),
              ],
            ),
            SettingsGroup(
              title: 'FEEDBACK',
              children: <Widget>[
                buildReport(context),
                buildSendFeedback(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogout(BuildContext context) {
    return SimpleSettingsTile(
      title: 'Logout',
      subtitle: '',
      leading: Icon(Icons.logout),
      onTap: () {
        // Clear user session or token
        SharedPreferences.getInstance().then((prefs) {
          prefs.clear(); // Clear all preferences
        });
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
      },
    );
  }

  Widget buildDeleteAccount(BuildContext context) {
    return SimpleSettingsTile(
      title: 'Delete Account',
      subtitle: '',
      leading: Icon(Icons.delete),
      onTap: () {
        // Implement account deletion logic
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Delete Account"),
              content: Text("Are you sure you want to delete your account? This action cannot be undone."),
              actions: [
                TextButton(
                  onPressed: () {
                    // Call your API to delete the account
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Yes"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("No"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildReport(BuildContext context) {
    return SimpleSettingsTile(
      title: 'Report a Problem',
      subtitle: '',
      leading: Icon(Icons.bug_report),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Report a Problem"),
              content: TextField(
                controller: _reportController, // เพิ่ม controller
                decoration: InputDecoration(hintText: "Describe the issue"),
                maxLines: 5,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // เรียกฟังก์ชัน submitReport เพื่อบันทึกข้อมูล
                    submitReport();
                    Navigator.of(context).pop();
                  },
                  child: Text("Submit"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
    );
  }
   Widget buildSendFeedback(BuildContext context) {
    return SimpleSettingsTile(
      title: 'Send Feedback',
      subtitle: '',
      leading: Icon(Icons.thumb_up),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Send Feedback"),
              content: TextField(
                controller: _feedbackController, // เพิ่ม controller
                decoration: InputDecoration(hintText: "Your feedback"),
                maxLines: 5,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    submitFeedback(); // เรียกฟังก์ชัน submitFeedback เพื่อบันทึกข้อมูล
                    Navigator.of(context).pop();
                  },
                  child: Text("Submit"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

