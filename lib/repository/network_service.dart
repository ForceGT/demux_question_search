import 'dart:convert';

import 'package:demux_question_search/model/question.dart';
import 'package:demux_question_search/utils/constants.dart';
import 'package:http/http.dart' as http;

class NetworkRepository {
  Future<List<Question>> getQuestionsFromApi() async {
    var response = await http.get(Constants.API_ENDPOINT);
    var jsonResponse = jsonDecode(response.body);
    var listOfQuestionsJson = jsonResponse as List<dynamic>;
    //debugPrint("ListOfQuestionsJson: $listOfQuestionsJson");
    return listOfQuestionsJson.map((e) {
      var question = Question.fromJson(e);
      return question;
    }).toList();
  }
}
