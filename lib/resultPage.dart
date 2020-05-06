import 'package:flutter/material.dart';
import 'package:quizapp/home.dart';

class ResultPage extends StatelessWidget {

  final int totalScore;
  final int totalQuiz;
  double percentage;

  ResultPage({ Key key, @required this.totalScore, @required this.totalQuiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You got $totalScore out of $totalQuiz correct answers',
                style: TextStyle(fontSize: 23.0, color: Colors.indigo),
              ),
              SizedBox(height: 20.0,),
              Container(
                padding: EdgeInsets.all(20.0),
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.all(
                    Radius.circular(140.0)
                  )
                ),
                child: Center(
                  child: Container(
                    width: 139.0,
                    height: 139.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(139.0)
                      )
                    ),
                    child: Center(
                      child: Text(
                        '${((totalScore / totalQuiz) * 100).round() }' + '%',
                        style: TextStyle(fontSize: 30.0, color: Colors.indigo),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.0,),
              RaisedButton(
                padding: EdgeInsets.all(15.0),
                color: Colors.indigo,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Homepage()
                  ));
                },
                child: Text(
                  'Try Again',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
