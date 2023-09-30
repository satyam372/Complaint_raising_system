// import 'package:flutter/material.dart';
// import 'assign_complain_page.dart';
//
// class AdministratorPage extends StatefulWidget {
//   const AdministratorPage({Key? key}) : super(key: key);
//
//   @override
//   _AdministratorPageState createState() => _AdministratorPageState();
// }
//
// class _AdministratorPageState extends State<AdministratorPage> {
//   String? selectedDepartment;
//   TextEditingController employeeIdController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Administrator Page'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('images/signup.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 50),
//                 child: Text(
//                   'WELCOME!!',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: DropdownButtonFormField<String>(
//                   value: selectedDepartment,
//                   items: [
//                     DropdownMenuItem<String>(
//                       child: Text('Biomedical'),
//                       value: 'Biomedical',
//                     ),
//                     DropdownMenuItem<String>(
//                       child: Text('IT'),
//                       value: 'IT',
//                     ),
//                     DropdownMenuItem<String>(
//                       child: Text('Maintenance'),
//                       value: 'Maintenance',
//                     ),
//                     DropdownMenuItem<String>(
//                       child: Text('Facility'),
//                       value: 'Facility',
//                     ),
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       selectedDepartment = value;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'Select Department',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: TextField(
//                   controller: employeeIdController,
//                   onChanged: (value) {
//                     setState(() {
//
//                     });
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Enter Employee ID',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   onChanged: (value) {
//                     setState(() {
//
//                     });
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Enter Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   String employeeID = employeeIdController.text;
//                   String password = passwordController.text;
//
//
//                   if (selectedDepartment == 'IT') {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AssignComplainPage(
//                           department: selectedDepartment!,
//                         ),
//                       ),
//                     );
//                   } else if (selectedDepartment == 'Biomedical') {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AssignComplainPage(
//                           department: selectedDepartment!,
//                         ),
//                       ),
//                     );
//                   } else if (selectedDepartment == 'Maintenance') {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AssignComplainPage(
//                           department: selectedDepartment!,
//                         ),
//                       ),
//                     );
//                   } else if (selectedDepartment == 'Facility') {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AssignComplainPage(
//                           department: selectedDepartment!,
//                         ),
//                       ),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blue[900],
//                 ),
//                 child: Text('LOGIN'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }