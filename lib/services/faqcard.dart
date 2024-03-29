import 'package:flutter/material.dart';
import '../constant.dart';
import '../model.dart';

class FaqCard extends StatelessWidget {
  final Question question;
  const FaqCard({Key key, this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          boxShadow: [defaultShadow],
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              question.tanya,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
                color: mainColor,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              question.jawab,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
