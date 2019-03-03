import 'package:flutter/material.dart';
import 'package:journal_app/auth/sign_up.dart';


class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
}
}


class _HomePageState extends State {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
          'A simple journal app',
          style: TextStyle(fontSize: 28.0,color: Colors.white),
      ),
    );

    final lorem =Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Kindly Signup or Signin',
        style:TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    final signupButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(SignUpNewUser.tag);
          },
          padding: EdgeInsets.all(12),
          color: Colors.purpleAccent,
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ),
        ));


    final body =Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.purple,
          Colors.purpleAccent
        ]),
        ),
        child:Column(
          children: <Widget>[welcome,lorem,signupButton],
        ),
      
    );


    return Scaffold(
      body: body,
    );
  }
}