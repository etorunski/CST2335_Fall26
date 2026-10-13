

import 'package:flutter/material.dart';

import 'DataRepository.dart'; /// for Android look and feel
/// import 'package:flutter/cupertino.dart';/// for iOS look and feel

/// This page will have items that change
class OtherPage extends StatefulWidget{


  @override             //short for: { returns ______________; }
  State<StatefulWidget> createState() => OtherPageState();

}

class OtherPageState extends State<StatefulWidget> {

  ///This return a widget which shows the state on screen
  @override             //context is the memory manager
  Widget build(BuildContext context) {

      final pageOneString = DataRepository.pageOneString;

    return Scaffold( appBar: AppBar(title: Text("Other Page")),
      body: Center(child:
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          Text("This is the other page, you typed in: $pageOneString before"),
          OutlinedButton(child: Text("Back to Home"),
            onPressed: (){
              Navigator.pop(context);
            },)
      ]))
    );
  }
}