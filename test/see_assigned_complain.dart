import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SeeAssignedComplainPage extends StatefulWidget {

  final String employeeId; // Declare the employeeId variable
  const SeeAssignedComplainPage({Key? key, required this.employeeId}) : super(key: key);
  @override
  _SeeAssignedComplainPageState createState() => _SeeAssignedComplainPageState();
}

class _SeeAssignedComplainPageState extends State<SeeAssignedComplainPage> {

  List<String> peopleList = ["1", "2", "3"];
  get employeeId => widget.employeeId;
  List<Map<String, dynamic>> complaints = [];

  Map<String, String?> selectedAssignees = {};
  Map<String, String?> selectedDates = {};
  TextEditingController complaintIdController = TextEditingController();
  TextEditingController probController = TextEditingController();
  TextEditingController subProbController = TextEditingController();
  TextEditingController descrpController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController phNoController = TextEditingController();
  TextEditingController empIdController = TextEditingController();
  TextEditingController extensionController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController engineerAssignController = TextEditingController();

  Map<String, bool> assignedComplaints = {};

  @override
  void initState() {
    super.initState();
    fetchData(employeeId);
  }

  @override
  void dispose() {
    probController.dispose();
    subProbController.dispose();
    descrpController.dispose();
    priorityController.dispose();
    floorController.dispose();
    phNoController.dispose();
    departmentController.dispose();
    extensionController.dispose();
    empIdController.dispose();
    engineerAssignController.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> fetchData(String employeeId) async {
    final url = Uri.parse(
      "http://192.168.255.224:8080/php_connection/see_assigned_complaint.php?emp_id=$employeeId",
    );
    print("Fetching data for employee ID: $employeeId");

    final response = await http.get(url, headers: {'Accept-Encoding': 'utf-8'});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print("Response body: ${response.body}");

      return List<Map<String, dynamic>>.from(jsonData);
    } else {
      print("Response body: ${response.body}");

      throw Exception('Failed to fetch data');
    }
  }









