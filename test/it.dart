import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'complaint_login.dart';

class IT extends StatefulWidget {
  // const IT({Key? key}) : super(key: key);

  final String employeeId; // Declare the employeeId variable
  const IT({Key? key, required this.employeeId}) : super(key: key);

  @override
  _ITState createState() => _ITState();
}

class _ITState extends State<IT> {
  TextEditingController selectITIssueController = TextEditingController();
  TextEditingController selectHardwareIssueController = TextEditingController();
  TextEditingController selectSoftwareIssueController = TextEditingController();
  TextEditingController selectNetworkIssueController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController problemDescriptionController = TextEditingController();
  TextEditingController priorityLevelController = TextEditingController();
  // TextEditingController selectRequiredFloorController = TextEditingController();
  TextEditingController currentTimeController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController imageDataController = TextEditingController();
  TextEditingController selectedFloorController = TextEditingController();

  Future<void> register() async {
    var url = Uri.parse("http://192.168.255.224:8080/php_connection/it.php");

    try {
      String date = DateTime.now().toString();
      var assignButtonText = 'submitted';
      var response = await http.post(url, body: {
        // "floor": _selectedFloor,
        "floor":selectedFloorController.text,
        "ph_no":phoneNumberController.text ,
        "prob":selectedIssue.toString(),
        "sub_prob":selectedsubissue.toString(),
        "descrp":problemDescriptionController.text,
        "priority":priorityLevelController.text,
        "time_date":date,
        "photo":imageDataController.text,
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

  String? _selectedImagePath; // Declare as a state variable
  String? _selectedProblemDescription;
  String? _selectedEmergencyLevel;

  bool _showFloorMessage = true;
  bool _showProblemDescription = true;
  String selectedIssue = '';
  String selectedsubissue='';
  String selectedFloor = '';
  String selectedHardwareIssue = '';
  String selectedSoftwareIssue = '';
  String selectedNetworkIssue = '';

  @override
  void dispose() {
    selectITIssueController.dispose();
    selectHardwareIssueController.dispose();
    selectNetworkIssueController.dispose();
    selectSoftwareIssueController.dispose();
    phoneNumberController.dispose();
    problemDescriptionController.dispose();
    priorityLevelController.dispose();
    // selectRequiredFloorController.dispose();
    currentTimeController.dispose();
    employeeIdController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize the current date and time controller with the current date and time
    final currentTime = DateFormat.yMd().add_jms().format(DateTime.now());
    currentTimeController.text = currentTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('IT Department'),
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
                              controller: currentTimeController,
                              readOnly: true,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '',
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
                          //  TextField(
                          //   controller: employeeIdController,
                          //   decoration: const InputDecoration(
                          //     hintText: 'Enter your Employee Id ',
                          //     border: InputBorder.none,
                          //     contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          //   ),
                          // ),
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
                                  selectedFloorController.text = value ?? '';
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
                              controller: phoneNumberController,
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
                                    child: Text('Hardware issue'),
                                    value: 'Hardware',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text('Software issue'),
                                    value: 'Software',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text('Network issue'),
                                    value: 'Network',
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedIssue = value ?? '';
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
                              visible: selectedIssue == 'Hardware',
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: DropdownButtonFormField<String>(
                                  items: [
                                    // Items for hardware issues
                                    DropdownMenuItem<String>(
                                      child: Text('Printer'),
                                      value: 'Printer',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Desktop'),
                                      value: 'Desktop',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Scanner'),
                                      value: 'Scanner',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Laptop'),
                                      value: 'Laptop',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Projector'),
                                      value: 'Projector',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Other'),
                                      value: 'Other',
                                    ),

                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedsubissue = value ?? '';
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Hardware Issue',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: selectedIssue == 'Software',
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: DropdownButtonFormField<String>(
                                  items: [
                                    // Items for software issues
                                    DropdownMenuItem<String>(
                                      child: Text('Access Issue'),
                                      value: 'Access Issue',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Billing'),
                                      value: 'Billing',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Front office'),
                                      value: 'Front office',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Nursing'),
                                      value: 'Nursing',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Other'),
                                      value: 'Other',
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedsubissue = value ?? '';
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Software Issue',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: selectedIssue == 'Network',
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: DropdownButtonFormField<String>(
                                  items: [
                                    // Items for software issues
                                    DropdownMenuItem<String>(
                                      child: Text('Access Issue'),
                                      value: 'Access Issue',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Server'),
                                      value: 'Server',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Switch'),
                                      value: 'Switch',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Access Point'),
                                      value: 'Access Point',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Telephone'),
                                      value: 'Telephone',
                                    ),
                                    DropdownMenuItem<String>(
                                      child: Text('Other'),
                                      value: 'Other',
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedsubissue = value ?? '';
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Network Issue',
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
                                    controller: problemDescriptionController,
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

                                        _pickImage();// Call the image picker method

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
                                        groupValue: _selectedEmergencyLevel,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedEmergencyLevel = value;
                                            priorityLevelController.text = 'High'; // Update the controller value
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
                                        groupValue: _selectedEmergencyLevel,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedEmergencyLevel = value;
                                            priorityLevelController.text = 'Medium'; // Update the controller value
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
                                        groupValue: _selectedEmergencyLevel,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedEmergencyLevel = value;
                                            priorityLevelController.text = 'Low'; // Update the controller value
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
                                register();
                                // Handle form submission
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
TextEditingController imageDataController = TextEditingController();
Future<void> _pickImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(
    source: ImageSource.gallery, // Change to ImageSource.camera for accessing the camera
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
}