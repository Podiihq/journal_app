import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    final alucard = Hero(
      tag: 'hero',
      child:Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/logo.png'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
          'Welcome Infinical',
          style: TextStyle(fontSize: 28.0,color: Colors.white),
      ),
    );

    final lorem =Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome Infinical.Thankyou for building your first app using Flutter',
        style:TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

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
          children: <Widget>[alucard,welcome,lorem],
        ),
      
    );


    return Scaffold(
      body: body,
    );
  }
}