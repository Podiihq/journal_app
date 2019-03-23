import 'package:flutter/material.dart';
import 'package:journal_app/home_page.dart';

class SignUpNewUser extends StatefulWidget {
  static String tag = 'sign-up-page';

  @override
  State<StatefulWidget> createState() {
    return _SignUpNewUserState();
  }
}

class _SignUpNewUserState extends State<SignUpNewUser> {
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

    final username = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Email',
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

    final confirmPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Confirm Password',
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
    );

    final signupButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(JournalsList.tag);
          },
          padding: EdgeInsets.all(12),
          color: Theme.of(context).accentColor,
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
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
              SizedBox(
                height: 25.0,
              ),
              username,
              SizedBox(height: 25.0),
              email,
              SizedBox(height: 25.0),
              password,
              SizedBox(height: 25.0),
              confirmPassword,
              SizedBox(
                height: 25.0,
              ),
              signupButton,
            ],
          ),
        ));
  }
}
