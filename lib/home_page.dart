import 'package:flutter/material.dart';
import './models/journal_crud.dart';

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


  Widget _setFav(int position){
    return (position%2) == 0 ? Icon(Icons.favorite_border, color: Colors.red,) : Icon(Icons.favorite, color: Colors.red,);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Journals'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int positionOfJournal) {
            return Dismissible(
              key: Key(dummyJournals[positionOfJournal]['head']),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (DismissDirection swipedDir) {
                setState(() {
                  dummyJournals.remove(dummyJournals[positionOfJournal]);
                });
              },
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(dummyJournals[positionOfJournal]['head'][0], style: TextStyle(color: Colors.deepOrange, fontSize: 18.0),),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    title: Text(dummyJournals[positionOfJournal]['head'], style: TextStyle(fontFamily: 'Oswald',fontSize: 17.0),),
                    subtitle: Text(dummyJournals[positionOfJournal]['date']),
                    trailing: _setFav(noteCount = noteCount + 1),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: dummyJournals.length,
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 6.0,
          onPressed: () {

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return JournalCrud();
            })).then((_) {

            });
          },
          child: Icon(Icons.edit),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
