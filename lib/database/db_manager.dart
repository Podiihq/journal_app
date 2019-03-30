import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import '../models/journal_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class JournalDatabase {
  /*
  Singleton instance to ensure consistency -- only one way of modifying the db

   */
  JournalDatabase._();

  static final JournalDatabase db = JournalDatabase._();

  static Database _database;

  Future<Database> get jdatabase async {
    if (_database != null) return _database;

    /*
  case there's no instance to return...instantiate one:
  lazily though
   */
    _database = await initializeDB();

    return _database;
  }

  initializeDB() async {
    //relation creator statement:
    var sql =
        "CREATE TABLE IF NOT EXISTS journals(journal_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, journal_head TEXT,"
        " journal_entry TEXT, journal_date, is_synced INTEGER, is_fav INTEGER);";
    Directory documentsInDevice = await getApplicationDocumentsDirectory();
    String path = join(documentsInDevice.path, "journal_entries.db");
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database d, int version) async {
      await d.execute(sql);
    });
  }

  createJournal(JournalClient newEntry) async {
    final dataBaseRef = await jdatabase;

    var operationResults = await dataBaseRef.rawInsert(
        "INSERT INTO journals(journal_head, "
        "journal_entry, journal_date) VALUES ('${newEntry.journal_head}', '${newEntry.journal_entry}','${newEntry.journal_date}');");

    print("INSERTION RESULTS " + operationResults.toString());

    return operationResults;
  }

  fetchJournals() async {
    var readyDatabase = await jdatabase;
    var forcedList = await readyDatabase.query("journals");

    return forcedList;
  }

  fetchSingleJournal(int idToFetch) async {
    var readyDatabase = await jdatabase;
    var forcedList = await readyDatabase
        .query("journals", where: "journal_id = ?", whereArgs: [
      idToFetch,
    ]);

    return forcedList;
  }

  removeJournal(var journal_id) async {
    var readyDatabase = await jdatabase;
    var result = await readyDatabase
        .delete("journals", where: "journal_id = ?", whereArgs: [
      journal_id,
    ]);
    print(result);
    return result;
  }

  updateSingleJournal(JournalClient journal) async {
    var readyDatabase = await jdatabase;
   var result =  readyDatabase.rawUpdate(
        "UPDATE journals SET journal_head = ?, journal_entry = ? WHERE journal_id = ?",
        [journal.journal_head, journal.journal_entry, journal.journal_id]);
    print(result);
   return result;
  }
}
