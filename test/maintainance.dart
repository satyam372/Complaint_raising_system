import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Maintenance extends StatefulWidget {
  //const Maintenance({Key? key}) : super(key: key);

  final String employeeId; // Declare the employeeId variable
  const Maintenance({Key? key, required this.employeeId}) : super(key: key);

  @override
  _MaintenanceState createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  TextEditingController selectMaintenanceIssueController = TextEditingController();
  TextEditingController MaintenanceselectTypeAIssueController = TextEditingController();
  TextEditingController MaintenanceselectTypeBIssueController = TextEditingController();
  TextEditingController MaintenancephoneNumberController = TextEditingController();
  TextEditingController MaintenanceproblemDescriptionController = TextEditingController();
  TextEditingController MaintenancepriorityLevelController = TextEditingController();
  // TextEditingController selectRequiredFloorController = TextEditingController();
  TextEditingController MaintenancecurrentTimeController = TextEditingController();
  TextEditingController MaintenanceemployeeIdController = TextEditingController();
  TextEditingController MaintenanceimageDataController = TextEditingController();
  TextEditingController MaintenanceselectedFloorController = TextEditingController();


  Future<void> register() async {
    var url = Uri.parse("http://192.168.255.224:8080/php_connection/maintainance.php");

    try {
      String date=DateTime.now().toString();
      var assignButtonText = 'submitted';
      var response = await http.post(url, body: {
        // "floor": _selectedFloor,
        "floor":MaintenanceselectedFloorController.text,
        "ph_no":MaintenancephoneNumberController.text ,
        "prob":MaintenanceselectedIssue.toString(),
        "sub_prob": Maintenanceselectedsubissue.toString(),
        // "sub_prob": MaintenanceselectTypeAIssueController.toString(),
        "descrp":MaintenanceproblemDescriptionController.text,
        "priority":MaintenancepriorityLevelController.text,
        "time_date":date,
        "photo":MaintenanceimageDataController.text,
        "emp_id":widget.employeeId,
        'submit': assignButtonText,

      });

      if (response.statusCode == 200) {
        try {
          var responseJson = json.decode(response.body);
          print(responseJson);
          var jsonResponse = responseJson["response"];
          if (jsonResponse == "error") {
            Fluttertoast.showToast(msg: "This user already exists");
          } else {
            Fluttertoast.showToast(msg: "Registration successful");
          }
        } catch (e) {
          print("Error parsing JSON: ${e.toString()}");
          print("Response body: ${response.body}");
          Fluttertoast.showToast(msg: "Ticket raised succesfully");
        }
      } else {
        Fluttertoast.showToast(msg: "Error: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
    }
  }

  late File imageFile;
  var imageData;

  String? _MaintenanceselectedImagePath; // Declare as a state variable
  String? _MaintenanceselectedProblemDescription;
  String? _MaintenanceselectedEmergencyLevel;

  bool _MaintenanceshowFloorMessage = true;
  bool _MaintenanceshowProblemDescription = true;
  String MaintenanceselectedIssue = '';
  String MaintenanceselectedFloor = '';
  String Maintenanceselectedsubissue = '';
  String MaintenanceselectedTypeAIssue = '';
  String MaintenanceselectedTypeBIssue = '';

  @override
  void dispose() {
    selectMaintenanceIssueController.dispose();
    MaintenanceselectTypeAIssueController.dispose();
    MaintenanceselectTypeBIssueController.dispose();
    MaintenancephoneNumberController.dispose();
    MaintenanceproblemDescriptionController.dispose();
    MaintenancepriorityLevelController.dispose();
    // selectRequiredFloorController.dispose();
    MaintenancecurrentTimeController.dispose();
    MaintenanceemployeeIdController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize the current date and time controller with the current date and time
    final currentTime = DateFormat.yMd().add_jms().format(DateTime.now());
    MaintenancecurrentTimeController.text = currentTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Maintenance Department'),
          backgroundColor: Colors.blue,
        ),
        body: FractionallySizedBox(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/dashboard.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: TextField(
                              controller: MaintenancecurrentTimeController,
                              readOnly: true,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 20),
                          Text(
                            'Employee ID: ${widget.employeeId}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),


                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select Floor:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              // border: Border.all(color: Colors.grey.shade100),
                            ),
                            child: DropdownButtonFormField<String>(
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text('Select Floor'),
                                  value: '',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Floor 1'),
                                  value: 'Floor_1',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Floor 2'),
                                  value: 'Floor_2',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Floor 3'),
                                  value: 'Floor_3',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Floor 4'),
                                  value: 'Floor_4',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Floor 5'),
                                  value: 'Floor_5',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Floor 6'),
                                  value: 'Floor_6',
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  MaintenanceselectedFloorController.text = value ?? '';
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Select Floor',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ], // Add this closing bracket
                      ),

                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Enter Phone Number:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextField(
                              controller: MaintenancephoneNumberController,
                              decoration: const InputDecoration(
                                hintText: 'Enter your phone number',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      const Text(
                        'Select Problem Description:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              height: 60,
                              child: DropdownButtonFormField<String>(
                                items: [
                                  DropdownMenuItem<String>(
                                    child: Text('Select Issue'),
                                    value: '',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text('Type A issue'),
                                    value: 'TypeA',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text('Type B issue'),
                                    value: 'TypeB',
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    MaintenanceselectedIssue = value ?? '';
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Select Issue',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Visibility(
                              visible: MaintenanceselectedIssue == 'TypeA',
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: DropdownButtonFormField<String>(
                                  items: [
                                    // Items for Type A  issues
                                    DropdownMenuItem<String>(
                                      child: Text('Issue 1'),
                                      value: 'Issue 1',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Issue 2'),
                                      value: 'Issue 2',
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      Maintenanceselectedsubissue = value ?? '';
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Type A Issue',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: MaintenanceselectedIssue == 'TypeB',
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: DropdownButtonFormField<String>(
                                  items: [
                                    // Items for Type B issues
                                    DropdownMenuItem<String>(
                                      child: Text('Issue A'),
                                      value: 'Issue A',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Issue B'),
                                      value: 'Issue B',
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      Maintenanceselectedsubissue = value ?? '';
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Type B Issue',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //nst SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Problem Description:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    controller: MaintenanceproblemDescriptionController,
                                    maxLines: 3,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter problem description',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Add Photo of Problem:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        _pickImage(context);// Call the image picker method

                                      },

                                      child: const Text('Add Photo'),
                                    ),
                                  ],
                                ),
                              ],
                            ),




                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Select Priority Level:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Flexible(
                                      child: RadioListTile<String>(
                                        title: const Padding(
                                          padding: EdgeInsets.only(left: 1.0),
                                          child: Text(
                                            'High',
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        value: 'red',
                                        groupValue: _MaintenanceselectedEmergencyLevel,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _MaintenanceselectedEmergencyLevel = value;
                                            MaintenancepriorityLevelController.text = 'High'; // Update the controller value
                                          });
                                        },
                                        activeColor: Colors.red,
                                      ),
                                    ),
                                    Flexible(
                                      child: RadioListTile<String>(
                                        title: const Padding(
                                          padding: EdgeInsets.only(left: 0.0),
                                          child: Text(
                                            'Medium',
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        value: 'orange',
                                        groupValue: _MaintenanceselectedEmergencyLevel,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _MaintenanceselectedEmergencyLevel = value;
                                            MaintenancepriorityLevelController.text = 'Medium'; // Update the controller value
                                          });
                                        },
                                        activeColor: Colors.orange,
                                      ),
                                    ),
                                    Flexible(
                                      child: RadioListTile<String>(
                                        title: const Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Low',
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        value: 'yellow',
                                        groupValue: _MaintenanceselectedEmergencyLevel,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _MaintenanceselectedEmergencyLevel = value;
                                            MaintenancepriorityLevelController.text = 'Low'; // Update the controller value
                                          });
                                        },
                                        activeColor: Colors.yellow,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                // Handle form submission
                                register();
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ],

                  )
              ),
            ),
          ),


        )
    );


  }
}
// Image picker method
/* Future<void> _pickImage() async {
   final ImagePicker _picker = ImagePicker();
   final XFile? image = await _picker.pickImage(
     source: ImageSource.gallery, // Change to ImageSource.camera for accessing the camera
   );

   if (image != null) {
     // Handle the selected image path here
     print('Selected image path: ${image.path}');
   }
 }
*/

