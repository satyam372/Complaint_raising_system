import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'complaint_login.dart';

class TrackComplaint extends StatefulWidget {

  final String employeeId; // Declare the employeeId variable
  const TrackComplaint({Key? key, required this.employeeId}) : super(key: key);

  @override
  _TrackComplaintState createState() => _TrackComplaintState();

}

class _TrackComplaintState extends State<TrackComplaint> {
  get employeeId => widget.employeeId;


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
    empIdController.dispose();
    engineerAssignController.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> fetchData(String employeeId) async {
    final url = Uri.parse(
      "http://192.168.255.224:8080/php_connection/track_complaint.php?emp_id=$employeeId",
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


  // Future<void>deletecomplaint(String id)async
  // {
  //   var url = Uri.parse("http://192.168.62.224:8080/php_connection/administrator_delete_assigned_complaint.php");
  //
  //   try {
  //     var response = await http.post(url, body: {
  //
  //
  //       'complaint_id': complaintIdController.text,
  //     });
  //
  //     if (response.statusCode == 200) {
  //       try {
  //         var responseJson = json.decode(response.body);
  //         print(responseJson);
  //         var jsonResponse = responseJson["response"];
  //         if (jsonResponse == 'error') {
  //           Fluttertoast.showToast(msg: "Error");
  //         } else {
  //           // Mark the complaint as assigned
  //           setState(() {
  //             assignedComplaints[id] = true;
  //           });
  //           Fluttertoast.showToast(msg: 'Success');
  //         }
  //       } catch (e) {
  //         print("Error parsing JSON: ${e.toString()}");
  //         print("Response body: ${response.body}");
  //         Fluttertoast.showToast(msg: "Error parsing server response");
  //       }
  //     } else {
  //       Fluttertoast.showToast(msg: "Error: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     Fluttertoast.showToast(msg: "Error: ${e.toString()}");
  //   }
  //   print(complaintIdController);
  // }
  Future<void> sendDataToServer(String id,) async {
    var url = Uri.parse(
        'http://192.168.1.201:8095/php_connection/close_ticket.php');

    try {
      var closeButtonText = 'closed';
      String date = DateTime.now().toString();
      var response = await http.post(url, body: {


        'complaint_id': complaintIdController.text,
        'close': closeButtonText,
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
          Fluttertoast.showToast(msg: "Error parsing server response");
        }
      } else {
        Fluttertoast.showToast(msg: "Error: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }


  Future<void> deletecomplaint(String id) async
  {
    var url = Uri.parse(
        "http://192.168.1.201:8095/php_connection/close_ticket.php");

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


  Widget _buildActionTableCell(Map<String, dynamic> complaint) {
    final bool isAssigned = assignedComplaints[complaint['complaint_id']] ??
        false;
    String? complaintId = complaint['complaint_id'];
    bool isEngineerCompleted = complaint['engine_status'] == 'completed';

    if (complaintId != null && complaintId.isNotEmpty) {
      final bool isAssigned = assignedComplaints[complaintId] ?? false;
      if (isAssigned) {
        // If the complaint is assigned and frozen, return an empty cell
        return TableCell(
          child: Container(),
        );
      } else {
        // If the complaint is not assigned or not frozen, return the action button
        return TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: isEngineerCompleted
                  ? () {
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
                            // Close the complaint
                            sendDataToServer(id);
                            // Set the state to mark the complaint as closed
                            setState(() {
                              assignedComplaints[id] = true;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              }
                  : null,
              // Disable the button if the engineer's status is not completed
              child: Text(isEngineerCompleted ? 'Close' : 'Not Completed'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track complaint'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Call fetchData with the current employeeId
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
            // Call fetchData with the current employeeId
            future: fetchData(employeeId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                final complaints = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildTable(complaints),
                );
              } else {
                return Text("No data available.");
              }
            },
          ),
        ),
      ),
    );
  }


  // Widget _buildActionTableCell(Map<String, dynamic> complaint) {
  //   final bool isAssigned = assignedComplaints[complaint['id']] ?? false;
  //   String? complaintId = complaint['id'];
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
  //                 title: const Text('Assign Complaint'),
  //                 content: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     _buildTextField(complaintIdController, 'id', initialValue: complaintId ?? ''),
  //
  //                     _buildTextField(probController, 'Problem', initialValue: complaint['prob']),
  //                     _buildTextField(subProbController, 'subproblem', initialValue: complaint['sub_prob']),
  //                     _buildTextField(descrpController, 'description', initialValue: complaint['descrp']),
  //                     _buildTextField(priorityController, 'priority', initialValue: complaint['priority']),
  //                     _buildTextField(floorController, 'floor', initialValue: complaint['floor']),
  //                     _buildTextField(phNoController, 'phone number', initialValue: complaint['ph_no']),
  //                     _buildTextField(empIdController, 'employee Id', initialValue: complaint['emp_id']),
  //                     _buildAssigneeDropDown(complaint['prob']),
  //                   ],
  //                 ),
  //                 actions: [
  //                   TextButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: const Text('Cancel'),
  //                   ),
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       String id = complaintIdController.text;
  //                       String prob = probController.text;
  //                       String sub_prob = subProbController.text;
  //                       String descrp = descrpController.text;
  //                       String priority = priorityController.text;
  //                       String floor = floorController.text;
  //                       String ph_no = phNoController.text;
  //                       String emp_id = empIdController.text;
  //                       String assignee = selectedAssignees[prob] ?? '';
  //                       sendDataToServer(id, prob, sub_prob, descrp, floor, ph_no, emp_id, priority, assignee);
  //                       Navigator.pop(context);
  //                     },
  //                     child: const Text('Assign'),
  //                   ),
  //                 ],
  //               );
  //             },
  //           );
  //         },
  //         child: Text('Assign'),
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
              0: FixedColumnWidth(200),
              1: FixedColumnWidth(200),
              2: FixedColumnWidth(200),
              3: FixedColumnWidth(200),
              4: FixedColumnWidth(200),
              5: FixedColumnWidth(200),
              6: FixedColumnWidth(200),
              7: FixedColumnWidth(200),
              8: FixedColumnWidth(200),
              9:FixedColumnWidth(200),


            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                ),
                children: [
                  _buildTableCell('complaint_id', bold: true),
                  _buildTableCell('prob', bold: true),
                  _buildTableCell('user_status', bold: true),
                  _buildTableCell('ticket_raised_time_date', bold: true),
                  _buildTableCell('administrator_status', bold: true),
                  _buildTableCell('admin_assign time', bold: true),
                  _buildTableCell('status of engineer', bold: true),
                  _buildTableCell('engineer status time', bold: true),
                  _buildTableCell('action', bold: true),
                  _buildTableCell('your status', bold: true),

                  // _buildTableCell('delete', bold: true),
                ],
              ),
              for (int index = 0; index < complaints.length; index++)
                TableRow(
                  children: [
                    _buildTableCell(complaints[index]['complaint_id']),
                    _buildTableCell(complaints[index]['prob']),
                    _buildTableCell(complaints[index]['user_status']),
                    _buildTableCell(complaints[index]['time_date']),
                    _buildTableCell(complaints[index]['administrator_status']),
                    _buildTableCell(complaints[index]['admin_assign_time']),
                    _buildTableCell(complaints[index]['engine_status']),
                    _buildTableCell(complaints[index]['engine_complete_time']),
                    _buildActionTableCell(complaints[index]),
                    _buildTableCell(complaints[index]['closing_status']),
                    //_buildDeleteTableCell(complaints[index]['id']),
                  ],
                ),
            ],
          ),
        ));
  }


  Widget _buildManualInputTableCell(String? complaintId) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          initialValue: complaintId,
          onChanged: (newValue) {
            // Handle the manual input value here, if needed
            // For example, you can update the 'complaintIdController' with the new value.
            // complaintIdController.text = newValue;
          },
          decoration: InputDecoration(
            labelText: 'Manual Input', // Replace with a suitable label
          ),
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
    if (text.startsWith('C:/xampp/htdocs/php_connection/images/')) {
      // If the text is an image URL, display the image
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
      // For non-image cells, display regular text
      Color? textColor;
      Color? backgroundColor;
      switch (text) {
        case 'submitted':
          textColor = Colors.black;
          backgroundColor = Colors
              .lightBlueAccent; // Light blue accent color for 'submitted' state
          break;
        case 'assigned':
          textColor = Colors.black;
          backgroundColor =
          Colors.orange[200]; // Orange[200] color for 'assigned' state
          break;
        case 'completed':
          textColor = Colors.black;
          backgroundColor =
          Colors.pink[200]; // Pink[200] color for 'completed' state
          break;
        case 'closed':
          textColor = Colors.black;
          backgroundColor =
              Colors.lightGreen; // Light green color for 'closed' state
          break;
        default:
          textColor = Colors.black; // Default text color for other states
          backgroundColor =
              Colors.transparent; // Default transparent background color
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
                    text, // Replace null with an empty string
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


  // Widget _buildTextField(TextEditingController controller, String labelText, {String? initialValue}) {
  //   if (initialValue != null) {
  //     controller.text = initialValue;
  //   }
  //
  //   return TextField(
  //     controller: controller,
  //     decoration: InputDecoration(labelText: labelText),
  //   );
  // }
  //
  // Widget _buildAssigneeDropDown(String problem) {
  //   return TableCell(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: DropdownButtonFormField<String>(
  //         value: selectedAssignees[problem],
  //         onChanged: (String? newValue) {
  //           setState(() {
  //             selectedAssignees[problem] = newValue ?? '';
  //           });
  //         },
  //         items: peopleList.map((person) {
  //           return DropdownMenuItem<String>(
  //             value: person,
  //             child: Text(person),
  //           );
  //         }).toList(),
  //         decoration: InputDecoration(labelText: 'Select Person'),
  //       ),
  //     ),
  //   );
  // }


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