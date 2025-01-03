import 'package:chatify_app/pages/Home_Page.dart';
import 'package:flutter/material.dart';

//pages
import 'package:chatify_app/pages/Login_page.dart';
import 'package:chatify_app/pages/splash_page.dart';
import 'package:provider/provider.dart';
import './pages/Register_Page.dart';

//services
import './services/navigation_service.dart';


//providers
import 'package:chatify_app/providers/authentificationprovider.dart';


void main() {
  runApp(
      SplashPage(
          Key: UniqueKey(),
          onInitializationComplete: (){
            runApp(const MainApp());
          }
      )
  );
}


class MainApp extends StatelessWidget{
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthentificationProvider>(
            create: (BuildContext context){
              return AuthentificationProvider();
            }
        )
      ],
      child: MaterialApp(
        title: 'Chatify',
        theme: ThemeData(
          //backgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
          scaffoldBackgroundColor: Color.fromRGBO (36, 35, 49, 1.0),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Color.fromRGBO(30 , 29, 37, 1.0)
          )
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login': (context) =>const LoginPage(),
          '/home' : (context) =>Home_Page(),
          '/register': (BuildContext context) => Register_Page()
        },
      ),
    );
  }

}