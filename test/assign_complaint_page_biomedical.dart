import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AssignComplainPagebiomedical extends StatefulWidget {
  @override
  _AssignComplainPagebiomedicalState createState() => _AssignComplainPagebiomedicalState();
}

class _AssignComplainPagebiomedicalState extends State<AssignComplainPagebiomedical> {
  List<Map<String, dynamic>> complaints = [];
  List<String> peopleList = ["1", "2", "3"];

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
  TextEditingController finaltatController = TextEditingController();
  TextEditingController engineerAssignController = TextEditingController();
  final TextEditingController assignButtonController = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: DateTime.now().toString());
  String date = DateTime.now().toString(); // Get the current date and time

  // TextEditingController dateController = TextEditingController();
  Map<String, bool> assignedComplaints = {};

  @override
  void initState() {
    super.initState();
    fetchData();
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(now);
    //dateTimeController.text = formattedDateTime;
  }

  @override
  void dispose() {
    probController.dispose();
    subProbController.dispose();
    descrpController.dispose();
    priorityController.dispose();
    floorController.dispose();
    phNoController.dispose();
    empIdController.dispose();
    finaltatController.dispose();
    engineerAssignController.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(
      Uri.parse(
          "http://192.168.255.224:8080/php_connection/assigne_complain_biomedical.php"),
      headers: {'Accept-Encoding': 'utf-8'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonData);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> deletecomplaint(String id) async
  {
    var url = Uri.parse(
        "http://192.168.255.224:8080/php_connection/administrator_delete_assigned_complaint.php");

    try {
      var response = await http.post(url, body: {


        'complaint_id': complaintIdController.text,
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
          Fluttertoast.showToast(msg: "Error parsing server response");
        }
      } else {
        Fluttertoast.showToast(msg: "Error: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
    // print(complaintIdController);
    //print(dateTimeController.text);
  }

  Future<void> sendDataToServer(String id,
      String prob,
      String sub_prob,
      String descrp,
      String floor,
      String ph_no,
      String emp_id,
      String priority,

      String assignee,) async {
    var url = Uri.parse(
        'http://192.168.255.224:8080/php_connection/assigned_complaint_biomedical.php');

    try {
      var assignButtonText = 'Assigned';
      String date = DateTime.now().toString();
      var response = await http.post(url, body: {

        'prob': priorityController.text,
        'sub_prob': subProbController.text,
        'descrp': descrpController.text,
        'priority': priorityController.text,
        'floor': floorController.text,
        'ph_no': phNoController.text,
        'emp_id': empIdController.text,
        'finaltat': empIdController.text,
        'engineer_assign': selectedAssignees[prob],
        'complaint_id': complaintIdController.text,
        'assign': assignButtonText,
        'date': date,
      });

      if (response.statusCode == 200) {
        try {
          var responseJson = json.decode(response.body);
          print(responseJson);
          print(date);
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

          print(assignButtonController.text);
          Fluttertoast.showToast(msg: "complaint assigned successfully");
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









  Widget build(BuildContext context) {
    List<Map<String, dynamic>> testComplaints = [
      // Your test complaints data
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign complain Biomedical'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height, // Set the height to the full screen height
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/dashboard.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final complaints = snapshot.data!;
                      return _buildTable(complaints);
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionTableCell(Map<String, dynamic> complaint) {
    final bool isAssigned = assignedComplaints[complaint['complaint_id']] ?? false;
    String? complaintId = complaint['complaint_id'];
    String status = complaint['administrator_status'];

    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (!isAssigned && status != 'Assigned') // Show the "Assign" button only if the complaint is not assigned and status is not "Assigned"
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Assign Complaint'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildTextField(complaintIdController, 'complaint_id', initialValue: complaintId ?? ''),
                            _buildTextField(probController, 'Problem', initialValue: complaint['prob']),
                            _buildTextField(subProbController, 'subproblem', initialValue: complaint['sub_prob']),
                            _buildTextField(descrpController, 'description', initialValue: complaint['descrp']),
                            _buildTextField(priorityController, 'priority', initialValue: complaint['priority']),
                            //_buildTextField(priorityController, 'finaltat', initialValue: complaint['finaltat']),
                            _buildTextField(floorController, 'floor', initialValue: complaint['floor']),
                            _buildTextField(phNoController, 'phone number', initialValue: complaint['ph_no']),
                            _buildTextField(empIdController, 'employee Id', initialValue: complaint['emp_id']),
                            _buildAssigneeDropDown(complaint['prob']),
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
                              String assignButtonText = 'Assign';
                              String id = complaintIdController.text;
                              String prob = probController.text;
                              String sub_prob = subProbController.text;
                              String descrp = descrpController.text;
                              String priority = priorityController.text;
                              String floor = floorController.text;
                              String ph_no = phNoController.text;
                              String emp_id = empIdController.text;
                              String assignee = selectedAssignees[prob] ?? '';
                              String date = dateController.text;
                              sendDataToServer(id, prob, sub_prob, descrp, floor, ph_no, emp_id, priority, assignee);
                              // Mark the complaint as assigned
                              setState(() {
                                assignedComplaints[id] = true;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Assign'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Assign'),
              ),
            if (!isAssigned && status == 'Assigned') // Show the "Alter" button if the complaint is assigned
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Alter Complaint'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildTextField(complaintIdController, 'complaint_id', initialValue: complaintId ?? ''),
                            _buildTextField(probController, 'Problem', initialValue: complaint['prob']),
                            _buildTextField(subProbController, 'subproblem', initialValue: complaint['sub_prob']),
                            _buildTextField(descrpController, 'description', initialValue: complaint['descrp']),
                            _buildTextField(priorityController, 'priority', initialValue: complaint['priority']),
                            //_buildTextField(priorityController, 'finaltat', initialValue: complaint['finaltat']),
                            _buildTextField(floorController, 'floor', initialValue: complaint['floor']),
                            _buildTextField(phNoController, 'phone number', initialValue: complaint['ph_no']),
                            _buildTextField(empIdController, 'employee Id', initialValue: complaint['emp_id']),
                            _buildAssigneeDropDown(complaint['prob']),
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
                              String assignButtonText = 'Assign';
                              String id = complaintIdController.text;
                              String prob = probController.text;
                              String sub_prob = subProbController.text;
                              String descrp = descrpController.text;
                              String priority = priorityController.text;
                              String floor = floorController.text;
                              String ph_no = phNoController.text;
                              String emp_id = empIdController.text;
                              String assignee = selectedAssignees[prob] ?? '';
                              String date = dateController.text;
                              sendDataToServer(id, prob, sub_prob, descrp, floor, ph_no, emp_id, priority, assignee);
                              // Mark the complaint as assigned
                              setState(() {
                                assignedComplaints[id] = true;
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Alter'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Alter'),
              ),
          ],
        ),
      ),
    );
  }
  Widget _buildTable(List<Map<String, dynamic>> complaints) {
    return Expanded(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FixedColumnWidth(150),
                  1: FixedColumnWidth(150),
                  2: FixedColumnWidth(150),
                  3: FixedColumnWidth(150),
                  4: FixedColumnWidth(150),
                  5: FixedColumnWidth(150),
                  6: FixedColumnWidth(150),
                  7: FixedColumnWidth(150),
                  8: FixedColumnWidth(150),
                  9: FixedColumnWidth(150),
                  10: FixedColumnWidth(150),
                  11: FixedColumnWidth(150),
                  12: FixedColumnWidth(150),
                  13: FixedColumnWidth(150),
                  14: FixedColumnWidth(150),
                  15: FixedColumnWidth(150),
                  16: FixedColumnWidth(150),
                  17: FixedColumnWidth(150),
                  18: FixedColumnWidth(150),
                  19: FixedColumnWidth(150),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                    ),
                    children: [
                      _buildTableCell('complaint_id', bold: true),
                      _buildTableCell('prob', bold: true),
                      _buildTableCell('sub_prob', bold: true),
                      _buildTableCell('descrp', bold: true),
                      _buildTableCell('priority', bold: true),
                      _buildTableCell('floor', bold: true),
                      _buildTableCell('ph_no', bold: true),
                      _buildTableCell('photo', bold: true),
                      _buildTableCell('emp_id', bold: true),
                      _buildTableCell('ticket_raise', bold: true),
                      _buildTableCell('admin assign time', bold: true),
                      _buildTableCell('engineer close time', bold: true),
                      _buildTableCell('department close time', bold: true),
                      _buildTableCell('TAT 1', bold: true),
                      _buildTableCell('TAT 2', bold: true),
                      _buildTableCell('TAT 3', bold: true),
                      _buildTableCell('finaltat', bold: true),
                      _buildTableCell('status', bold: true),
                      _buildTableCell('engineer assigned', bold: true),
                      _buildTableCell('action', bold: true),

                    ],
                  ),
                  for (int index = 0; index < complaints.length; index++)
                    TableRow(
                      children: [
                        _buildTableCell(complaints[index]['complaint_id']),
                        _buildTableCell(complaints[index]['prob']),
                        _buildTableCell(complaints[index]['sub_prob']),
                        _buildTableCell(complaints[index]['descrp']),
                        _buildTableCell(complaints[index]['priority']),
                        _buildTableCell(complaints[index]['floor']),
                        _buildTableCell(complaints[index]['ph_no']),
                        _buildTableCell(complaints[index]['photo']),
                        _buildTableCell(complaints[index]['emp_id']),
                        _buildTableCell(complaints[index]['time_date']),
                        _buildTableCell(complaints[index]['admin_assign_time']),
                        _buildTableCell(complaints[index]['engine_complete_time']),
                        _buildTableCell(complaints[index]['closing_time']),
                        _buildTableCell(complaints[index]['T1']),
                        _buildTableCell(complaints[index]['T2']),
                        _buildTableCell(complaints[index]['T3']),
                        _buildTableCell(complaints[index]['T4']),
                        _buildTableCell(complaints[index]['administrator_status']),
                        _buildTableCell(complaints[index]['engineer']),
                        _buildActionTableCell(complaints[index]),

                      ],
                    ),
                ],
              ),
            )
        ));
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
                deletecomplaint(id);
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

  Widget _buildTableCell(String text, {TextEditingController? controller, bool bold = false}) {
    if (controller != null) {
      controller.text = text;
    }

    Color? backgroundColor;

    switch (text) {
      case 'Submitted':
        backgroundColor = Colors.lightBlueAccent; // Change this color to light blue
        break;
      case 'Assigned':
        backgroundColor = Colors.orange[200]; // Change this color to light orange
        break;
      case 'Completed':
        backgroundColor = Colors.pink[200]; // Change this color to light pink
        break;
      case 'Closed':
        backgroundColor = Colors.lightGreen; // Change this color to light green
        break;
      default:
        backgroundColor = null; // For other status values, no background color
        break;
    }

    // Check if the text starts with 'C:/xampp/htdocs/php_connection/images/'
    // If so, assume it's an image URL and display the image
    if (text.startsWith('C:/xampp/htdocs/php_connection/images/')) {
      return TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            'http://192.168.62.224:8080/php_connection/images/64b2eae734744.jpg',
            width: 100, // Set the width and height as per your requirement
            height: 100,
          ),
        ),
      );
    } else {
      return TableCell(
          child: Container(
            color: backgroundColor, // Set the background color
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                        color: Colors.black, // Set the text color to black
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      );
    }
  }


  Widget _buildTextField(TextEditingController controller, String labelText, {String? initialValue}) {
    if (initialValue != null) {
      controller.text = initialValue;
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
    );
  }

  Widget _buildAssigneeDropDown(String problem) {

    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<String>(
          value: selectedAssignees[problem],
          onChanged: (String? newValue) {
            setState(() {
              selectedAssignees[problem] = newValue ?? '';
            });
          },
          items: peopleList.map((person) {
            return DropdownMenuItem<String>(
              value: person,
              child: Text(person),
            );
          }).toList(),
          decoration: InputDecoration(labelText: 'Select Person'),
        ),
      ),
    );
  }
}