Future<String> getEmployeeIdFromServer(String enteredId) async {
  final url = 'http://192.168.62.224:8080/php_connection/login.php=$enteredId';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Parse the response JSON and extract the employee ID
    final jsonData = json.decode(response.body);
    final employeeId = jsonData['employeeId'];

    return employeeId;
  } else {
    throw Exception('Failed to retrieve employee ID');
  }
}
TextEditingController imageDataController = TextEditingController();
Future<void> _pickImage(BuildContext context) async {
  final ImagePicker _picker = ImagePicker();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose Image Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (image != null) {
                    List<int> bytes = await image.readAsBytes();
                    String imageData = base64Encode(bytes);
                    print('Encoded image data: $imageData');

                    // Send the `imageData` to your MySQL database using an API call
                    final url = Uri.parse('https://your-api-endpoint.com/upload-image'); // Replace with your API endpoint URL
                    final response = await http.post(
                      url,
                      body: {'image': imageData},
                    );

                    if (response.statusCode == 200) {
                      print('Image uploaded successfully!');
                    } else {
                      print('Failed to upload image. Error: ${response.reasonPhrase}');
                    }
                  }
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                child: Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (image != null) {
                    List<int> bytes = await image.readAsBytes();
                    String imageData = base64Encode(bytes);
                    print('Encoded image data: $imageData');
                    imageDataController.text=imageData;

                    // Send the `imageData` to your MySQL database using an API call
                    final url = Uri.parse('https://your-api-endpoint.com/upload-image'); // Replace with your API endpoint URL
                    final response = await http.post(
                      url,
                      body: {'image': imageData},
                    );

                    if (response.statusCode == 200) {
                      print('Image uploaded successfully!');
                    } else {
                      print('Failed to upload image. Error: ${response.reasonPhrase}');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}