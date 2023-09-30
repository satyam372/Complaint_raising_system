import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';



class Facility extends StatefulWidget {
  // const Facility({Key? key}) : super(key: key);

  final String employeeId; // Declare the employeeId variable
  const Facility({Key? key, required this.employeeId}) : super(key: key);

  @override
  _FacilityState createState() => _FacilityState();
}

class _FacilityState extends State<Facility> {
  TextEditingController selectFacilityIssueController = TextEditingController();
  TextEditingController FacilityselectTypeAIssueController = TextEditingController();
  TextEditingController FacilityselectTypeBIssueController = TextEditingController();
  TextEditingController FacilityphoneNumberController = TextEditingController();
  TextEditingController FacilityproblemDescriptionController = TextEditingController();
  TextEditingController FacilitypriorityLevelController = TextEditingController();
  // TextEditingController selectRequiredFloorController = TextEditingController();
  TextEditingController FacilitycurrentTimeController = TextEditingController();
  TextEditingController FacilityemployeeIdController = TextEditingController();
  TextEditingController FacilityimageDataController = TextEditingController();
  TextEditingController FacilityselectedFloorController = TextEditingController();


  Future<void> register() async {
    var url = Uri.parse("http://192.168.255.224:8080/php_connection/facility.php");

    try {
      String date=DateTime.now().toString();
      var assignButtonText = 'submitted';
      var response = await http.post(url, body: {
        // "floor": _selectedFloor,
        "floor":FacilityselectedFloorController.text,
        "ph_no":FacilityphoneNumberController.text ,
        "prob":FacilityselectedIssue.toString(),
        "sub_prob": Facilityselectedsubissue.toString(),
        //"sub_prob": FacilityselectTypeBIssueController.toString(),
        "descrp":FacilityproblemDescriptionController.text,
        "priority":FacilitypriorityLevelController.text,
        "time_date":date,
        "photo":FacilityimageDataController.text,
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
          Fluttertoast.showToast(msg: "ticket raised successfully");
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

  String? _FacilityselectedImagePath; // Declare as a state variable
  String? _FacilityselectedProblemDescription;
  String? _FacilityselectedEmergencyLevel;

  bool _FacilityshowFloorMessage = true;
  bool _FacilityshowProblemDescription = true;
  String FacilityselectedIssue = '';
  String FacilityselectedFloor = '';
  String Facilityselectedsubissue = '';
  String FacilityselectedTypeAIssue = '';
  String FacilityselectedTypeBIssue = '';

  @override
  void dispose() {
    selectFacilityIssueController.dispose();
    FacilityselectTypeAIssueController.dispose();
    FacilityselectTypeBIssueController.dispose();
    FacilityphoneNumberController.dispose();
    FacilityproblemDescriptionController.dispose();
    FacilitypriorityLevelController.dispose();
    // selectRequiredFloorController.dispose();
    FacilitycurrentTimeController.dispose();
    FacilityemployeeIdController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    // Initialize the current date and time controller with the current date and time
    final currentTime = DateFormat.yMd().add_jms().format(DateTime.now());
    FacilitycurrentTimeController.text = currentTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Facility Department'),
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
                                controller: FacilitycurrentTimeController,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Enter Employee Id:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                                        FacilityselectedFloorController.text = value ?? '';
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
                                    controller: FacilityphoneNumberController,
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
                                          FacilityselectedIssue = value ?? '';
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
                                    visible: FacilityselectedIssue == 'TypeA',
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
                                            Facilityselectedsubissue = value ?? '';
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
                                    visible: FacilityselectedIssue == 'TypeB',
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
                                            Facilityselectedsubissue = value ?? '';
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
                                          controller: FacilityproblemDescriptionController,
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
                                              groupValue: _FacilityselectedEmergencyLevel,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _FacilityselectedEmergencyLevel = value;
                                                  FacilitypriorityLevelController.text = 'High'; // Update the controller value
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
                                              groupValue: _FacilityselectedEmergencyLevel,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _FacilityselectedEmergencyLevel = value;
                                                  FacilitypriorityLevelController.text = 'Medium'; // Update the controller value
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
                                              groupValue: _FacilityselectedEmergencyLevel,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _FacilityselectedEmergencyLevel = value;
                                                  FacilitypriorityLevelController.text = 'Low'; // Update the controller value
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
                      ]
                  )),
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
                    source: ImageSource.gallery,
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