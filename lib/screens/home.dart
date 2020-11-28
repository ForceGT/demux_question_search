import 'dart:convert';

import 'package:demux_question_search/model/question.dart';
import 'package:demux_question_search/repository/network_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NetworkRepository networkRepository = NetworkRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hey"),
      ),
      body: FutureBuilder(
        future: networkRepository.getQuestionsFromApi(),
        builder: (context, AsyncSnapshot<List<Question>>snapshot) {
          debugPrint("Snapshot Data: ${snapshot.data.runtimeType}");
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
              var question = snapshot.data[index];
              return ListTile(
                title: Text("${question.title}"),
              );
            });
            // return Center(
            //   child: Text("Hi"),
            // );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
