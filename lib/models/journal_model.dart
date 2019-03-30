import 'dart:convert';

/*
Creating a class instance for modeling the journal
 -Call every other time and pass through a request to be served.
 */

class JournalClient {
  int journal_id;
  String journal_head;
  String journal_entry;
  String journal_date;
  bool is_synced;
  bool is_fav;

  /*
  Indicate the params expected : Using {} to indicate 'named'
   */

  JournalClient(
      {this.journal_id,
      this.journal_head,
      this.journal_entry,
        this.journal_date,
      this.is_fav,
      this.is_synced});

  /*
  This factory expects the data in Map<'journal_head', 'whatever comes in'>, this indicate that
  the key for every Map is actually a sure String but the value is unpredictable 
  
  Converts the received content to an instance of JournalClient from JSON format
   */

  factory JournalClient.fromJson(Map<String, dynamic> json) =>
      new JournalClient(
          journal_id: json["journal_id"],
          journal_head: json["journal_head"],
          journal_entry: json["journal_entry"],
          journal_date: json["journal_date"],
          is_fav: json["is_fav"],
          is_synced: json["is_synced"]);

/*
Converts an instance to JSON format
 */
  Map<String, dynamic> toJson() => {
        "journal_id": journal_id,
        "journal_head": journal_head,
        "journal_entry": journal_entry,
    "journal_date": journal_date,
        "is_fav": is_fav,
        "is_synced": is_synced
      };
}
/*
'Convert' is a dart inbuilt function that can handle JSON formats
encode -> encodes the passed dict to json format 
decode -> extracts the key:value pair to dictionary format
 
 */

JournalClient journalFromJson(String str) {
  final jsonData = json.decode(str);
  return JournalClient.fromJson(jsonData);
}

String JournalTorJson(JournalClient received) {
  final fetchedData = received.toJson();
  return json.encode(fetchedData);
}
