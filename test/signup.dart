import 'package:flutter/material.dart';

class MySignup extends StatefulWidget {
  const MySignup({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MySignupState();
}

class MySignupState extends State<MySignup> {
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/signup.jpg'), fit: BoxFit.cover,),
        color:Colors.transparent,



      ),
      child:Scaffold(
          backgroundColor:Colors.transparent,
          body: Stack(
            children: [
              Container(
                padding:EdgeInsets.only(left:67,top:120),
                child:Text('',
                  style:TextStyle(color:Colors.indigoAccent,fontWeight:FontWeight.bold,fontSize:35),),



              ),

              Container(
                  padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.4),

                  child: Column(
                    children: [
                      TextField(decoration:InputDecoration(
                          fillColor:Colors.grey.shade100,
                          hintText:'Username',
                          border:OutlineInputBorder(borderRadius:BorderRadius.circular(30))
                      )),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(obscureText: true,
                          decoration: InputDecoration(

                              fillColor:Colors.grey.shade100,
                              hintText:'password',
                              border:OutlineInputBorder(borderRadius:BorderRadius.circular(30))

                          )),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(obscureText:true,
                      decoration: InputDecoration(
                        fillColor:Colors.grey.shade100,
                        hintText:'confirm password',
                        border:OutlineInputBorder(borderRadius:BorderRadius.circular(30))
                      ),)

                    ],
                  )
              ),
              Container(
                padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.8,left:20) ,
                child:OutlinedButton(
                  child:Text('Signup',style:TextStyle(fontSize:20.0),),


                  onPressed: (){},
                ),
              )
            ],

          )


      ),
    );
  }
}