import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  final BuildContext contextWithScaffold;

  CustomBottomSheet({this.contextWithScaffold});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  bool showOk = false;

  List<String> _tags = [];

  List<String> companies = [
    'Google',
    'Amazon',
    'Facebook',
    'Microsoft',
    'Adobe',
    'Swiggy',
    'Netflix',
    'Apple',
    'Uber',
    'Oracle',
    'Twitter',
    'Cisco',
  ];

  List<String> typeOfJob = ['Work From Home', 'Full Time'];

  List<String> difficulties = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
          ),
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Filters",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 20)),
              showOk
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          child: Text("DONE", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          onTap: () {
                            //debugPrint("Tags: $_tags");
                            Navigator.pop(widget.contextWithScaffold, _tags);
                          }),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
        Divider(
          indent: 20,
          endIndent: 20,
          thickness: 2.0,
        ),
        SizedBox(
          height: 5,
        ),

        // Section 1

        getSectionTitle(title: "Companies"),
        getSectionContent(values: companies),
        SizedBox(
          height: 5,
        ),

        // Section 2

        getSectionTitle(title: "Type Of Job"),
        getSectionContent(values: typeOfJob),
        SizedBox(
          height: 5,
        ),

        // Section 3

        getSectionTitle(title: "Difficulties"),
        getSectionContent(values: difficulties)
      ],
    );
  }

  Widget getSectionTitle({String title}) {
    return Container(
      padding: EdgeInsets.all(12),
      width: double.maxFinite,
      child: Text("$title:",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500,
              fontSize: 18)),
    );
  }

  Widget getSectionContent({List<String> values}) {
    return Flexible(
      fit: FlexFit.loose,
      child: ChipsChoice<String>.multiple(
        value: _tags,
        onChanged: (state) {
          debugPrint("State $state");
          setState(() {
            _tags = state;
            showOk = state.isNotEmpty;
          });
        },
        choiceItems: C2Choice.listFrom(
            source: values,
            value: (index, value) {
              return value;
            },
            label: (index, value) {
              return value;
            }),
        choiceStyle: C2ChoiceStyle(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        choiceActiveStyle:
            C2ChoiceStyle(color: Colors.pink, brightness: Brightness.dark),
      ),
    );
  }
}
