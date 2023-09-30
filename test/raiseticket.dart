import 'package:flutter/material.dart';
import 'biomedical.dart'; // Import the Biomedical page
import 'it.dart'; // Import the IT page
import 'maintainance.dart'; // Import the Maintenance page
import 'facility.dart'; // Import the Facility page
import 'complaint_login.dart';

class RaiseTicket extends StatefulWidget {

  final String employeeId; // Declare the employeeId variable

  const RaiseTicket({Key? key, required this.employeeId}) : super(key: key);
  //const RaiseTicket({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RaiseTicketState();
}

class RaiseTicketState extends State<RaiseTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raise a Ticket'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/dashboard.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Please Select Department',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Image.asset(
                    'images/t1.jpg',
                    height: 90,
                    width: 90,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Biomedical(employeeId: widget.employeeId)), // Navigate to the Biomedical page
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                      primary: Colors.blue.shade900,
                    ),
                    child: const Text('BIOMEDICAL'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Image.asset(
                    'images/t2.jpg',
                    height: 90,
                    width: 90,
                  ),
                  ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => IT(employeeId: widget.employeeId)), // Navigate to the IT page
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                      primary: Colors.blue.shade900,
                    ),
                    child: const Text('IT'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Image.asset(
                    'images/t3.jpg',
                    height: 90,
                    width: 90,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Maintenance(employeeId: widget.employeeId)), // Navigate to the Maintenance page
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                      primary: Colors.blue.shade900,
                    ),
                    child: const Text('MAINTENANCE'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Image.asset(
                    'images/t4.jpg',
                    height: 90,
                    width: 90,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Facility(employeeId: widget.employeeId)), // Navigate to the Facility page
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                      primary: Colors.blue.shade900,
                    ),
                    child: const Text('FACILITY'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}