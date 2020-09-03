import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzy/questions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Question questionbank = Question();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: Padding(padding: EdgeInsets.all(10.0), child: Home()),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool correctAnswer;
  List<Icon> showResults = [];

  void checkAnswer(bool userSelectedAnswer) {
    correctAnswer = questionbank.getQuestionAnswer();
    if (userSelectedAnswer == correctAnswer) {
      if (questionbank.getQuestionNumber() >=
          questionbank.getQuestionLength() - 1) {
        Alert(context: context, title: "Finihed", desc: "Quiz Completed!")
            .show();
      } else {
        showResults.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      }
    } else {
      if (questionbank.getQuestionNumber() >=
          questionbank.getQuestionLength() - 1) {
        Alert(context: context, title: "Finsihed", desc: "Quiz Completed!")
            .show();
      } else {
        showResults.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionbank.getQuestionText(),
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                "True",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
                setState(() {
                  questionbank.nextQuestion();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                "False",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                setState(() {
                  questionbank.nextQuestion();
                });
              },
            ),
          ),
        ),
        Row(
          children: showResults,
        ),
      ],
    );
  }
}
