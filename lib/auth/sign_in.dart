import 'package:flutter/material.dart';
import 'package:journal_app/home_page.dart';
import './sign_up.dart';

class SignInPage extends StatefulWidget {
  static String tag = 'sign-in-page';

  @override
  State<StatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      backgroundColor: Theme.of(context).primaryColorLight,
      child: Text(
        "JA",
        style: TextStyle(
          fontSize: 85,
          fontFamily: 'Roboto',
        ),
      ),
      radius: 80.0,
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Your email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
    );

    final signupButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(JournalsList.tag);
          },
          padding: EdgeInsets.all(12),
          color: Colors.purpleAccent,
          child: Text(
            'Log In',
            style: TextStyle(color: Colors.white),
          ),
        ));

    final signUpLead =  Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(SignUpNewUser.tag);
          },
          padding: EdgeInsets.all(12),
          //color: Colors.purpleAccent,
          child: Text(
            'No Account ? Sign up intead',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ));

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 15.0),
              email,
              SizedBox(height: 15.0),
              password,
              SizedBox(height: 15.0),
              signupButton,
              SizedBox(height: 15.0),
              signUpLead
            ],
          ),
        ));
  }
}