  Future<void> sendDataToServer(String id) async {
    var url = Uri.parse(
        'http://192.168.255.224:8080/php_connection/engineer_update.php');

    try {
      var completeButtonText = 'completed';
      String date = DateTime.now().toString();
      var response = await http.post(url, body: {

        // 'department': departmentController.text,
        // 'extension': extensionController.text,
        'complaint_id': complaintIdController.text,
        'complete': completeButtonText,
        'Date': date,
      });

      if (response.statusCode == 200) {
        try {
          var responseJson = json.decode(response.body);
          print(responseJson);
          var jsonResponse = responseJson["response"];
          if (jsonResponse == 'error') {
            Fluttertoast.showToast(msg: "Error");
          } else {
            // Mark the complaint as assigned
            setState(() {
              assignedComplaints[id] = true;
            });
            Fluttertoast.showToast(msg: 'Success');
          }
        } catch (e) {
          print("Error parsing JSON: ${e.toString()}");
          print("Response body: ${response.body}");
          Fluttertoast.showToast(msg: "complaint completed");
        }
      } else {
        Fluttertoast.showToast(msg: "Error: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }


  @override



  Widget _buildActionWidget(Map<String, dynamic> complaint) {
    String userStatus = complaint['prob'];
    String engineStatus = complaint['engine_status'];

    if (userStatus == 'submitted') {
      return ElevatedButton(
        onPressed: () {
          // Logic to handle assigning the complaint
        },
        child: Text('Assign'),
      );
    } else if (userStatus == 'assigned' && engineStatus == 'completed') {
      return ElevatedButton(
        onPressed: () {
          // Logic to handle closing the complaint
        },
        child: Text('Close'),
      );
    } else {
      // Return an empty container if no action is applicable
      return Container();
    }
  }






  Widget _buildComplaintCard(Map<String, dynamic> complaint) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(complaint['prob']),
        subtitle: Text(complaint['engine_status']),
        trailing: _buildActionWidget(complaint), // Create a function to build the action widget
      ),
    );
  }




  Widget _buildListView(List<Map<String, dynamic>> complaints) {
    return ListView.builder(
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> complaint = complaints[index];
        return _buildComplaintCard(complaint); // Create a function to build the complaint card
      },
    );
  }

















  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track complaint'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              fetchData(employeeId);
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/dashboard.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchData(employeeId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                final complaints = snapshot.data!;
                return _buildListView(complaints);
              } else {
                return Text("No data available.");
              }
            },
          ),
        ),
      ),
    );
  }




  Widget _buildActionTableCell(Map<String, dynamic> complaint) {
    final bool isAssigned = assignedComplaints[complaint['complaint_id']] ?? false;
    String? complaintId = complaint['complaint_id'];

    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: isAssigned
              ? null // Disable the button if the complaint is assigned
              : () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Assign Complaint'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTextField(complaintIdController, 'complaint_id',
                          initialValue: complaintId ?? ''),
                      //
                      // _buildTextField(probController, 'Problem', initialValue: complaint['prob']),
                      // _buildTextField(subProbController, 'subproblem', initialValue: complaint['sub_prob']),
                      // _buildTextField(descrpController, 'description', initialValue: complaint['descrp']),
                      // _buildTextField(priorityController, 'priority', initialValue: complaint['priority']),
                      // _buildTextField(floorController, 'floor', initialValue: complaint['floor']),
                      // _buildTextField(phNoController, 'phone number', initialValue: complaint['ph_no']),
                      // _buildTextField(empIdController, 'employee Id', initialValue: complaint['emp_id']),
                      // _buildAssigneeDropDown(complaint['prob']),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String id = complaintIdController.text;
                        String prob = probController.text;
                        String sub_prob = subProbController.text;
                        String descrp = descrpController.text;
                        String priority = priorityController.text;
                        String floor = floorController.text;
                        String ph_no = phNoController.text;
                        String emp_id = empIdController.text;
                        String extension = extensionController.text;
                        String department = departmentController.text;
                        String assignee = selectedAssignees[prob] ?? '';
                        // sendDataToServer(id);
                        setState(() {
                          sendDataToServer(id);
                          Text('completed');
                        });
                        Navigator.pop(context);
                      },
                      child:  Text('complete'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Completed'),
        ),
      ),
    );
  }

  // Widget _buildActionTableCell(Map<String, dynamic> complaint) {
  //   //TextEditingController dateController = TextEditingController(text: DateTime.now().toString());
  //
  //   final bool isAssigned = assignedComplaints[complaint['complaint_id']] ?? false;
  //   String? complaintId = complaint['complaint_id'];
  //   if (complaintId != null && complaintId.isNotEmpty) {
  //     final bool isAssigned = assignedComplaints[complaintId] ?? false;
  //
  //   }
  //
  //
  //   return TableCell(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: ElevatedButton(
  //         onPressed: isAssigned
  //             ? null // Disable the button if complaint is already assigned
  //             : () {
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return AlertDialog(
  //                 title: const Text('completed'),
  //                 content: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     // _buildTextField(complaintIdController, 'complaint_id', initialValue: complaintId ?? ''),
  //                     //
  //                     // _buildTextField(probController, 'Problem', initialValue: complaint['prob']),
  //                     // _buildTextField(subProbController, 'subproblem', initialValue: complaint['sub_prob']),
  //                     // _buildTextField(descrpController, 'description', initialValue: complaint['descrp']),
  //                     // _buildTextField(priorityController, 'priority', initialValue: complaint['priority']),
  //                     // _buildTextField(floorController, 'floor', initialValue: complaint['floor']),
  //                     // _buildTextField(phNoController, 'phone number', initialValue: complaint['ph_no']),
  //                     // _buildTextField(empIdController, 'employee Id', initialValue: complaint['emp_id']),
  //                     // //_buildTextField(dateController, 'date', initialValue: DateTime.now().toString()),
  //                     // _buildAssigneeDropDown(complaint['prob']),
  //
  //                   ],
  //                 ),
  //                 actions: [
  //                   TextButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: const Text(''),
  //                   ),
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       String assignButtonText = 'Assign';
  //                       String id = complaintIdController.text;
  //                       String prob = probController.text;
  //                       String sub_prob = subProbController.text;
  //                       String descrp = descrpController.text;
  //                       String priority = priorityController.text;
  //                       String floor = floorController.text;
  //                       String ph_no = phNoController.text;
  //                       String emp_id = empIdController.text;
  //                       String assignee = selectedAssignees[prob] ?? '';
  //
  //                       sendDataToServer(id);
  //                       Navigator.pop(context);
  //
  //                     },
  //
  //                     child: const Text('completed'),
  //                   ),
  //                 ],
  //               );
  //             },
  //           );
  //         },
  //         child: Text('completed'),
  //       ),
  //     ),
  //   );
  // }


  Widget _buildTable(List<Map<String, dynamic>> complaints) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FixedColumnWidth(100),
            1: FixedColumnWidth(120),
            2: FixedColumnWidth(120),
            3: FixedColumnWidth(120),
            4: FixedColumnWidth(120),
            5: FixedColumnWidth(120),
            6: FixedColumnWidth(120),
            7: FixedColumnWidth(100),
            8: FixedColumnWidth(100),
            9: FixedColumnWidth(120),
            10: FixedColumnWidth(120),
            11: FixedColumnWidth(120),
            12: FixedColumnWidth(120),
            13: FixedColumnWidth(120),
            14:FixedColumnWidth(120),

          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
              ),
              children: [
                _buildTableCell('ph_no', bold: true),
                _buildTableCell('prob', bold: true),
                _buildTableCell('sub_prob', bold: true),
                _buildTableCell('priority', bold: true),
                _buildTableCell('photo', bold: true),
                _buildTableCell('description', bold: true),
                _buildTableCell('floor', bold: true),
                _buildTableCell('complaint_id', bold: true),
                _buildTableCell('status', bold: true),
                _buildTableCell('extension', bold: true),
                _buildTableCell('employee name', bold: true),// New column header for Extension
                _buildTableCell('department', bold: true),
                _buildTableCell('emp_id', bold: true),// New column header for Department
                _buildTableCell('action', bold: true),
              ],
            ),
            for (int index = 0; index < complaints.length; index++)
              TableRow(
                children: [
                  _buildTableCell(complaints[index]['ph_no']),
                  _buildTableCell(complaints[index]['prob']),
                  _buildTableCell(complaints[index]['sub_prob']),
                  _buildTableCell(complaints[index]['priority']),
                  _buildTableCell(complaints[index]['photo']),
                  _buildTableCell(complaints[index]['descrp']),
                  _buildTableCell(complaints[index]['floor']),
                  _buildTableCell(complaints[index]['complaint_id']),
                  _buildTableCell(complaints[index]['engine_status']),
                  _buildTableCell(complaints[index]['extension']),
                  _buildTableCell(complaints[index]['employee_name']),// New cell for Extension
                  _buildTableCell(complaints[index]['department']),
                  _buildTableCell(complaints[index]['emp_id']),// New cell for Department
                  _buildActionTableCell(complaints[index]),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteTableCell(String? complaintId) {
    final bool isAssigned = assignedComplaints[complaintId] ?? false;
    if (complaintId != null && complaintId.isNotEmpty) {
      final bool isAssigned = assignedComplaints[complaintId] ?? false;
      if (isAssigned) {
        // If the complaint is assigned and frozen, return an empty cell
        return TableCell(
          child: Container(),
        );
      } else {
        // If the complaint is not assigned or not frozen, return the delete icon button
        return TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                String id = complaintIdController.text;
                // Call the deleteComplaint method to delete the complaint
                //deletecomplaint(id);
              },
              icon: Icon(Icons.delete),
            ),
          ),
        );
      }
    } else {
      // If the complaintId is null or empty, return an empty cell
      return TableCell(
        child: Container(),
      );
    }
  }

  Widget _buildTableCell(String text, {bool bold = false}) {
    if (text.startsWith('data:image')) {
      // If the text is an image URL, decode the base64-encoded image data
      List<int> imageData = base64Decode(text.split(',')[1]);
      return TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              'http://192.168.62.224:8080/php_connection/images/64b2eae734744.jpg',
              width: 100, // Set the width and height as per your requirement
              height: 100,
            ),
          ));
    } else {
      // For non-image cells, display regular text
      Color? textColor;
      Color? backgroundColor;
      switch (text) {
        case 'submitted':
          textColor = Colors.black;
          backgroundColor = Colors.lightBlueAccent; // Light blue accent color for 'submitted' state
          break;
        case 'assigned':
          textColor = Colors.black;
          backgroundColor = Colors.orange[200]; // Orange[200] color for 'assigned' state
          break;
        case 'completed':
          textColor = Colors.black;
          backgroundColor = Colors.pink[200]; // Pink[200] color for 'completed' state
          break;
        case 'closed':
          textColor = Colors.black;
          backgroundColor = Colors.lightGreen; // Light green color for 'closed' state
          break;
        default:
          textColor = Colors.black; // Default text color for other states
          backgroundColor = Colors.transparent; // Default transparent background color
      }

      return TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: backgroundColor,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text , // Replace null with an empty string
                    style: TextStyle(
                      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }


  Widget _buildTextField(TextEditingController controller, String labelText,
      {String? initialValue}) {
    if (initialValue != null) {
      controller.text = initialValue;
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    );
  }
}