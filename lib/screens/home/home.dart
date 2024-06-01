import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatelessWidget {
  final AuthService _auth=AuthService();

  @override
  Widget build(BuildContext context) {

    void showSettingsPannel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child:SettingsForm(),
        );
      });
    }
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.brown[200],
          elevation: 0.0,
          title: Text('Brew - Crew',
          style: TextStyle(
            fontSize: 20.0,
          ),
          ),
          actions: [
            TextButton.icon(
                icon:Icon(Icons.person),
                onPressed: () async{
                    await _auth.signOut();
                },
                label: Text('Logout')),
            TextButton.icon(
              icon:Icon(Icons.settings),
              label:Text('settings'
              ),
              onPressed: (){
                showSettingsPannel();
              },
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.jpeg'),
                fit:BoxFit.cover,
              )
            ),
            child: BrewList()
        ),
      ),
    );
  }
}
