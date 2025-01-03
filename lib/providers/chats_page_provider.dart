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

  }

}
