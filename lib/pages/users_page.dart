import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';


class UsersPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserPageState();
  }

}


class _UserPageState extends State<UsersPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildUI();
  }

  Widget buildUI(){
    return Scaffold(
      backgroundColor:Colors.green ,
    );
  }



}