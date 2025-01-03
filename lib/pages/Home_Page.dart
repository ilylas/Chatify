import 'package:chatify_app/pages/chats_page.dart';
import 'package:chatify_app/pages/users_page.dart';
import 'package:flutter/material.dart';


class Home_Page extends StatefulWidget{
  const Home_Page({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Home_Page_State();
  }


}

class Home_Page_State extends State<Home_Page>{

  int _currentPage=0;
  final List<Widget> _pages = [
    ChatsPage(),
    UsersPage()
  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildUI();
  }

  Widget buildUI(){
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (_index){
          setState(() {
            _currentPage= _index;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: "Chats",
              icon: Icon(Icons.chat_bubble_sharp)
          ),
          BottomNavigationBarItem(
              label: "Users",
              icon: Icon(
                  Icons.supervised_user_circle_sharp
              )
          )
        ],
      ),
    );
  }



}