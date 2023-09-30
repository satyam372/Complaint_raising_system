import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SeeEngineersPage extends StatefulWidget {
  @override
  _SeeEngineersPageState createState() => _SeeEngineersPageState();
}

class _SeeEngineersPageState extends State<SeeEngineersPage> {
  List<Map<String, String>> employees = [];

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  bool showInputFields = false;

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    departmentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Fetch employees data from the PHP backend when the widget is initialized
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    final url = 'http://your-backend-url/backend.php'; // Replace with your PHP backend URL

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parse the response body and update the employees list
        setState(() {
          employees = parseEmployees(response.body);
        });
      } else {
        // Handle the error case
        print('Failed to fetch employees: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Exception occurred: $e');
    }
  }

  List<Map<String, String>> parseEmployees(String responseBody) {
    // Implement the parsing logic based on your PHP API response
    // Convert the response to a List<Map<String, String>> format
    // Example: [{'id': '1', 'name': 'ABC', 'department': 'IT'}, ...]
    // Return the parsed employees list
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Engineers'),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTable(),
                    SizedBox(height: 16.0),
                    _buildActionButtons(),
                    if (showInputFields) ...[
                      _buildTextLines(),
                      _buildInputFields(),
                      ElevatedButton(
                        onPressed: _addEmployee,
                        child: Text('Confirm Add'),
                      ),
                    ],
                  ],
                ),
              ),
            )
        )
    );
  }

  Widget _buildTable() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        columnWidths: {
          0: FlexColumnWidth(1), // Employee ID column
          1: FlexColumnWidth(2), // Employee Name column
          2: FlexColumnWidth(2), // Department column
        },
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _buildTableRow('Employee ID', 'Employee Name', 'Department', bold: true),
          for (final employee in employees)
            _buildTableRow(employee['id']!, employee['name']!, employee['department']!),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String id, String name, String department, {bool bold = false}) {
    return TableRow(
      children: [
        _buildTableCell(id, bold: bold),
        _buildTableCell(name, bold: bold),
        _buildTableCell(department, bold: bold),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool bold = false}) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              showInputFields = !showInputFields;
            });
            if (!showInputFields) {
              idController.clear();
              nameController.clear();
              departmentController.clear();
            }
          },
          child: Text(showInputFields ? 'Cancel' : 'Add Employee'),
        ),
        SizedBox(width: 16.0),
        ElevatedButton(
          onPressed: _removeEmployee,
          child: Text('Remove Employee'),
        ),
      ],
    );
  }

  Widget _buildTextLines() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('Employee ID:'),
          // SizedBox(width: 16.0),
          // Text('Employee Name:'),
          // SizedBox(width: 16.0),
          // Text('Department:'),
        ],
      ),
    );
  }

  Widget _buildInputFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              width: 150,
              child: TextField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: 'Employee ID',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: 150,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Employee Name',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: 150,
              child: TextField(
                controller: departmentController,
                decoration: InputDecoration(
                  labelText: 'Department',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  void _removeEmployee() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Employee'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Select the employee you want to remove:'),
                SizedBox(height: 16.0),
                for (final employee in employees)
                  ListTile(
                    title: Text(employee['name'] ?? ''),
                    subtitle: Text(employee['department'] ?? ''),
                    onTap: () {
                      _confirmRemoveEmployee(employee);
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmRemoveEmployee(Map<String, String> employee) {
    setState(() {
      employees.remove(employee);
    });
  }

  void _addEmployee() {
    final String id = idController.text;
    final String name = nameController.text;
    final String department = departmentController.text;

    if (id.isNotEmpty && name.isNotEmpty && department.isNotEmpty) {
      setState(() {
        employees.add({
          'id': id,
          'name': name,
          'department': department,
        });
        idController.clear();
        nameController.clear();
        departmentController.clear();
        showInputFields = false;
      });
    }
  }
}