import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/game_model.dart';
import '../utils/colors.dart';

class AddGameDialog extends StatefulWidget {
  const AddGameDialog({ Key key }) : super(key: key);

  @override
  _AddGameDialogState createState() => _AddGameDialogState();
}

class _AddGameDialogState extends State<AddGameDialog> {
  final post = TextEditingController(); 
  final price = TextEditingController(); 

  void cancel() => Get.back();
  void save() => Get.back(result: GameModel(int.parse(post.text), int.parse(price.text)));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Add game record')),
      backgroundColor: Colors.grey[900],
      titlePadding: EdgeInsets.all(8),
      contentPadding: EdgeInsets.all(8),
      content: Form(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 156,
              child: TextFormField(
                controller: post,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Post Number',
                  suffixText: '',
                  prefixText: 'GameRoom_',
                  prefixStyle: TextStyle(fontSize: 12),
                ),
                cursorColor: mainColor,
              ),
            ),
            Spacer(),
            Container(
              width: 64,
              child: TextFormField(
                controller: price,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Price',
                  suffixText: 'TND',
                  suffixStyle: TextStyle(fontSize: 12),
                ),
                cursorColor: mainColor,
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: lightColor),
          child: Text('Cancel', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          onPressed: cancel, 
        ),
        ElevatedButton(
          child: Text('Save', style: TextStyle(color: lightColor, fontWeight: FontWeight.bold)),
          onPressed: save, 
        ),
      ],
    );
  }
}