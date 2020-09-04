import 'dart:convert';

import 'package:etiquetador/Etiquetador/models/label_model.dart';
import 'package:etiquetador/Etiquetador/ui/widgets/side_menu.dart';
import 'package:etiquetador/User/bloc/user_bloc.dart';
import 'package:etiquetador/User/repository/user_data_singleton.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  UserBloc  userBloc;
  
  String actualImage;
  var jsonResult;
  int size;
  
  Table _gridField(){
    return Table(
      children: [
        TableRow(children:[
          _createChip(1, "Uno"),
          _createChip(2, "Dos"),
          _createChip(3, "Tres")
        ]),
        TableRow(children:[
          _createChip(4, "Cuatro"),
          _createChip(5, "Cinco"),
          _createChip(6, "Seis")
        ]),
        TableRow(children:[
          _createChip(7, "Siete"),
          _createChip(8, "Ocho"),
          _createChip(9, "Nueve")
        ]),
        TableRow(children:[
          _createChip(0, "Cero"),
          _createChip(10, "Nada"),
          _createChip(10, "Nada"),
        ])
      ],);
  }

  Widget _createChip(int number, String title){
    return ActionChip(
      onPressed: (){
        if (this.jsonResult["images"].length ==0){
          // reuest more images
        }
        print("hello");
        LabelModel labelModel = LabelModel(email: userDataSingleton.email,
                                          timestamp: DateTime.now().toIso8601String(),
                                          imagePath: this.actualImage,
                                          label: title);

        this.userBloc.updateLabelData(labelModel);

        this.jsonResult["images"].removeAt(0);
        setState(() {
          this.actualImage = this.jsonResult["images"][0];
        });

      },
      avatar: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey.shade800,
        child: Text((number == 10)? "": number.toString(), style: TextStyle(fontSize: 20),),
      ),
      label: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    );
  }

  Widget _showImage(String image){
    return Container(
      width: 250,
      height: 250,
      child: Image.asset(
          image,
          height: 200,
          width: 200,
          fit: BoxFit.fitWidth,
        ),
    );
  }
  Widget _handleBody(){
    return Column(
      children: <Widget>[
        SizedBox(height: 30,),
        (this.actualImage!= null)?_showImage(this.actualImage):CircularProgressIndicator(),
        SizedBox(height: 30,),
        _gridField(),
      ],
    );
  }

  Widget _appBar(String title){
    return Text(title);
  }


  @override
  void initState(){
    super.initState();

    DefaultAssetBundle.of(context).loadString("assets/data.json").then((onValue){
      this.jsonResult = json.decode(onValue);
      print(this.jsonResult);
      setState(() {
        this.actualImage = this.jsonResult["images"][0];
        this.size = this.jsonResult["images"].length;
      });
    });


  }

  @override
  Widget build(BuildContext context) {

    this.userBloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[Padding(
          padding: const EdgeInsets.all(8.0),
          child: (this.size !=null)?Text("TOTAL: ${this.size+456578}"):Text("TOTAL:") ,
        )],
        elevation: 10,
        title: _appBar(widget.title),
      ),
      drawer: SideMenu(),
      body: Center(
        child: this._handleBody(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), 
    );
  }
}


