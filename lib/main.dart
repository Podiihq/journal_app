import 'package:flutter/material.dart';
import './auth/sign_up.dart';
import './auth/sign_in.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    SignInPage.tag: (context) => SignInPage(),
    SignUpNewUser.tag: (context) => SignUpNewUser(),
    JournalsList.tag: (context) => JournalsList(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,

      ),
      //Sign up page is first fired up, will change once homepage is placed
      home: SignInPage(),
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
  Widget build(BuildContext context) {}
}
