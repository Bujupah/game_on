import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:game_on/src/dialogs/conf_game_dialog.dart';
import 'package:get/get.dart';
import '../dialogs/del_game_dialog.dart';
import '../dialogs/add_game_dialog.dart';
import '../services/game_service.dart';
import '../models/game_model.dart';
import '../services/user_service.dart';
import '../utils/colors.dart';

class CachierPage extends StatefulWidget {
  const CachierPage({ Key key }) : super(key: key);

  @override
  _CachierPageState createState() => _CachierPageState();
}

class _CachierPageState extends State<CachierPage> {

  void addGame() async {
    final result = await Get.dialog(AddGameDialog());
    await GameService.save(result);
    setState(() {});
  }
  void addCachier() async {
    await UserService.addCachier(null);
  }
  void viewStats() async {
    Get.toNamed('/stats');
  }
  void deleteReport(String id) async { 
    final result = await Get.dialog(DelGameDialog());
    if (result) GameService.delete(id);
    setState(() {});
  }

  void saveReport() async {
    final result = await Get.dialog(ConfGameDialog());
    if (result) await GameService.getReport();
    setState(() {});
  }
  void sendReport() async {
    final result = await Get.dialog(ConfGameDialog(content: 'Send mail to <${UserService.currentUser.email}>',));
    if (result) await GameService.sendReport();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Container(
          height: 74,
          decoration: BoxDecoration(
            color: blackColor,
            image: DecorationImage(
              alignment: Alignment.centerLeft,
              fit: BoxFit.contain,
              image: AssetImage('images/background.jpg'),
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(width: 100,),
              ElevatedButton.icon(
                onPressed: addGame, 
                icon: Icon(Icons.add),
                label: Text('Add record'),
              ),
              if (UserService.currentUser?.isAdmin ?? false) ...[
                SizedBox(width: 16,),
                ElevatedButton.icon(
                  onPressed: addCachier, 
                  icon: Icon(Icons.person_add),
                  label: Text('Add cachier'),
                ),
              ],
              SizedBox(width: 16,),
              ElevatedButton.icon(
                onPressed: viewStats, 
                icon: Icon(Icons.dashboard),
                label: Text('View stats'),
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: saveReport,
                icon: Icon(Icons.save),
                label: Text('Save report'),
              ),
              SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: sendReport, 
                icon: Icon(Icons.mail),
                label: Text('Send report'),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        color: Colors.black54,
        child: FutureBuilder<List<GameModel>>(
          future: GameService.getAll(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error),
                    SizedBox(width: 6),
                    Text(snapshot.error.toString()),
                  ],
                ),
              );
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(mainColor)));
            return ListView.separated(
              itemCount: snapshot.data.length,
              separatorBuilder: (ctx, i) => Divider(),
              itemBuilder: (ctx, i) {
                final game = snapshot.data[i];
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: mainColor,
                      icon: Icons.archive,
                      onTap: () => deleteReport(game.id),
                    ),
                  ],
                  child: ListTile(
                    leading: FloatingActionButton(
                      mini: true,
                      heroTag: '$i',
                      key: Key('$i'),
                      onPressed: null,
                      child: Text(game.price, style: TextStyle(fontSize:18, fontWeight: FontWeight.bold, color: lightColor)), 
                      backgroundColor: mainColor, 
                    ),
                    title: Text(game.post, style: TextStyle(color: lightColor),),
                    subtitle: Text('ID: ${game.id}', style: TextStyle(fontSize: 10),),
                    dense: true,
                    trailing: Text(game.createdAt),
                  ),
                );
              },
            );
          }
        ),
      ),
      bottomNavigationBar: Container(
        color: darkColor,
        padding: EdgeInsets.only(left: 8),
        child: Row(
          children: [
            Text('Logged as ${UserService.currentUser?.fullname} - ${UserService.currentUser?.myRole}'),
            Spacer(),
            Tooltip(
              message: 'Disconnect', 
              child: InkWell(
                onTap: () async => await UserService.logout(), 
                child: SizedBox(child: Icon(Icons.close), width: 32, height: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}