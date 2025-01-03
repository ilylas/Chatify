import 'dart:async';

import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/Database_service.dart';
import 'authentificationprovider.dart';

import '../models/chat_user.dart';
import '../models/chat_message.dart';
import '../models/chat.dart';

class ChatPageProvider extends ChangeNotifier{

  AuthentificationProvider _auth;

  late DatabaseService _db;

  List<Chat>? chats;

  late StreamSubscription _chatStream;

  ChatPageProvider(this._auth) {
    _db = GetIt.instance.get<DatabaseService>();
    getChats();
  }

  @override
  void dispose() {
    _chatStream.cancel();
    super.dispose();
  }

  void getChats() async {
    try{
      _chatStream = _db.getChatsForUser(_auth.user.uid).listen((_snapshot) async{
        chats =await Future.wait(
          _snapshot.docs.map((_d) async {
          Map<String, dynamic> _chatData = _d.data() as  Map<String, dynamic>;
          //Get Users in Chat
          List<ChatUser> _members = [];
          for (var _uid in _chatData["members"]){
            DocumentSnapshot _userSnapShot = await _db.getUser(_uid);
            Map<String, dynamic> userDataMap =
                _userSnapShot.data() as Map<String, dynamic>;
            _members.add(ChatUser.fromJSON(userDataMap));
          }
          //Get last message in Chat
          List<ChatMessage> messages= [];
          QuerySnapshot _chatMessage = await _db.getLastMessageForChat(_d.id);

          if(_chatMessage.docs.isNotEmpty){
            Map<String, dynamic> _messageData = _chatMessage.docs.first.data()! as Map<String, dynamic>;
            ChatMessage _message = ChatMessage.fromJSON(_messageData);
            messages.add(_message);
          }

          //return chat instance
          return Chat(
              uid: _d.id,
              currentUserId: _auth.user.uid,
              activity: _chatData["is_activity"],
              group: _chatData["is_group"],
              members: _members,
              messages: messages
          );
          }).toList(),
        );
        notifyListeners();
      });
    }
    catch(e){
      print(e);
    }
  }

}
