import 'package:flutter/material.dart';
import 'raiseticket.dart'; // Import the RaiseTicket widget
import 'trackcomplain.dart';
import 'see_assigned_complain.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'complaint_login.dart';
class Dashboard extends StatefulWidget {
  final String employeeId; // Declare the employeeId variable

  const Dashboard({Key? key, required this.employeeId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  TextEditingController newPasswordController = TextEditingController();
  late Future<Map<String, dynamic>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData(employeeId);
  }

  get employeeId => widget.employeeId;
  Map<String, dynamic> userData = {};

  Future<Map<String, dynamic>> fetchData(String employeeId) async {
    final url = Uri.parse(
      "http://192.168.1.201:8095/php_connection/user_details.php?emp_id=$employeeId",
    );
    print("Fetching data for employee ID: $employeeId");

    final response = await http.get(url, headers: {'Accept-Encoding': 'utf-8'});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print("Response body: ${response.body}");
      return jsonData; // The response is a single Map, not a List
    } else {
      print("Response body: ${response.body}");
      throw Exception('Failed to fetch data');
    }
  }



















  Future<void> sendDataToServer(employeeId) async {

    var url = Uri.parse('http://192.168.1.201:8095/php_connection/update_password.php');

    try {
      var assignButtonText = 'Assigned';
      String date = DateTime.now().toString();
      var response = await http.post(url, body: {

        'password':newPasswordController.text,
        'emp_id':employeeId ,

      });

      if (response.statusCode == 200) {
        print(newPasswordController);
        print(employeeId);

        try {
          print(newPasswordController);
          print(employeeId);
          var responseJson = json.decode(response.body);
          var jsonResponse = responseJson["response"];
          if (jsonResponse == 'error') {
            Fluttertoast.showToast(msg: "Error");
          } else {
            print(newPasswordController);
            print(employeeId);
            // Mark the complaint as assigned
            setState(() {

            });
            Fluttertoast.showToast(msg: 'Success');
            print(newPasswordController);
            print(employeeId);
          }
        } catch (e) {
          print(newPasswordController);
          print(employeeId);

          Fluttertoast.showToast(msg: "password changed successfully");
        }
      } else {
        print(newPasswordController);
        print(employeeId);
        Fluttertoast.showToast(msg: "Error: ${response.statusCode}");
      }
    } catch (e) {
      print(newPasswordController);
      print(employeeId);
      print(e.toString());
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.power_settings_new_sharp),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text(
                 userData['emp_id'] ?? '',
                  style: TextStyle(fontSize: 18),
                ),



                accountEmail: Text(
                  userData['employee_name'] ?? '',

                  style: TextStyle(fontSize: 18),
                ),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(''),
                ),
              ),
            ),
            ListTile(

              title: const Text('Employee_id'),
              subtitle: Text(userData['emp_id'] as String? ?? ''), // Use the fetched employee ID
              leading: Icon(Icons.person),
            ),

            ListTile(

              title: const Text('name'),
              subtitle: Text(userData['employee_name'] as String? ?? ''), // Use the fetched employee ID
              leading: Icon(Icons.person),
            ),

            ListTile(

              title: const Text('department'),
              subtitle: Text(userData['department'] as String? ?? ''), // Use the fetched employee ID
              leading: Icon(Icons.person),
            ),


            ListTile(

              title: const Text('Employee_id'),
              subtitle: Text(userData['emp_id'] as String? ?? ''), // Use the fetched employee ID
              leading: Icon(Icons.person),
            ),



            ListTile(

              title: const Text('extension_no'),
              subtitle: Text(userData['extension'] as String? ?? ''), // Use the fetched employee ID
              leading: Icon(Icons.person),
            ),

            ListTile(

              title: const Text('phone number'),
              subtitle: Text(userData['phone_no'] as String? ?? ''), // Use the fetched employee ID
              leading: Icon(Icons.person),
            ),


            // Add the option to change the password
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Change Password'),
                      content: TextFormField(
                        controller: newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter new password',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            //handleChangePassword();
                            sendDataToServer(employeeId);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Change'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true, // Set background image
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/dashboard.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'images/d1.jpg',
                    height: 90, // Adjust the height as desired
                    width: 90, // Adjust the width as desired
                  ), // Add image above the button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RaiseTicket(employeeId: widget.employeeId)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50), // Set a fixed size for the button
                      primary: Colors.blue.shade900, // Set button color to dark blue
                    ),
                    child: const Text('Raise a Ticket'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Image.asset(
                    'images/d2.jpg',
                    height: 90, // Adjust the height as desired
                    width: 90, // Adjust the width as desired
                  ), // Add image above the button
                  ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TrackComplaint(employeeId: widget.employeeId)),
                      );
                    },

                    // Handle "Close a ticket" button press

                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50), // Set a fixed size for the button
                      primary: Colors.blue.shade900, // Set button color to dark blue
                    ),
                    child: const Text('Track your complain'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Image.asset(
                    'images/d3.jpg',
                    height: 100, // Adjust the height as desired
                    width: 120, // Adjust the width as desired
                  ), // Add image above the button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SeeAssignedComplainPage(employeeId: widget.employeeId)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50), // Set a fixed size for the button
                      primary: Colors.blue.shade900, // Set button color to dark blue
                    ),
                    child: const Text('Assigned Complain'),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
      // Your existing code continues...
      // ... Your existing Scaffold body, images, and buttons ...
    );
  }
}
