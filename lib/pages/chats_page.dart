import 'package:chatify_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../providers/authentificationprovider.dart';
import '../providers/chats_page_provider.dart';
import '../widgets/custom_list_view_tiles.dart';



class ChatsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatPageState();
  }



}

class _ChatPageState extends State<ChatsPage>{
  late double deviceheight;
  late double devicewidth;

  late AuthentificationProvider _auth;
  late ChatPageProvider _pageProvider; 

  @override
  Widget build(BuildContext context) {
    deviceheight= MediaQuery.of(context).size.height;
    devicewidth= MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthentificationProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatPageProvider>(
            create: (_) => ChatPageProvider(_auth)
        ),
      ],
      child: buildUI(),
    );
  }

  Widget buildUI(){
    return Builder(builder: (BuildContext context) {
      _pageProvider = context.watch<ChatPageProvider>();
      return Container(
          padding: EdgeInsets.symmetric(
            horizontal: devicewidth * 0.03,
            vertical: deviceheight * 0.02,
          ),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TopBar(
                  barTitle: 'Chats',
                  primaryAction: IconButton(
                    onPressed: (){
                      _auth.logout();
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Color.fromRGBO(0, 82, 218, 1.0),
                    ),
                  ),
                ),
                _chatList()
              ]
          )
      );
    });
  }
  Widget _chatList(){
    return Expanded(child: _chatTile());
  }

Widget _chatTile(){
  return CustomListViewTileWithActivity(
      height: deviceheight * 0.10,
      title: 'Ilyes Aljane',
      subtitle: 'Welcome',
      imagePath: 'https://i.pravatar.cc/300',
      isActive: false,
      isActivity: false,
      onTap: (){}
  );
}

}