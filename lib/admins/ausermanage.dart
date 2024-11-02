import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:health/api_connection/api_connetion.dart';

class UserManagement extends StatefulWidget {
  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();  // Fetch users when the screen loads
  }

  Future<void> fetchUsers() async {
  try {
    var res = await http.get(Uri.parse(API.user));
    // print("Status Code: ${res.statusCode}");
    // print("Response Body: '${res.body}'");  // Print response body

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      List<dynamic> fetchedUsers = jsonDecode(res.body);

      // Filter out any users with null ids or names
      setState(() {
        users = fetchedUsers.where((user) {
          return user['id'] != null && user['name'] != null;
        }).toList();
      });
    } else {
      throw Exception('Failed to load users');
    }
  } catch (e) {
    print("Error: $e");
  }
}

Future<void> editUser(int userId, String newName, String newEmail, String newPwd) async {
  try {
    var res = await http.post(Uri.parse(API.user), body: {
      'action': 'edit',
      'id': userId.toString(),
      'name': newName,
      'email':newEmail,
      'password':newPwd,
      // '':
    });
    // Rest of the code remains unchanged
  } catch (e) {
    print(e);
  }
}

Future<void> deleteUser(int userId) async {
  try {
    var res = await http.post(Uri.parse(API.user), body: {
      'action': 'delete',
      'id': userId.toString(),
    });
    // Rest of the code remains unchanged
  } catch (e) {
    print(e);
  }
}

 // Display dialog to edit user
void showEditDialog(int? userId, String? currentName, String? currentEmail, String? currentPwd) {
  if (userId == null || currentName == null || currentEmail == null || currentPwd == null) {
    print("Error: userId, currentName, currentEmail, or currentPwd is null");
    return;
  }

  TextEditingController nameController = TextEditingController(text: currentName);
  TextEditingController emailController = TextEditingController(text: currentEmail);
  TextEditingController passwordController = TextEditingController(text: currentPwd);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'New Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'New Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              editUser(userId, nameController.text, emailController.text, passwordController.text);
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'User Management',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: users.length,
  itemBuilder: (context, index) {
    var user = users[index];
    return ListTile(
      title: Text(user['name']),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Open edit dialog, include email and password
              showEditDialog(
                int.parse(user['id']),
                user['name'],
                user['email'],  // Ensure this field is included in your API response
                user['password'] // Ensure this field is included in your API response
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Confirm and delete user
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Delete'),
                    content: Text('Do you want to delete this user?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          deleteUser(int.parse(user['id']));
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  },
)
          ],
        ),
      ),
    );
  }
}
