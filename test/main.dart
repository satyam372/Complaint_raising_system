import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'trackcomplain.dart';
import 'complaint_login.dart';
import 'assign_complaint_page_demo.dart';
import 'it.dart';
import 'see_engineers.dart';
import 'see_assigned_complain.dart';
import 'maintainance.dart';
import 'facility.dart';
import 'assign_complaint_page_facility.dart';
import 'assign_complaint_page_biomedical.dart';
import 'assign_complaint_page_maintainance.dart';
import 'dashboard.dart';
import 'adminstrator.dart';
import 'complain_interface.dart';


void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:'MyLogin',
      routes:
      {
       // 'MyLogin': (context) =>  SeeAssignedComplainPage() ,
        'MyLogin':(context)=>MyLogin(employeeId: '',),
        //'MySignup':(context)=>MySignup(),
        'AdministratorPage':(context)=>AdministratorPage(),
        'DashboardState':(context)=>Dashboard(employeeId:'',),
        'AssignComplainPage':(context)=>AssignComplainPage(),
        'ComplainInterfacePage':(context)=>ComplainInterface(),
        'trackComplaint':(context)=>TrackComplaint(employeeId: '',),
      }
  ));
}


//
// import 'dart:convert';
// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         primarySwatch: Colors.blue,
//
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//
//   Future getData()async{
//     var url = Uri.parse("http://192.168.62.224:8080/php_connection/track_complaint.php");
//     var response = await http.get(url);
//     return json.decode(response.body);
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Php Mysql Crud'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditPage(),),);
//           debugPrint('Clicked FloatingActionButton Button');
//         },
//       ),
//       body: FutureBuilder(
//         future: getData(),
//         builder: (context,snapshot){
//           if(snapshot.hasError) print(snapshot.error);
//           return snapshot.hasData
//               ? ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (context,index){
//                 List list = snapshot.data;
//                 return ListTile(
//                   leading: GestureDetector(child: Icon(Icons.edit),
//                     onTap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditPage(list: list,index: index,),),);
//                       debugPrint('Edit Clicked');
//                     },),
//                   title: Text(list[index]['lastname']),
//                   subtitle: Text(list[index]['phone']),
//                   trailing: GestureDetector(child: Icon(Icons.delete),
//                     onTap: (){
//                       setState(() {
//                         var url = Uri.parse("http://192.168.62.224:8080/php_connection/track_complaint.php");
//                         http.post(url,body: {
//                           'id' : list[index]['id'],
//                         });
//                       });
//                       debugPrint('delete Clicked');
//                     },),
//                 );
//               }
//           )
//               : CircularProgressIndicator();
//         },
//       ),
//     );
//   }
// }