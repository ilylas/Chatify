import 'package:chatify_app/pages/Register_Page.dart';
import 'package:chatify_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//widgets
import '../widgets/custom_input_fields.dart';
import '../widgets/RoundedButton.dart';

//providers
import 'package:chatify_app/providers/authentificationprovider.dart';

//services

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }


}

class _LoginPageState extends State<LoginPage> {

  late double _deviceHeight;
  late double _deviceWidth;

  final _loginFormKey = GlobalKey<FormState>();

  late AuthentificationProvider _auth;
  late NavigationService navigation;

  String? email;
  String? password;
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _deviceHeight=MediaQuery.of(context).size.height;
    _deviceWidth=MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthentificationProvider>(context);
    navigation = GetIt.instance.get<NavigationService>();
    return _buildUI();
  }

  Widget _buildUI(){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth*0.03,
            vertical: _deviceHeight*0.02
        ),
        height: _deviceHeight*0.98,
        width: _deviceWidth*0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _pageTitle(),
            SizedBox(
              height: _deviceHeight * 0.04,
            ),
            _loginForm(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _loginButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            _registerAccountLink()
          ],
        ),
      ),
    );
  }
  
  Widget _pageTitle(){
    return SizedBox(
      height: _deviceHeight*0.10,
      child: Text('Chatify', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w600),),
    );
  }
  Widget _loginForm(){
    return SizedBox(
      height: _deviceHeight * 0.18,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTExtFormField(
                onSaved: (value){
                  setState(() {
                    email = value;
                  });
                },
                regEx: r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                hintText: "Email",
                obscureText: false
            ),
            CustomTExtFormField(
                onSaved: (value){
                  setState(() {
                    password = value;
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

  Widget _loginButton(){
    return RoundedButton(
        name: "Login",
        height: _deviceHeight*0.065,
        width: _deviceWidth*0.65,
        onPressed: (){
          if(_loginFormKey.currentState!.validate()){
            print("email: $email, Password: $password");
            _loginFormKey.currentState!.save();
            print("email: $email, Password: $password");
            _auth.loginUsingEmailAndPassword(email!, password!);
          }
          else {
            print("Validation failed");
          }
        }
    );
  }
  Widget _registerAccountLink(){
    return GestureDetector(
      onTap: () => navigation.navigateToPage(Register_Page()),
      child: Container(
        child:
        Text(
        "Don't have an account",
        style: TextStyle(
            color: Colors.blueAccent
        ),
        ),
      ),
    );
  }
}
