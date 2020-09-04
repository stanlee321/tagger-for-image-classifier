import 'package:etiquetador/Etiquetador/models/color_models.dart';
import 'package:etiquetador/Etiquetador/routes/route_manager.dart';
import 'package:etiquetador/User/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          bloc: UserBloc(),
          child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Palette.white,
            bottomAppBarColor: Palette.white
          ),
          initialRoute: '/loginPage',
          onGenerateRoute: RouteGenerator.generateRoute,
      ),
        );
  }

}
