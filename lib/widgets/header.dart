import 'package:flutter/material.dart';

header(context, {bool isAppTitle = false, String titleText, removeBackbutton = false }) {
  return AppBar(
    automaticallyImplyLeading: removeBackbutton ? false: true,
      title: Text(
        isAppTitle ? "Viscus" : titleText,
        style: TextStyle(
          fontFamily: 'Iceland',
          color: Colors.black,
          fontSize: 40
        ),
        overflow: TextOverflow.ellipsis,
      ),

    centerTitle: true,
    backgroundColor: Colors.white,

  );
}
