import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import '../models/journal_model.dart';

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
        "CREATE TABLE IF NOT EXISTS journals(journal_id INTEGER AUTOINCREMENT PRIMARY KEY, journal_head TEXT,"
        " journal_entry TEXT, is_synced INTEGER, is_fav INTEGER);";
    Directory documentsInDevice = await getApplicationDocumentsDirectory();
    String path = join(documentsInDevice.path, "journal_entries.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database d, int version) async {
      await d.execute(sql);
    });
  }

  createJournal(JournalClient newEntry) async {
    final dataBaseRef = await jdatabase;

    var operationResults = await dataBaseRef.rawInsert(
        "INSERT INTO journals(journal_id, journal_head, "
        "journal_entry, is_synced, is_fav) VALUES (${newEntry.journal_id}, ${newEntry.journal_head}, ${newEntry.journal_entry}, ${newEntry.is_synced},${newEntry.is_fav} )");

    return operationResults;
  }
}
