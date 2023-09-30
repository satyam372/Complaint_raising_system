// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'dashboard.dart';
// import 'signup.dart';
// import 'adminstrator.dart';
// import 'dart:ui';
//
// class MyLogin extends StatefulWidget {
//   const MyLogin({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => MyLoginState();
// }
//
// class MyLoginState extends State<MyLogin> {
//   TextEditingController employeeIdController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   Future<void> login() async {
//     var url = Uri.parse("http://192.168.62.224:8080/php_connection/validate_user.php");
//
//     try {
//       var response = await http.post(url, body: {
//         "username": employeeIdController.text,
//         "password": passwordController.text,
//       });
//
//       if (response.statusCode == 200) {
//         try {
//           var responseJson = json.decode(response.body);
//           print(responseJson);
//           var jsonResponse = responseJson["response"];
//           if (jsonResponse == "error") {
//             Fluttertoast.showToast(msg: "Invalid username or password");
//           } else {
//             Fluttertoast.showToast(msg: "Login successful");
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) =>  Dashboard(employeeId: employeeId)),
//             );
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
//                   Text(
//                     'Internal Complaint System',
//                     style: TextStyle(
//                       color: Color.fromRGBO(0, 0, 139, 1), // Dark blue color
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.3,
//               ),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: employeeIdController,
//                     decoration: InputDecoration(
//                       fillColor: Colors.grey.shade100,
//                       hintText: 'Employee-Id',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       fillColor: Colors.grey.shade100,
//                       hintText: 'Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             Container(
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.55,
//                 left: 50,
//               ),
//               child: OutlinedButton(
//                 style: OutlinedButton.styleFrom(
//                   primary: Colors.white,
//                   backgroundColor: Color.fromRGBO(0, 0, 139, 1), // Dark blue color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 child: Text(
//                   'LOGIN',
//                   style: TextStyle(fontSize: 20.0),
//                 ),
//                 onPressed: () {
//
//
//                   login();
//
//                    Navigator.push(
//                      context,
//                     MaterialPageRoute(builder: (context) =>  Dashboard(employeeId: employeeId)),
//                   );
//                 },
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.55,
//                 left: 240,
//               ),
//               child: Column(
//                 children: [
//                   OutlinedButton(
//                     style: OutlinedButton.styleFrom(
//                       primary: Colors.white,
//                       backgroundColor: Color.fromRGBO(0, 0, 139, 1), // Dark blue color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: Text(
//                       'SIGNUP',
//                       style: TextStyle(fontSize: 20.0),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const MySignup()),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     "Don't have an account?",
//                     style: TextStyle(color: Colors.black87),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.65,
//                 left: 100,
//                 right: 100,
//               ),
//               child: Column(
//                 children: [
//                   OutlinedButton(
//                     style: OutlinedButton.styleFrom(
//                       primary: Colors.white,
//                       backgroundColor: Color.fromRGBO(0, 0, 139, 1), // Dark blue color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     child: Text(
//                       'ADMINISTRATOR',
//                       style: TextStyle(fontSize: 20.0),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => AdministratorPage()),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//



// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
//
// class IT extends StatefulWidget {
//   const IT({Key? key}) : super(key: key);
//
//   @override
//   _ITState createState() => _ITState();
// }
//
// class _ITState extends State<IT> {
//   TextEditingController selectITIssueController = TextEditingController();
//   TextEditingController selectHardwareIssueController = TextEditingController();
//   TextEditingController selectSoftwareIssueController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController problemDescriptionController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   TextEditingController timeController = TextEditingController();
//   TextEditingController priorityLevelController = TextEditingController();
//   TextEditingController selectRequiredFloorController = TextEditingController();
//   TextEditingController imageDataController = TextEditingController();
//
//   late File imageFile;
//   //  late String imageData;
//   var imageData;
//
//   Future<void> register() async {
//     var url = Uri.parse("http://192.168.62.224:8080/php_connection/it.php");
//
//     try {
//       var response = await http.post(url, body: {
//         "floor":selectRequiredFloorController.text,
//         "ph_no":phoneNumberController.text ,
//         "prob":selectedIssue.toString(),
//         "sub_prob":selectedHardwareIssue.toString(),
//         "descrp":problemDescriptionController.text,
//         "priority":priorityLevelController.text,
//         "time":timeController.text,
//         "date":dateController.text,
//         "photo":imageDataController.text,
//
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
//   late String _selectedImagePath; // Declare as a state variable
//
//   String? _selectedProblemDescription;
//   String? _selectedEmergencyLevel;
//   String? _selectedFloor;
//   bool _showFloorMessage = true;
//   bool _showProblemDescription = true;
//   String selectedIssue = '';
//   String selectedHardwareIssue = '';
//   String selectedSoftwareIssue = '';
//
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;
// //   String? _selectedImagePath;
//
//   @override
//   void dispose() {
//     selectITIssueController.dispose();
//     selectHardwareIssueController.dispose();
//     selectSoftwareIssueController.dispose();
//     phoneNumberController.dispose();
//     problemDescriptionController.dispose();
//     dateController.dispose();
//     timeController.dispose();
//     priorityLevelController.dispose();
//     selectRequiredFloorController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final currentTime =
//     DateFormat.yMd().add_jms().format(DateTime.now()); // Format current time and date
//
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('IT Department'),
//           backgroundColor: Colors.blue,
//         ),
//         body: FractionallySizedBox(
//           widthFactor: 1.0,
//           heightFactor: 1.0,
//           child: Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('images/dashboard.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             currentTime,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Select Date:',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade100,
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               child: TextField(
//                                 controller: dateController,
//                                 readOnly: true,
//                                 onTap: () {
//                                   showDatePicker(
//                                     context: context,
//                                     initialDate: DateTime.now(),
//                                     firstDate: DateTime.now(),
//                                     lastDate: DateTime(2100),
//                                   ).then((selectedDate) {
//                                     if (selectedDate != null) {
//                                       setState(() {
//                                         _selectedDate = selectedDate;
//                                         dateController.text = DateFormat.yMd().format(selectedDate);
//                                       });
//                                     }
//                                   });
//                                 },
//                                 decoration: const InputDecoration(
//                                   hintText: 'Select date',
//                                   border: InputBorder.none,
//                                   contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Select Time:',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade100,
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               child: TextField(
//                                 controller: timeController,
//                                 readOnly: true,
//                                 onTap: () {
//                                   showTimePicker(
//                                     context: context,
//                                     initialTime: TimeOfDay.now(),
//                                   ).then((selectedTime) {
//                                     if (selectedTime != null) {
//                                       setState(() {
//                                         _selectedTime = selectedTime;
//                                         timeController.text = selectedTime.format(context);
//                                       });
//                                     }
//                                   });
//                                 },
//                                 decoration: const InputDecoration(
//                                   hintText: 'Select time',
//                                   border: InputBorder.none,
//                                   contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Select Floor:',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 3),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(30),
//                               border: Border.all(color: Colors.grey.shade100),
//                             ),
//                             child: Row(
//                               children: [
//                                 if (_showFloorMessage)
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 8.0),
//                                     child: Text(
//                                       'Select required floor',
//                                       style: TextStyle(color: Colors.black54),
//                                     ),
//                                   ),
//                                 DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     value: _selectedFloor,
//                                     icon: const Icon(Icons.arrow_drop_down),
//                                     iconSize: 24,
//                                     elevation: 16,
//                                     style: const TextStyle(color: Colors.black),
//                                     onChanged: (String? newValue) {
//                                       setState(() {
//                                         _selectedFloor = newValue;
//                                         _showFloorMessage = false;
//                                       });
//                                     },
//                                     items: <String>[
//                                       '1st Floor',
//                                       '2nd Floor',
//                                       '3rd Floor',
//                                       '4th Floor',
//                                       '5th Floor',
//                                       '6th Floor'
//                                     ].map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(right: 24.0),
//                                           child: Text(value),
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 20),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Enter Phone Number:',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade100,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: TextField(
//                               controller: phoneNumberController,
//                               decoration: const InputDecoration(
//                                 hintText: 'Enter your phone number',
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 20),
//                       const Text(
//                         'Select Problem Description:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         child: Column(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade100,
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               height: 60,
//                               child: DropdownButtonFormField<String>(
//                                 items: [
//                                   DropdownMenuItem<String>(
//                                     child: Text('Select Issue'),
//                                     value: '',
//                                   ),
//                                   DropdownMenuItem<String>(
//                                     child: Text('Hardware issue'),
//                                     value: 'Hardware',
//                                   ),
//                                   DropdownMenuItem<String>(
//                                     child: Text('Software issue'),
//                                     value: 'Software',
//                                   ),
//                                 ],
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedIssue = value ?? '';
//                                   });
//                                 },
//                                 decoration: InputDecoration(
//                                   labelText: 'Select Issue',
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(30),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                             Visibility(
//                               visible: selectedIssue == 'Hardware',
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade100,
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 child: DropdownButtonFormField<String>(
//                                   items: [
//                                     // Items for hardware issues
//                                     DropdownMenuItem<String>(
//                                       child: Text('Issue 1'),
//                                       value: 'Issue 1',
//                                     ),
//                                     DropdownMenuItem<String>(
//                                       child: Text('Issue 2'),
//                                       value: 'Issue 2',
//                                     ),
//                                   ],
//                                   onChanged: (value) {
//                                     setState(() {
//                                       selectedHardwareIssue = value ?? '';
//                                     });
//                                   },
//                                   decoration: InputDecoration(
//                                     labelText: 'Hardware Issue',
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Visibility(
//                               visible: selectedIssue == 'Software',
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade100,
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 child: DropdownButtonFormField<String>(
//                                   items: [
//                                     // Items for software issues
//                                     DropdownMenuItem<String>(
//                                       child: Text('Issue A'),
//                                       value: 'Issue A',
//                                     ),
//                                     DropdownMenuItem<String>(
//                                       child: Text('Issue B'),
//                                       value: 'Issue B',
//                                     ),
//                                   ],
//                                   onChanged: (value) {
//                                     setState(() {
//                                       selectedSoftwareIssue = value ?? '';
//                                     });
//                                   },
//                                   decoration: InputDecoration(
//                                     labelText: 'Software Issue',
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             //nst SizedBox(height: 10),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Problem Description:',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade100,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: TextField(
//                                     controller: problemDescriptionController,
//                                     maxLines: 3,
//                                     decoration: const InputDecoration(
//                                       hintText: 'Enter problem description',
//                                       border: InputBorder.none,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 10),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Add Photo of Problem:',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         _pickImage();// Call the image picker method
//
//                                       },
//
//                                       child: const Text('Add Photo'),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//
//
//
//
//                             const SizedBox(height: 10),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Select Priority Level:',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Row(
//                                   children: [
//                                     Flexible(
//                                       child: RadioListTile<String>(
//                                         title: const Padding(
//                                           padding: EdgeInsets.only(left: 1.0),
//                                           child: Text(
//                                             'High',
//                                             softWrap: false,
//                                             overflow: TextOverflow.fade,
//                                           ),
//                                         ),
//                                         contentPadding: EdgeInsets.zero,
//                                         value: 'red',
//                                         groupValue: _selectedEmergencyLevel,
//                                         onChanged: (String? value) {
//                                           setState(() {
//                                             _selectedEmergencyLevel = value;
//                                             priorityLevelController.text = 'High'; // Update the controller value
//                                           });
//                                         },
//                                         activeColor: Colors.red,
//                                       ),
//                                     ),
//                                     Flexible(
//                                       child: RadioListTile<String>(
//                                         title: const Padding(
//                                           padding: EdgeInsets.only(left: 0.0),
//                                           child: Text(
//                                             'Medium',
//                                             softWrap: false,
//                                             overflow: TextOverflow.fade,
//                                           ),
//                                         ),
//                                         contentPadding: EdgeInsets.zero,
//                                         value: 'orange',
//                                         groupValue: _selectedEmergencyLevel,
//                                         onChanged: (String? value) {
//                                           setState(() {
//                                             _selectedEmergencyLevel = value;
//                                             priorityLevelController.text = 'Medium'; // Update the controller value
//                                           });
//                                         },
//                                         activeColor: Colors.orange,
//                                       ),
//                                     ),
//                                     Flexible(
//                                       child: RadioListTile<String>(
//                                         title: const Padding(
//                                           padding: EdgeInsets.only(left: 8.0),
//                                           child: Text(
//                                             'Low',
//                                             softWrap: false,
//                                             overflow: TextOverflow.fade,
//                                           ),
//                                         ),
//                                         contentPadding: EdgeInsets.zero,
//                                         value: 'yellow',
//                                         groupValue: _selectedEmergencyLevel,
//                                         onChanged: (String? value) {
//                                           setState(() {
//                                             _selectedEmergencyLevel = value;
//                                             priorityLevelController.text = 'Low'; // Update the controller value
//                                           });
//                                         },
//                                         activeColor: Colors.yellow,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 20),
//                             ElevatedButton(
//                               onPressed: () {
//                                 // Handle form submission
//                                 register();
//                               },
//                               child: const Text('Submit'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ]
//                 ),
//               ),
//             ),
//           ),
//         )
//     );
//   }
// }
// // Image picker method
// /* Future<void> _pickImage() async {
//    final ImagePicker _picker = ImagePicker();
//    final XFile? image = await _picker.pickImage(
//      source: ImageSource.gallery, // Change to ImageSource.camera for accessing the camera
//    );
//
//    if (image != null) {
//      // Handle the selected image path here
//      print('Selected image path: ${image.path}');
//    }
//  }
// */
// TextEditingController imageDataController = TextEditingController();
// Future<void> _pickImage() async {
//
//   final ImagePicker _picker = ImagePicker();
//   final XFile? image = await _picker.pickImage(
//     source: ImageSource.camera, // Change to ImageSource.camera for accessing the camera
//   );
//
//   if (image != null) {
//     List<int> bytes = await image.readAsBytes();
//     String imageData = base64Encode(bytes);
//     print('Encoded image data: $imageData');
//     imageDataController.text=imageData;
//
//     // Send the `imageData` to your MySQL database using an API call
//     // final url = Uri.parse("http://192.168.62.224:8080/php_connection/image_test.php"); // Replace with your API endpoint URL
//     // final response = await http.post(
//     //   url,
//     //   body: {'image': imageData},
//     // );
//     //
//     // if (response.statusCode == 200) {
//     //   Fluttertoast.showToast(msg:'Image uploaded successfully!');
//     //
//     // } else {
//     //   Fluttertoast.showToast(msg: 'Failed to upload image. Error: ${response.reasonPhrase}');
//     //
//     // }
//   }
// }