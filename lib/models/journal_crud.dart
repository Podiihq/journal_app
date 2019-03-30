import 'package:flutter/material.dart';
import '../database/db_manager.dart';
import './journal_model.dart';
import 'package:intl/intl.dart';

class JournalCrud extends StatefulWidget {
  final int journalId;
  final bool isEditing;

  JournalCrud({this.journalId, this.isEditing});

  @override
  State<StatefulWidget> createState() {
    return _JournalCrudState();
  }
}

class _JournalCrudState extends State<JournalCrud> {
  /*
  Create an entry of Map that will store the journal data captured
   */
  final Map<String, dynamic> journalEntryForm = {
    'journal_head': null,
    'journal_entry': null,
    'is_fav': null,
  };
  var today = new DateTime.now();
  var formatted = new DateFormat("y-MMMM-d");

  /*
  A key is also required by a form for identification of operations specialized to the form
   */
  final GlobalKey<FormState> _journalFormGlobalKey = GlobalKey<FormState>();

  /*
  Build the widget tree beforehand for display on the create-new-journal page
   */

  Widget pageStructureContent(BuildContext context, String head, String entry) {
    /*
  Probe the screen size in order to provide something cool
  when painting particular widgets on the screen.
  This handles padding and margins when different screen sizes are used
  
  Orientation is also handled here in a small bit 
  The padding sizes can be regulated when painting the widget by passing a parameter that
  is conversant with whatever size of screen is at the disposal
   
   MediaQuery is the key agent
   */
    final double mDeviceWidth = MediaQuery.of(context).size.width;
    final double mTargetWidth =
        mDeviceWidth > 550.0 ? 500 : mDeviceWidth * 0.95;
    final double mPadding = mDeviceWidth - mTargetWidth;

    return GestureDetector(
      /*
    The gesture detector is used to control when the soft-keyboard should 
    be closed: this happens in the event that the user taps
    outside the textfields
    
     */
      onTap: () {
        //FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _journalFormGlobalKey,
          //inject the key here as the form is brought to life
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: mPadding / 2),
            children: <Widget>[
              /*
            Build the fields necessary for display
             */
              _buildJournalTitleTextField(head),
              _buildJournalEntryTextField(entry),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInEditMode(int selected) {
    //initialize the futureBuilder

    return FutureBuilder(
        future: JournalDatabase.db.fetchSingleJournal(selected),
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

              return pageStructureContent(
                  context,
                  received.data[0]['journal_head'],
                  received.data[0]['journal_entry']);
          }
        });
  }

  Widget _buildJournalTitleTextField(String head) {
    return TextFormField(
        initialValue: head == null ? "" : head,
        /*
      Validator just validates
      There are only two rules here for the title:
      1. Should not be empty
      2. 5 chars min
       */

        validator: (String titleProvided) {
          if (titleProvided.isEmpty || titleProvided.length < 5) {
            return 'Title is required, 5 characters min';
          }
        },
        onSaved: (String value) {
          journalEntryForm['journal_head'] = value;
        },
        decoration: InputDecoration(
          hintText: 'Your awsome title',
        ));
  }

  Widget _buildJournalEntryTextField(String entry) {
    return TextFormField(
      initialValue: entry == null ? "" : entry,
      maxLines: 60,
      validator: (String animalName) {
/*
No need to validate: let the user decide - even an empty entry is ok
 */
      },
      onSaved: (String name) {
        journalEntryForm['journal_entry'] = name;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Journal notes',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Initialize a waiter-gate, this will execute when the user goes back
    return WillPopScope(
      onWillPop: () {
        if (!_journalFormGlobalKey.currentState.validate()) return null;
        _journalFormGlobalKey.currentState.save();

        JournalClient x = JournalClient(
          journal_head: journalEntryForm['journal_head'],
          journal_entry: journalEntryForm['journal_entry'],
          journal_date: formatted.format(today),
          journal_id: widget.journalId,
        );
        if(widget.isEditing){
          /*
          Run an update if is in edit mode,
          remember that the model is created with all the fields but the
          db_manager client will only collect whatever is needed.
           */
          JournalDatabase.db.updateSingleJournal(x);
        }else {
          /*
          This handles the case where the user is creating a new entry
           */
          JournalDatabase.db.createJournal(x);
        }

        Navigator.pop(context, true);

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: widget.isEditing ? Text('Refine journal') : Text('Create Journal'),
          actions: <Widget>[
            IconButton(
              onPressed: () {

                  //user discards changes...
                  Navigator.pop(context, true);

              },
              icon: Icon(Icons.cancel),
            ),
            IconButton(
              onPressed: () {

                  //user discards changes...
                  Navigator.pop(context, true);

              },
              icon: Icon(Icons.favorite_border),
            ),
          ],
        ),
        body: widget.isEditing
            ? buildInEditMode(widget.journalId)
            : pageStructureContent(context, null, null),
      ),
    );
  }
}
