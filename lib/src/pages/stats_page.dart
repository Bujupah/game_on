import 'package:flutter/material.dart';
import 'package:game_on/src/utils/colors.dart';
import 'package:get/get.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({ Key key }) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlackColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(62),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              TextButton.icon(
                label: Text('Back'),
                icon: Icon(Icons.arrow_back_ios_new, size: 16),
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  primary: lightColor
                ),
              )
            ]
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('Stat page'),
      ),
    );
  }
}