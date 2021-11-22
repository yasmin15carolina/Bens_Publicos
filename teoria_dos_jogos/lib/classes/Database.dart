import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teoria_dos_jogos/classes/maxLength.dart';
import 'package:teoria_dos_jogos/classes/user.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/store/dilemmaround_store.dart';

class Database {
  static validateKey(String key) async {
    String query = (key.length >= 2 && key.substring(0, 2) == "pg")
        ? "SELECT * FROM config_publicgoods WHERE `key`='" + key + "'"
        : "SELECT * FROM config_dilemma WHERE `key`='" + key + "'";
    // print(query);
    String body = await select(query);

    return jsonDecode(body)['table_data'] as List;
  }

  static select(String query) async {
    String url = "https://ccompjr.com.br/BeGapp/select.php";
    var res = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: {"query": query});
    return res.body;
  }

  static insert(String query) async {
    String url = "https://ccompjr.com.br/BeGapp/insert.php";
    var res = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: {"query": query});
    // print(res.body);
    return res.body;
  }

  getData() async {
    String theUrl = 'https://192.168.0.10/GameTheory/dillemma/getData.php';

    var res = await http.get(
      Uri.parse(theUrl),
      headers: {"Accept": "application/json"},
    );

    return jsonDecode(res.body);
  }

  static getPgExperimentMessages(String key) async {
    String query = "SELECT * FROM `popup_message_pg` WHERE `experiment`='$key'";
    String list = await select(query);
    print(query);
    print(list);
    return jsonDecode(list)['table_data'] as List;
  }

  static getPdExperimentMessages(String key) async {
    String query = "SELECT * FROM `popup_message_pd` WHERE `experiment`='$key'";
    String list = await select(query);
    print(query);
    print(list);
    return jsonDecode(list)['table_data'] as List;
  }

  static insertUser(User user) async {
    String theUrl = 'https://ccompjr.com.br/BeGapp/InsertUser.php';
    // print(user.name +
    //     user.age +
    //     user.cours +
    //     user.gender +
    //     user.occupation +
    //     user.educationLevel);
    var res = await http.post(Uri.parse(theUrl), headers: {
      "Accept": "application/json"
    }, body: {
      "name": user.name,
      "age": user.age.toString(),
      "gender": user.gender,
      "cours": user.cours,
      "educationLevel": user.educationLevel,
      "occupation": user.occupation,
      "experiment": user.experiment,
      "device": user.device
    });
    var resBody = jsonDecode(res.body.toString());
    return resBody;
  }

  static insertRounds(List<DilemmaRound> rounds, String userId) async {
    var i = 0;
    int cooperate = 0, compete = 0;
    for (i = 0; i < rounds.length; i++) {
      if (rounds[i].userChoice == 0) {
        cooperate++;
      } else {
        compete++;
      }
      int round = i + 1;
      String theUrl = 'https://ccompjr.com.br/BeGapp/dilemma/InsertRound.php';
      var res = await http.post(Uri.parse(theUrl), headers: {
        "Accept": "application/json"
      }, body: {
        "round": round.toString(),
        "computer": rounds[i].oponentChoice.toString(),
        "userChoice": rounds[i].userChoice.toString(),
        "userId": userId.toString(),
        "cooperate": cooperate.toString(),
        "defect": compete.toString()
      });
      String s = "rodada: " +
          round.toString() +
          " pc: " +
          rounds[i].oponentChoice.toString() +
          " usuario: " +
          rounds[i].userChoice.toString() +
          " userid: " +
          userId +
          "\n";
      var resBody = jsonDecode(res.body);
    }
  }

  static getDilemmaVariables() async {
    String theUrl =
        'https://ccompjr.com.br/BeGapp/dilemma/dilemma_variables.php';

    var res = await http.get(
      Uri.parse(theUrl),
      headers: {"Accept": "application/json"},
    );

    return res.body; //jsonDecode(res.body);
  }

  static getMaxLength(String table, String column) async {
    String query =
        "SELECT character_maximum_length FROM information_schema.columns WHERE table_name = '" +
            table +
            "' AND COLUMN_NAME='" +
            column +
            "'";

    String body = await select(query);
    var json = jsonDecode(body)['table_data'];

    MaxLength maxLength = MaxLength.fromJson(json[0]);
    // print("$column: ${maxLength.character_maximum_length}");
    return maxLength.character_maximum_length;
  }
}
