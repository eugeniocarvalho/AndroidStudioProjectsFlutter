import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorGrid extends StatefulWidget {
  @override
  _CalculatorGridState createState() => _CalculatorGridState();
}

class _CalculatorGridState extends State<CalculatorGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        childAspectRatio: 1.5,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        padding: EdgeInsets.all(8),
        crossAxisCount: 4,
        children: <Widget>[
          _buttons('AC'),
          _buttons('⌫'),
          _buttons('%'),
          _buttons('/'),
          _buttons('1'),
          _buttons('2'),
          _buttons('3'),
          _buttons('x'),
          _buttons('4'),
          _buttons('5'),
          _buttons('6'),
          _buttons('-'),
          _buttons('7'),
          _buttons('8'),
          _buttons('9'),
          _buttons('+'),
          _buttons(','),
          _buttons('0'),
          _buttons('.'),
          _buttons('-'),
        ],
      ),
    );
  }

  Widget _buttons(String s) {
    return RaisedButton(
      onPressed: (){

      },
      child: Text(
        s,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
