// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'api_conn.dart';
// import 'package:sql_conn/sql_conn.dart';
// import 'user.dart';
// import 'dashboard.dart';
// import 'signup.dart';
//
//
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:sql_conn/sql_conn.dart';
//
//
//
//
// void main()
// {
//   WidgetsFlutterBinding.ensureInitialized();
// }
// class MyLogin extends StatefulWidget {
//   const MyLogin({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => MyLoginState();
// }
//
//
//
//
// class MyLoginState extends State<MyLogin> {
//   var formkey = GlobalKey<FormState>();
//     TextEditingController empidcontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//
//
//   Future<void> register() async {
//     var url = Uri.parse("http://192.168.62.224:8080/php_connection/validate_user.php");
//
//     try {
//       var response = await http.post(url, body: {
//         "username": empidcontroller.text,
//         "password": passwordcontroller.text,
//       });
//
//       if (response.statusCode == 200) {
//         try {
//           var responseJson = json.decode(response.body);
//           print(responseJson);
//           var jsonResponse = responseJson["response"];
//           if (jsonResponse == "error") {
//             Fluttertoast.showToast(msg: "This user already exists");
//           } else {
//             Fluttertoast.showToast(msg: "Registration successful");
//           }
//         } catch (e) {
//           print("Error parsing JSON: ${e.toString()}");
//           print("Response body: ${response.body}");
//           Fluttertoast.showToast(msg: "Error parsing server response");
//         }
//       } else {
//         Fluttertoast.showToast(msg: "Error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print(e.toString());
//       Fluttertoast.showToast(msg: "Error: ${e.toString()}");
//     }
//   }
//
//
//
//   String? validateUserId(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter ID';
//     }
//     return null;
//   }
//
//
//
//
//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter password';
//     }
//     return null;
//   }
//
//
//   verifyUserData() async {
//     User usermodel = User(
//       '1',
//       empidcontroller.text.trim(),
//       passwordcontroller.text.trim(),
//     );
//
//     try {
//       var res = await http.post(
//         Uri.parse('http://192.168.0.110/php_connection/connection.php'),
//         body: usermodel.toJson(),
//       );
//
//       if (res.statusCode == 200) {
//         var resbody = jsonDecode(res.body);
//         if (resbody['success'] == true) {
//           Fluttertoast.showToast(msg: 'Database connected');
//         } else {
//           Fluttertoast.showToast(msg: 'Database connection failed');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Error: ${res.statusCode}');
//       }
//     } catch (e) {
//       print(e.toString());
//       Fluttertoast.showToast(msg: ': ${e.toString()}');
//     }
//   }
//
//
//   //
//   // verifyUserData()  async{
//   //
//   //   User usermodel = User(
//   //     1,
//   //     empidcontroller.text.trim(),
//   //     passwordcontroller.text.trim(),
//   //   );
//   //   //
//   //   try {
//   //     var res = await http.post(
//   //       Uri.parse('http://localhost:8080/php_connection/connection.php'),
//   //       body: usermodel.toJson(),
//   //     );
//   //
//   //     if (res.statusCode == 200) {
//   //       var resbody = jsonDecode(res.body);
//   //       if (resbody['success'] == true) {
//   //         Fluttertoast.showToast(msg: 'Signup successful');
//   //       } else {
//   //         Fluttertoast.showToast(msg: 'Error: Signup failed');
//   //       }
//   //     } else {
//   //       Fluttertoast.showToast(msg: 'Error: ${res.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     print(e.toString());
//   //     Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
//   //   }
//   //   // try {
//   //   //   var res = await http.post(
//   //   //     Uri.parse(API.hostconnect),
//   //   //     body: {
//   //   //       'user_id': empidcontroller.text.trim(),
//   //   //       'password': passwordcontroller.text.trim(),
//   //   //     },
//   //   //   );
//   //   //
//   //   //   if (res.statusCode == 200) {
//   //   //     Fluttertoast.showToast(msg: 'success');
//   //   //   } else {
//   //   //     Fluttertoast.showToast(msg: 'Error connecting to the API');
//   //   //   }
//   //   // } catch (e) {
//   //   //   print(e.toString());
//   //   //   Fluttertoast.showToast(msg: 'hi');
//   //   // }
//   //
//   //
//   // }
//
//
//
//   validateUserIdAsync() async {
//     try {
//       var res = await http.post(
//         Uri.parse(API.hostconnect),
//         body: {
//           'user_id': empidcontroller.text.trim(),
//           'password': passwordcontroller.text.trim(),
//         },
//       );
//
//       if (res.statusCode == 200) {
//         // Handle API response
//         Fluttertoast.showToast(msg: 'success');
//       } else {
//         Fluttertoast.showToast(msg: 'Error connecting to the API');
//       }
//     } catch (e) {
//       print(e.toString());
//       Fluttertoast.showToast(msg: 'Error connecting to the API');
//     }
//
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('images/login.jpg'),
//           fit: BoxFit.cover,
//         ),
//         color: Colors.transparent,
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             Container(
//               padding: const EdgeInsets.only(left: 47, top: 180),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Form(
//                       key: formkey,
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             controller: empidcontroller,
//                             validator: validateUserId,
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(
//                                 Icons.email,
//                                 color: Colors.lightBlue,
//                               ),
//
//
//
//                               labelText: "emp_id",
//
//
//
//                               border: OutlineInputBorder(),
//                               enabledBorder: OutlineInputBorder(),
//                               disabledBorder: OutlineInputBorder(),
//                               contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 14,
//                                 vertical:6,  ),
//                               fillColor: Colors.white,
//                               filled: true,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           TextFormField(
//                             controller: passwordcontroller,
//                             validator: validatePassword,
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(
//                                 Icons.vpn_key_off_sharp  ,
//                                 color: Colors.lightBlue,
//                               ),
//
//
//                               labelText: "password",
//                               border: OutlineInputBorder(),
//                               enabledBorder: OutlineInputBorder(),
//                               disabledBorder: OutlineInputBorder(),
//                               contentPadding: const EdgeInsets.symmetric(),
//                               fillColor: Colors.white,
//                               filled: true,
//                             ),
//                           ),
//                           SizedBox(height: 10,),
//                           Material(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.circular(30),
//                             child: InkWell(
//                               onTap: () {
//                                 if (formkey.currentState!.validate()) {
//                                   register();
//                                 }
//                               },
//                               borderRadius: BorderRadius.circular(30),
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10,
//                                   horizontal: 20,
//                                 ),
//                                 child: Text(
//
//
//
//                                   "login",
//
//
//
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//
//
//
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )),
//                 ],
//               ),
//             ),
//             // Rest of the code...
//           ],
//         ),
//       ),
//     );
//   }
// }

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

class MyLogin extends StatefulWidget {

  final String employeeId; // Declare the employeeId variable

  const MyLogin({Key? key, required this.employeeId}) : super(key: key);
 // const MyLogin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyLoginState();
}

class MyLoginState extends State<MyLogin> {
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController=TextEditingController();
  get employeeId => widget.employeeId;



  Future<void> sendDataToServer(employeeId) async {

    var url = Uri.parse('http://192.168.255.224:8080/php_connection/update_password.php');

    try {
    //  var assignButtonText = 'Assigned';
      String date = DateTime.now().toString();
      var response = await http.post(url, body: {

        'password':newPasswordController.text,
        'emp_id':employeeIdController.text ,

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












  Future<bool> login() async {
    var url = Uri.parse("http://192.168.255.224:8080/php_connection/user_validation.php");
    var employeeId = employeeIdController.text;
    var password = passwordController.text;

    if (employeeId.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Employee ID and Password are required");
      return false;
    }

    try {
      var response = await http.post(url, body: {
        "username": employeeId,
        "password": password,
      });

      if (response.statusCode == 200) {
        var trimmedResponse = response.body.trim();
        print("Response body: $trimmedResponse");

        if (trimmedResponse == "success") {
          Fluttertoast.showToast(msg: "Login successful");
          // Navigate to the Dashboard page here
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard(employeeId: employeeId)),
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/login.jpg'),
          fit: BoxFit.cover,
        ),
        color: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 47, top: 180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Internal Complaint System',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 139, 1), // Dark blue color
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.3,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: employeeIdController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      hintText: 'Employee-Id',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.55,
                left: 50,
              ),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(0, 0, 139, 1), // Dark blue color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () async {
                  var employeeId = employeeIdController.text;
                  var password = passwordController.text;

                  if (employeeId.isEmpty || password.isEmpty) {
                    Fluttertoast.showToast(msg: "Employee ID and Password are required");
                  } else {
                    var loggedIn = await login();
                    if (loggedIn) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard(employeeId: employeeId)),
                      );
                    }
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.55,
                left: 240,
              ),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(0, 0, 139, 1), // Dark blue color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Change password',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
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
                              sendDataToServer(employeeId);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
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
            ),

            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.65,
                left: 100,
                right: 100,
              ),
              child: Column(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color.fromRGBO(0, 0, 139, 1), // Dark blue color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'ADMINISTRATOR',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdministratorPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
