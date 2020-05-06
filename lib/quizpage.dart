import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/resultPage.dart';

class GetJson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("assets/quiz.json"),
      builder: (context, snapshot){
        List myData = jsonDecode(snapshot.data.toString());
        if(myData == null) {
          return Scaffold(
            body: Center(
              child: Text(
                'Loading',
              ),
            ),
          );
        } else {
          return QuizPage(myData : myData);
        }
      },
    );
  }
}

class QuizPage extends StatefulWidget {

  var myData;
  QuizPage({Key key, @required this.myData}) : super(key : key);

  @override
  _QuizPageState createState() => _QuizPageState(myData);
}

class _QuizPageState extends State<QuizPage> {

  var myData;
  _QuizPageState(this.myData);

  int quizNumber;
  int totalQuiz;
  int score = 0;
  bool _isButtonDisabled;
  bool _answerSelected;

  Color colorToShow = Colors.indigo;
  Color colorNotToShow = Colors.red;
  Color right = Colors.green;
  Color wrong = Colors.red;

  Map<String, Color> buttonColor = {
    "a": Colors.indigo,
    "b": Colors.indigo,
    "c": Colors.indigo,
    "d": Colors.indigo,
  };

  @override
  void initState() {
    _isButtonDisabled = false;
    _answerSelected = false;
    quizNumber = 1;
    totalQuiz = myData[0].length;
  }

  void nextQuestion() {
    setState(() {
      if(quizNumber < totalQuiz) {
        quizNumber++;
      } else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ResultPage(totalScore: score, totalQuiz: totalQuiz,)
        ));
      }
      buttonColor["a"] = Colors.indigo;
      buttonColor["b"] = Colors.indigo;
      buttonColor["c"] = Colors.indigo;
      buttonColor["d"] = Colors.indigo;
      _isButtonDisabled = false;
    });
  }

  void checkAnswer(String k) {
    if(myData[2]['$quizNumber'.toString()] == k){
      score += 1;
      colorToShow = right;
    } else {
      colorToShow = wrong;
    }
    setState(() {
      buttonColor[k] = colorToShow;
      buttonColor[myData[2]['$quizNumber'.toString()]] = right;
      _isButtonDisabled = true;
      _answerSelected = true;
    });
  }

  Widget optionButtons(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: MaterialButton(
        highlightColor: Colors.indigoAccent,
        splashColor: Colors.indigoAccent,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        minWidth: 300.0,
        onPressed: () => _isButtonDisabled ? null : checkAnswer(k),
        color: buttonColor[k],
        child: Text(
            myData[1]['$quizNumber'.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Quiz App'
            ),
            content: Text(
              'You cannot go back at this stage!'
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                    'Ok',
                ),
              )
            ],
          )
        );
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20.0),
                      child: Text(
                        '$quizNumber of $totalQuiz',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20.0),
                      child: Text(
                        'Score: $score',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        myData[0]['$quizNumber'.toString()],
                        style: TextStyle(color: Colors.indigo, fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        optionButtons('a'),
                        optionButtons('b'),
                        optionButtons('c'),
                        optionButtons('d')
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
                decoration: BoxDecoration(
                    color: Colors.blue
                ),
                child: RaisedButton(
                  color: Colors.indigo,
                  onPressed: () => _answerSelected ? nextQuestion() : null,
                  child: Text(
                    'Next Question',
                    style: TextStyle(color: Colors.white, fontSize: 18.0, letterSpacing: 2.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
