import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math';
import 'package:petitparser/petitparser.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String valor = '0', expression = '';

  void _clicked(String op) {
    setState(() {
      if (op == 'AC') {
        _reset();
      } else if (op == '⌫') {
        if (expression.length > 0) _remove();
      } else if (op == '=') {
        setState(() {
          valor = calcString(expression).toString();
        });
      } else
        setState(() {
          expression += op;
        });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
                 height: 150,
                ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(
                  '$expression',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 30),
                  maxLines: 1,
                ),
              ),
            ),
            Divider(),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(
                  '$valor',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 30),
                  maxLines: 1,
                ),
              )
            ),
            Divider(color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buttons('AC'),
                _buttons('⌫'),
                _buttons('%'),
                _buttons('/'),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buttons('1'),
                _buttons('2'),
                _buttons('3'),
                _buttons('*'),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buttons('4'),
                _buttons('5'),
                _buttons('6'),
                _buttons('-'),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buttons('7'),
                _buttons('8'),
                _buttons('9'),
                _buttons('+'),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buttons('.'),
                _buttons('0'),
                _buttons('='),
                _buttons('-'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buttons(String s) {
    return RaisedButton(
      onPressed: () {
        _clicked(s);
      },
      child: Text(
        s,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 40),
      ),
    );
  }

  void _reset() {
    expression = '';
    valor = '0';
  }

  void _remove() {
    expression = expression.substring(0, expression.length - 1);
  }

  Parser buildParser() {
    final builder = ExpressionBuilder();
    builder.group()
      ..primitive((pattern('+-').optional() &
              digit().plus() &
              (char('.') & digit().plus()).optional() &
              (pattern('eE') & pattern('+-').optional() & digit().plus())
                  .optional())
          .flatten('number expected')
          .trim()
          .map(num.tryParse))
      ..wrapper(
          char('(').trim(), char(')').trim(), (left, value, right) => value);
    builder.group()..prefix(char('-').trim(), (op, a) => -a);
    builder.group()..right(char('^').trim(), (a, op, b) => pow(a, b));
    builder.group()
      ..left(char('*').trim(), (a, op, b) => a * b)
      ..left(char('/').trim(), (a, op, b) => a / b);
    builder.group()
      ..left(char('+').trim(), (a, op, b) => a + b)
      ..left(char('-').trim(), (a, op, b) => a - b);
    builder.group()..left(char('%').trim(), (a, op, b) => a % b);
    return builder.build().end();
  }

  double calcString(String text) {
    final parser = buildParser();
    final input = text;
    final result = parser.parse(input);
    if (result.isSuccess)
      return result.value.toDouble();
    else
      return double.parse(text);
  }
}
