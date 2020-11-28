import 'package:chips_choice/chips_choice.dart';
import 'package:demux_question_search/model/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../utils/constants.dart';

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
        elevation: 4.0,
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            ListTile(
                dense: false,
                contentPadding:
                    EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                title: Text(
                  "${widget.question.title}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text("Asked"),
                    Text(
                      "${widget.question.frequency}",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("Times")
                  ],
                ),
                subtitle: ChipsChoice<String>.multiple(
                  value: _tags,
                  onChanged: (value) {
                    debugPrint("Value: $value");
                  },
                  choiceItems: C2Choice.listFrom(
                      source: widget.question.tags["company"],
                      value: (i, v) => v,
                      label: (i, v) => v),
                  choiceStyle: C2ChoiceStyle(
                      color: Colors.primaries[4], brightness: Brightness.dark),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 12.0, bottom: 8.0, left: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: getTextColor(widget.question.tags["difficulty"]
                          .toString()
                          .toUpperCase()),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      shape: BoxShape.rectangle
                    ),
                    padding: EdgeInsets.all(2),
                    child: Text(
                      "${widget.question.tags["difficulty"].toString().toUpperCase()} ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${widget.question.tags["type"].toString().toUpperCase()}",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getTextColor(String type) {
    if (type == "EASY") {
      return Constants.easygreenBg;
    } else if (type == "MEDIUM") {
      return Constants.mediumBg;
    } else {
      return Constants.hardRed;
    }
  }
}
