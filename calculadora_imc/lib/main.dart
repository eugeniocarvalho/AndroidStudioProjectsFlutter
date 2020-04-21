import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController(),
      heightController = TextEditingController();
  String _infoText = "Informe Peso e Altura";
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe o Peso e Altura";
      _globalKey = GlobalKey<FormState>();
    });
  }

  void _calculateIMC() {
    setState(() {
      double peso = double.parse(weightController.text);
      double height = double.parse(heightController.text),
          result = peso / (height * height);

      result = result.roundToDouble();

      print(result);
      if (result <= 18.5)
        _infoText = "Abaixo do peso!\n Seu peso: $result";
      else if (result <= 24.9)
        _infoText = "Peso normal!\n Seu peso: $result";
      else if (result <= 29.9)
        _infoText = "Sobrepeso!\n Seu peso: $result";
      else if (result <= 34.9)
        _infoText = "Obesidade grau 1!\n Seu peso: $result";
      else if (result <= 39.9)
        _infoText = "Obesidade Grau 2!\n Seu peso: $result";
      else
        _infoText = "Obesidade Grau 3!\n Seu peso: $result";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 200,
                  color: Colors.grey,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso kg ex: 50.0",
                      labelStyle: TextStyle(color: Colors.deepOrangeAccent)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 25),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) return "Insira um peso";

                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura m ex: 1.70",
                      labelStyle: TextStyle(color: Colors.deepOrangeAccent)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 25),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) return "Insira uma Altura";

                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        if (_globalKey.currentState.validate()) {
                          _calculateIMC();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                      color: Colors.orange,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 25),
                ),
              ],
            ),
          ),
        ));
  }
}
