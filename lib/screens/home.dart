import 'package:demux_question_search/model/question.dart';
import 'package:demux_question_search/repository/network_service.dart';
import 'package:demux_question_search/widgets/bottom_sheet.dart';
import 'package:demux_question_search/widgets/question_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var result = [];
  NetworkRepository networkRepository = NetworkRepository();

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Questions")
        ,
        actions: [
          IconButton(
              icon: Icon(Icons.filter_alt_outlined),
              onPressed: () async {
                debugPrint("Icon Filter Pressed");
                result = await showModalBottomSheet(
                    elevation: 12.0,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16.0),
                            topLeft: Radius.circular(16.0))),
                    context: scaffoldKey.currentContext,
                    builder: (context) {
                      return CustomBottomSheet(
                        contextWithScaffold: context,
                      );
                    });
                debugPrint("Result: $result");
                setState(() {

                });
              })
        ],
      ),
      body:
          Column(
            children: [
             if( result.isNotEmpty)  Container(
                padding: EdgeInsets.all(16.0),
                width: double.maxFinite,
                color: Colors.blueGrey[50],
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Showing Results for:",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 5,),
                          Text("${result.where((element) => true)}",textAlign: TextAlign.start,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),)
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.close_outlined),
                        onPressed: () {
                          setState(() {
                            result = [];
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: result.isEmpty
                      ? networkRepository.getQuestionsFromApi()
                      : networkRepository.getFilteredQuestions(result),
                  builder: (context, AsyncSnapshot<List<Question>> snapshot) {
                    //debugPrint("Snapshot Data: ${snapshot.data.runtimeType}");
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var question = snapshot.data[index];
                            return QuestionCard(
                              question: question,
                            );
                          }
                      );
                      // return Center(
                      //   child: Text("Hi"),
                      // );
                    } else {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error.toString()}"),
                        );
                      }
                      else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  },
                ),
              )
            ],
          )
      ,



      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
