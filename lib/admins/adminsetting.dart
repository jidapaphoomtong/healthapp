import 'package:flutter/material.dart';
import 'package:health/admins/alogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingsPage extends StatelessWidget {
  Future<void> _setLanguage(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', lang);
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
          builder: (context) => ALoginScreen(),
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
        // Implement report issue logic
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Report a Problem"),
              content: TextField(
                decoration: InputDecoration(hintText: "Describe the issue"),
                maxLines: 5,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Here you can handle the report submission
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
        // Implement feedback sending logic
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Send Feedback"),
              content: TextField(
                decoration: InputDecoration(hintText: "Your feedback"),
                maxLines: 5,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Here you can handle feedback submission
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
