import 'package:flutter/material.dart';
import 'package:game_on/src/utils/colors.dart';
import 'package:get/get.dart';

class ConfGameDialog extends StatefulWidget {
  final String content;
  const ConfGameDialog({ Key key, this.content }) : super(key: key);

  @override
  _ConfGameDialogState createState() => _ConfGameDialogState();
}

class _ConfGameDialogState extends State<ConfGameDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure ?'),
      content: widget.content != null ? Text(widget.content) : null,
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