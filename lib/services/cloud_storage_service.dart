
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

const String USER_COLLECTION = 'Users';

class CloudStorageService {

  final FirebaseStorage _storage = FirebaseStorage.instance;

  CloudStorageService();

  Future<String?> saveuserImageToStorage(String uid, PlatformFile file) async {
    try{
      Reference ref= _storage.ref().child('images/users/$uid/profile.${file.extension}');
      UploadTask task= ref.putFile(
        File(file.path!),
      );
      return await task.then((result)=> result.ref.getDownloadURL());
    }
    catch(e){
      print(e);
    }
  }

  Future<void> saveUserProfileImage(String userId, String imageUrl) async {
    final userRef = FirebaseFirestore.instance.collection('Users').doc(userId);
    await userRef.update({
      'profileImage': imageUrl,
    });
  }

  Future<String?> saveChatImageToStorage(String chatID, String userID, PlatformFile file) async{
    try{
      Reference ref= _storage.ref().child('images/chats/$chatID/${userID}_${Timestamp.now().millisecondsSinceEpoch}.${file.extension}');
      UploadTask task= ref.putFile(
        File(file.path!),
      );
      return await task.then((result)=> result.ref.getDownloadURL());
    }
    catch(e){
      print(e);
    }
  }

}