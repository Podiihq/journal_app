import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './auth/sign_up.dart';
import './auth/sign_in.dart';
import 'home_page.dart';

void main(){

  runApp(MyApp());}

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    SignInPage.tag: (context) => SignInPage(),
    SignUpNewUser.tag: (context) => SignUpNewUser(),
    HomePage.tag: (context) => HomePage(),
  };


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),

      home: SignUpNewUser()
      ,
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {


  }

}
