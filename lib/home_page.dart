import 'package:flutter/material.dart';
import './models/journal_crud.dart';
import './database/db_manager.dart';
import './models/journal_model.dart';

class JournalsList extends StatefulWidget {
  static String tag = 'journalsList';

  @override
  State<StatefulWidget> createState() {
    return _JournalsListState();
  }
}

class _JournalsListState extends State<JournalsList> {
  int noteCount = 0;
  final List<Map<String, dynamic>> dummyJournals = [
    {'head': 'Bounced Date', 'date': '14-Feb-019', 'id': 1},
    {'head': 'Flutter Study jam', 'date': '17-March-019', 'id': 2},
    {'head': 'Movie previews', 'date': '21-May-018', 'id': 3},
    {'head': 'Amazing assessment results', 'date': '16-Feb-019', 'id': 4},
    {'head': 'Travel and adventure', 'date': '30-Dec-018', 'id': 5},
    {'head': 'Meeting new catch', 'date': '01-Aug-017', 'id': 6},
    {'head': 'Crazy shoping', 'date': '14-Feb-016', 'id': 7}
  ];

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
              // dummyJournals.remove(dummyJournals[positionOfJournal]);
            });
          },
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  child: Text(
                    bunchOfJournals[positionOfJournal]['journal_head'][0],
                    style: TextStyle(color: Colors.deepOrange, fontSize: 18.0),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                title: Text(
                  bunchOfJournals[positionOfJournal]['journal_entry'],
                  style: TextStyle(fontFamily: 'Oswald', fontSize: 17.0),
                ),
                subtitle:
                    Text(bunchOfJournals[positionOfJournal]['journal_entry']),
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
              return JournalCrud();
            })).then((_) {});
          },
          child: Icon(Icons.edit),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
