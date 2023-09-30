import 'package:flutter/material.dart';
import 'assign_complaint_page_demo.dart';
import 'see_engineers.dart';
import 'assign_complain_page.dart';

class ComplainInterface extends StatelessWidget {
  const ComplainInterface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complain Interface'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/signup.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset('images/c1.jpg'), // Image above SEE COMPLAIN button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SeeEngineersPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900], // Set the background color to navy blue
                ),
                child: Text('See Engineers'),
              ),
              SizedBox(height: 20),
              Image.asset('images/c2.jpg'), // Image above ASSIGN COMPLAIN button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AssignComplainPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900], // Set the background color to navy blue
                ),
                child: Text('ASSIGN COMPLAIN'),
              ),


            ],
          ),
        ),
      ),
    );
  }
}