import 'package:flutter/material.dart';

class Add extends StatefulWidget{
  const Add ({Key?key}) :super(key: key);

  @override
  State<StatefulWidget> createState()=> AddState();
}

class AddState extends State<Add> {
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          leading: BackButton(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15)),
              TextField(
                controller: _textFieldController,
                decoration: InputDecoration(
                  hintText: 'Enter patient name',
                    border:OutlineInputBorder(borderRadius:BorderRadius.circular(30))
                ),
              ),
              SizedBox(height: 30),

              TextField(
                controller: _textFieldController,
                decoration: InputDecoration(
                    hintText: 'Enter doctor name',
                    border:OutlineInputBorder(borderRadius:BorderRadius.circular(30))
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

