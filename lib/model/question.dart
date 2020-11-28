// Model Object for the Question Posted on the main/home page

class Question {
  String id;
  String title;
  String frequency;
  Map<String, dynamic> tags;

  Question({this.id, this.title, this.tags, this.frequency});

  factory Question.fromJson(Map<String, dynamic> json) {
    var id = json["id"];
    var title = json["title"];
    var freq = json["frequency"];
    var tags = json["tags"];
    return Question(id: id, title: title, frequency: freq, tags: tags);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Question:"
        "id:$id, "
        "title:$title,"
        "frequency:$frequency,"
        "tags:$tags,";
  }


// Tags will be as follows
// Difficulty : Easy, Medium, Hard
// Company : Google, Amazon, Facebook, Microsoft, Adobe, Swiggy, Netflix, Apple, Uber, Oracle, Twitter, Cisco
// Type Of Job : Internship, Full Time, Work From Home
// TrendScore :
}
