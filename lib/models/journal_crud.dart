import 'package:flutter/material.dart';
import '../database/db_manager.dart';
import './journal_model.dart';
import 'package:intl/intl.dart';

class JournalCrud extends StatefulWidget {
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

  Widget pageStructureContent(BuildContext context) {
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
              _buildJournalTitleTextField(),
              _buildJournalEntryTextField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJournalTitleTextField() {
    return TextFormField(
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

  Widget _buildJournalEntryTextField() {
    return TextFormField(
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
        );

        JournalDatabase.db.createJournal(x);

        Navigator.pop(context, "dont");

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Journal'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_border),
            )
          ],
        ),
        body: pageStructureContent(context),
      ),
    );
  }
}