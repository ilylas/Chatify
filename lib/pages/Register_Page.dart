import 'package:chatify_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//services
import '../services/media_service.dart';
import '../services/Database_service.dart';
import '../services/cloud_storage_service.dart';

//widgets
import '../widgets/custom_input_fields.dart';
import '../widgets/RoundedButton.dart';
import '../widgets/rounded_image.dart';

//Providers
import '../providers/authentificationprovider.dart';

class Register_Page extends StatefulWidget{
  const Register_Page({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Register_Page_State();
  }


}

class _Register_Page_State extends State<Register_Page>{

  late double device_height;
  late double device_width;

  late AuthentificationProvider _auth;
  late DatabaseService _db;
  late CloudStorageService _cloudStorage;
  late NavigationService navigationService;

  final _registerFormKey= GlobalKey<FormState>();

  String? email;
  String? password;
  String? name;

  PlatformFile? _profileImage;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _auth = Provider.of<AuthentificationProvider>(context);
    _db= GetIt.instance.get<DatabaseService>();
    _cloudStorage= GetIt.instance.get<CloudStorageService>();
    navigationService = GetIt.instance.get<NavigationService>();
    device_height= MediaQuery.of(context).size.height;
    device_width= MediaQuery.of(context).size.width;

    return buildUI();
  }

  Widget buildUI(){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: device_width*0.03,
          vertical: device_height*0.02,
        ),
        height: device_height*0.98,
        width: device_width*0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileImageField(),
            SizedBox(
              height: device_height * 0.05,
            ),
            _registerForm(),
            SizedBox(
              height: device_height * 0.05,
            ),
            _registerButton(),
          ],
        ),
      ),
    );
  }

  Widget _profileImageField() {
    return GestureDetector(
      onTap:() {
        GetIt.instance.get<MediaService>().pickImageFromLibrary().then((file){
              setState(() {
                _profileImage= file;
              }
              );
            }
        );
      },
      child: () {
        if (_profileImage != null) {
          return RoundedImageFile(
            image: _profileImage!,
            size: device_height * 0.15,);
        }
        else {
          return RoundedImageNetwork(
              imagePath: 'https://i.pravatar.cc/1000?img=65',
              size: device_height * 0.15
          );
        }
      }(),
    );
  }

  Widget _registerForm(){
    return SizedBox(
      height: device_height*0.35,
      child:
      Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTExtFormField(
                onSaved: (value){
                  setState(() {
                    name=value;
                  });
                },
                regEx: r'.{8,}',
                hintText: "Name",
                obscureText: false
            ),
            SizedBox(
              height: device_height * 0.05,
            ),
            CustomTExtFormField(
                onSaved: (value){
                  setState(() {
                    email=value;
                  });
                },
                regEx:r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                hintText: "Email",
                obscureText: false
            ),
            SizedBox(
              height: device_height * 0.05,
            ),
            CustomTExtFormField(
                onSaved: (value){
                  setState(() {
                    password=value;
                  });
                },
                regEx: r".{8,}",
                hintText: "Password",
                obscureText: true
            )
          ],
        ),
      ),
    );
  }
  Widget _registerButton(){
    return RoundedButton(
        name: 'Register',
        height: device_height*0.065,
        width: device_width*0.65,
        onPressed: () async {
          if (_registerFormKey.currentState!.validate() && _profileImage != null){
            _registerFormKey.currentState!.save();
            String? uid= await _auth.registerUserUsingEmailAndPassword(email!, password!);
            String? imageURL= await _cloudStorage.saveuserImageToStorage(uid!, _profileImage!);

            await _db.createUser(uid, email!, name!, imageURL!);
            await _auth.logout();
            await _auth.loginUsingEmailAndPassword(email!, password!);
            navigationService.goBack();
          }
        },
    );
  }


}