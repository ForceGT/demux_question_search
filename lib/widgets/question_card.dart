import 'dart:math';

import 'package:chips_choice/chips_choice.dart';
import 'package:demux_question_search/model/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuestionCard extends StatefulWidget {
  final Question question;

  QuestionCard({this.question});

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  final List<String> _tags = [];
  //Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.0),
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: Card(
        borderOnForeground: false,
        shadowColor: Colors.blueGrey,
        elevation: 8.0,
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: ListTile(
          dense: false,
          contentPadding: EdgeInsets.all(12.0),
            title: Text(
              "${widget.question.title}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text("Asked"),
                Text("${widget.question.frequency}", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text("Times")
              ],
            ),
            subtitle: ChipsChoice<String>.multiple(
                value: _tags,
                onChanged: (value){
                  debugPrint("Value: $value");
                },
                choiceItems: C2Choice.listFrom(
                    source: widget.question.tags["company"],
                    value: (i, v) => v,
                    label: (i, v) => v),
                choiceStyle: C2ChoiceStyle(
                    color: Colors.primaries[4], brightness: Brightness.dark
                ),
            )
        ),
      ),
    );
  }

  Widget getBadgeWitTitle() {}
}
