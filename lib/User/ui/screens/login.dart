//import 'package:etiquetador/barcode/ui/screens/home.dart';
import 'package:etiquetador/Etiquetador/ui/screens/homeView.dart';
import 'package:etiquetador/User/bloc/user_bloc.dart';
import 'package:etiquetador/User/models/user.dart';
import 'package:etiquetador/User/repository/user_data_singleton.dart';
import 'package:etiquetador/Widgets/button_green.dart';
import 'package:etiquetador/Widgets/gradient_back.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User user;
  UserBloc userBloc;

  Widget signInGoogleUI(double height) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack(title: "", height: height),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 30, right:30),
                child: Text(
                  "¡Por la democracia!. Ayúdanos a etiquetar los números escritos a mano de las mesas.",
                  style: TextStyle(
                      fontSize: 37.0,
                      fontFamily: "Lato",
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              
              ButtonGreen(
                text: "Login with Gmail",
                onPressed: () {
                  userBloc.signOut();
                  userBloc.signIn().then((FirebaseUser user) {
                    userBloc.updateUserData(User(
                        uid: user.uid,
                        name: user.displayName,
                        email: user.email,
                        photoURL: user.photoUrl));
                  });
                },
                width: 300.0,
                height: 50.0,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget loadHome(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print("No logeado");
      return Container(
        color: Colors.white,
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("No se pudo cargar la información. Haz login")
          ],
        ),
      );
    } else {
      print("Logeado");
      user = User(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoUrl);

      userDataSingleton.uid = user.uid;
      userDataSingleton.email = user.email;
      userDataSingleton.name = user.name;
      userDataSingleton.imgUrl = user.photoURL;
      
      return HomeView(
        title: "Home",
      );
    }
  }

  Widget _handleCurrentSession(double height) {
    return StreamBuilder(
        stream: userBloc.authStatus,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //snapshot- data - Object User
          if (!snapshot.hasData || snapshot.hasError) {
            return signInGoogleUI(height);
          } else {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.none:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return loadHome(snapshot);
                case ConnectionState.done:
                  return loadHome(snapshot);
                }
              }
          return Center(child: CircularProgressIndicator(),);
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    userBloc = BlocProvider.of(context);
    return _handleCurrentSession(height);
  }
}
