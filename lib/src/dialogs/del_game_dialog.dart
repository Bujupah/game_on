import 'package:flutter/material.dart';
import 'package:game_on/src/utils/colors.dart';
import 'package:get/get.dart';

class DelGameDialog extends StatefulWidget {
  const DelGameDialog({ Key key }) : super(key: key);

  @override
  _DelGameDialogState createState() => _DelGameDialogState();
}

class _DelGameDialogState extends State<DelGameDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure ?'),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: lightColor),
          child: Text('Cancel', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          onPressed: () => Get.back(result: false), 
        ),
        ElevatedButton(
          child: Text('Save', style: TextStyle(color: lightColor, fontWeight: FontWeight.bold)),
          onPressed: () => Get.back(result: true), 
        ),
      ],
    );
  }
}