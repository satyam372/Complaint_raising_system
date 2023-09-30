import 'package:flutter/material.dart';
import 'assign_complaint_page_maintainance.dart';
import 'assign_complaint_page_biomedical.dart';
import 'assign_complaint_page_demo.dart';
import 'assign_complaint_page_facility.dart';
import 'complain_interface.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'signup.dart';
import 'adminstrator.dart';
import 'dart:ui';
import 'it.dart';
import 'raiseticket.dart';


class AdministratorPage extends StatefulWidget {
  const AdministratorPage({Key? key}) : super(key: key);

  @override
  _AdministratorPageState createState() => _AdministratorPageState();
}

class _AdministratorPageState extends State<AdministratorPage> {
  String? selectedDepartment;
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();




  Future<bool> login() async {
    var url = Uri.parse("http://192.168.255.224:8080/php_connection/administrator_verification.php");
    var department=selectedDepartment;
    var employeeId = employeeIdController.text;
    var password = passwordController.text;

    if (employeeId.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Employee ID and Password are required");
      return false;
    }

    try {
      var response = await http.post(url, body: {
        "user_id": employeeId,
        "department":selectedDepartment,

        "password": password,
      });

      if (response.statusCode == 200) {
        var trimmedResponse = response.body.trim();
        print("Response body: $trimmedResponse");

        if (trimmedResponse == "success" && selectedDepartment=='IT') {
          Fluttertoast.showToast(msg: "Login successful");
          // Navigate to the Dashboard page here
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AssignComplainPage())
          );
          return true;
        } else if (trimmedResponse.contains("error")) {
          Fluttertoast.showToast(msg: "Invalid username or password");
        } else {
          Fluttertoast.showToast(msg: "Unknown error occurred");
        }
      } else {
        Fluttertoast.showToast(msg: "Error: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }

    return false; // Login was not successful
  }











  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrator Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/signup.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  'WELCOME!!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedDepartment,
                  items: [
                    DropdownMenuItem<String>(
                      child: Text('Biomedical'),
                      value: 'Biomedical',
                    ),
                    DropdownMenuItem<String>(
                      child: Text('IT'),
                      value: 'IT',
                    ),
                    DropdownMenuItem<String>(
                      child: Text('Maintenance'),
                      value: 'Maintenance',
                    ),
                    DropdownMenuItem<String>(
                      child: Text('Facility'),
                      value: 'Facility',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedDepartment = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Department',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: employeeIdController,
                  onChanged: (value) {
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Employee ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {

                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async{
                  var employeeId = employeeIdController.text;
                  var password = passwordController.text;

                  if (selectedDepartment == 'IT') {
                    if (employeeId.isEmpty || password.isEmpty) {
                      Fluttertoast.showToast(msg: "Employee ID and Password are required");
                    }
                    else {
                      var loggedIn = await login();
                      if (loggedIn) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AssignComplainPage()),
                        );
                      }
                    }
                  }
                  else if (selectedDepartment == 'Biomedical') {
                    if (employeeId.isEmpty || password.isEmpty) {
                      Fluttertoast.showToast(msg: "Employee ID and Password are required");
                    }
                    else {
                      var loggedIn = await login();
                      if (loggedIn) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AssignComplainPagebiomedical()),
                        );
                      }
                    }
                  }
                  else if (selectedDepartment == 'Maintenance') {
                    if (employeeId.isEmpty || password.isEmpty) {
                      Fluttertoast.showToast(msg: "Employee ID and Password are required");
                    }
                    else {
                      var loggedIn = await login();
                      if (loggedIn) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AssignComplainPagemaintainance()),
                        );
                      }
                    }
                  }

                  else if (selectedDepartment == 'Facility') {
                    if (employeeId.isEmpty || password.isEmpty) {
                      Fluttertoast.showToast(msg: "Employee ID and Password are required");
                    }
                    else {
                      var loggedIn = await login();
                      if (loggedIn) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AssignComplainPagefacility()),
                        );
                      }
                    }
                  }
                },



                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                ),
                child: Text('LOGIN'),
              ),

            ],
          ),
        ),
      ),

    );
  }
}