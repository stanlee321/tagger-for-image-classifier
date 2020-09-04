import 'package:etiquetador/User/bloc/user_bloc.dart';
import 'package:etiquetador/User/models/user.dart';
import 'package:etiquetador/User/repository/user_data_singleton.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';


class SideMenu extends StatefulWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  UserBloc userBloc;
  User user;

  Widget accountHeader() {
    return UserAccountsDrawerHeader(
        accountEmail: Text(userDataSingleton.email),
        accountName: Text(userDataSingleton.name),
        currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(userDataSingleton.imgUrl ))
      );
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          accountHeader(),
          ListTile(
            leading: Icon(Icons.panorama_fish_eye),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(
                    '/',
                    arguments: 'Home');
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.home),
          //   title: Text('Scan'),
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.of(context).pushNamed(
          //           '/scanPage',
          //           arguments: 'Scan');
          //  },
          // ),
          Divider(),
          ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: Text('Logout',
              style: TextStyle(color: Colors.red),),
              onTap: () {
                userBloc.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(
                      '/loginPage',
                      arguments: '');
              }),
        ],
      ),
    );
  }
}
