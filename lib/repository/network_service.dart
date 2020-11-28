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

  Future<List<Question>> getFilteredQuestions(List<String> preferences) async {
    var allQuestions = await getQuestionsFromApi();
    List<Question> filteredQuestions = [];
    for (var question in allQuestions) {
      var difficulty = question.tags["difficulty"] as String;
      var companyList = question.tags["company"] as List;
      var jobType = question.tags["type"] as String;
      preferences.forEach((pref) {
        if (pref.toLowerCase() == difficulty.toLowerCase() ||
            companyList.contains(pref) ||
            jobType.toLowerCase() == pref.toLowerCase())
          filteredQuestions.add(question);
      });
    }
    return filteredQuestions;
  }
}
