import 'package:flutter/material.dart';
import './models/journal_crud.dart';
import './database/db_manager.dart';

class JournalsList extends StatefulWidget {
  static String tag = 'journalsList';

  @override
  State<StatefulWidget> createState() {
    return _JournalsListState();
  }
}

class _JournalsListState extends State<JournalsList> {
  int noteCount = 0;

  Widget _setFav(int position) {
    return (position % 2) == 0
        ? IconButton(
            icon: Icon(Icons.favorite_border),
            color: Colors.red,
            onPressed: () {},
          )
        : Icon(
            Icons.favorite,
            color: Colors.red,
          );
  }

  Widget fetchJournals() {
    //initialize the futureBuilder

    return FutureBuilder(
        future: JournalDatabase.db.fetchJournals(),
        /*the future param takes the guy whom we are waiting for and passes the  data
        to AsyncSnapshot when the data arrives, also note that the 
       snapshot carries two params: 1. Information about the request and 2. the actual response
       */
        builder: (BuildContext context, AsyncSnapshot<dynamic> received) {
          switch (received.connectionState) {
            case ConnectionState.none:
              return Text('Nothing is happening');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('Awaiting result...');
            case ConnectionState.done:
              if (received.hasError) return Text('Error: ${received.error}');
              /*
              Once the request is successful, call the painter to put things in place.
               */
              return paintReceivedJournals(received.data);
          }
        });
  }

  _showWarningDialog(BuildContext context, var journal_identifier) {
    /*
    This simple function shows a dialogbox warning the user that proceeding would
    result in loss of the data
     */
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Deletion"),
            content: Text("Sure to forget this moment?"),
            actions: <Widget>[
              FlatButton(
                child: Text("proceed"),
                onPressed: () {
                  var response = JournalDatabase.db.removeJournal(journal_identifier);
                  print(response);
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text("cancel"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  paintReceivedJournals(List bunchOfJournals) {
    /*
    This function takes in a list as param and returns a
    ListView.Builder that paints the homepage.
     */
    return ListView.builder(
      itemBuilder: (BuildContext context, int positionOfJournal) {
        return Dismissible(
          key: Key(bunchOfJournals[positionOfJournal]['journal_head']),
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.only(top: 25.0, right: 15.0),
            child: Text(
              'Delete',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30.0),
              textAlign: TextAlign.right,
            ),
          ),
          onDismissed: (DismissDirection swipedDir) {
            setState(() {
              _showWarningDialog(
                  context, bunchOfJournals[positionOfJournal]['journal_id']);
            });
          },
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: (){
                  //Fire the editing page when an item is tapped!
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return JournalCrud(isEditing: true,);
                  })).then((_) {});
                },
                leading: CircleAvatar(
                  child: Text(
                    bunchOfJournals[positionOfJournal]['journal_head'][0],
                    style: TextStyle(color: Colors.deepOrange, fontSize: 18.0),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                title: Text(
                  bunchOfJournals[positionOfJournal]['journal_head'],
                  style: TextStyle(fontFamily: 'Oswald', fontSize: 17.0),
                ),
                subtitle:
                    Text(bunchOfJournals[positionOfJournal]['journal_date'], textAlign: TextAlign.right,),
                trailing: _setFav(noteCount = noteCount + 1),
              ),
              Divider()
            ],
          ),
        );
      },
      itemCount: bunchOfJournals.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Journals'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: fetchJournals(),
        /*
        The body is built in the future, this means that the data used to create the body 
        is fetched from the db through an async method, which loads parallel with other 
        events, the body therefore might have to wait for sometime before it can be painted. 
         */
        floatingActionButton: FloatingActionButton(
          elevation: 6.0,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return JournalCrud(journalId: "1",isEditing: false,);
            })).then((_) {});
          },
          child: Icon(Icons.edit),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
