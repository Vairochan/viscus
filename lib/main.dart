import 'package:flutter/material.dart';
import 'package:viscus/pages/home_page.dart';


void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "new",
    theme: ThemeData(
      primarySwatch: Colors.lightBlue,
      accentColor: Colors.white
    ),
    home: Home(),
  ),
  );
}

      