import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?key=465de70a";

void main() async {
  runApp(MaterialApp(
      home: Home(),
      theme: ThemeData(
          hintColor: Colors.amber,
          primaryColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
            hintStyle: TextStyle(color: Colors.amber),
          ))));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);

  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar, euro;
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double dolar = double.parse(text);

    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);

    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / euro).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.text = dolarController.text = euroController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          // ignore: missing_return
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(
                  child: Text(
                    "Carregando dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError)
                  return Center(
                    child: Text(
                      "Erro :/",
                      style: TextStyle(color: Colors.amber, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  var a = snapshot.data["results"]["stocks"]["IBOVESPA"]
                          ["name"],
                      b = snapshot.data["results"]["stocks"]["NASDAQ"]["name"];
                  List<String> nomes = <String>['$a', '$b'];

                  a = snapshot.data["results"]["stocks"]["IBOVESPA"]
                      ["location"];
                  b = snapshot.data["results"]["stocks"]["NASDAQ"]["location"];
                  List<String> location = <String>['$a', '$b'];

                  a = snapshot.data["results"]["stocks"]["IBOVESPA"]["points"];
                  b = snapshot.data["results"]["stocks"]["NASDAQ"]["points"];
                  List<String> points = <String>['$a', '$b'];

                  a = snapshot.data["results"]["stocks"]["IBOVESPA"]
                      ["variation"];
                  b = snapshot.data["results"]["stocks"]["NASDAQ"]["variation"];
                  List<String> variations = <String>['$a', '$b'];

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on,
                          size: 150,
                          color: Colors.amber,
                        ),
                        buildTextField(
                            "Real", "R\$", realController, _realChanged),
                        Divider(),
                        buildTextField(
                            "Dolar", "U\$", dolarController, _dolarChanged),
                        Divider(),
                        buildTextField(
                            "Euro", "€", euroController, _euroChanged),
                        Divider(),
                        Column(
                          children: <Widget>[
                            ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    height: 80,
                                    color: Colors.grey,
                                    child: RichText(
                                        text: TextSpan(
                                            text: 'Nome: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                            children: <TextSpan>[
                                          TextSpan(
                                              text: '${nomes[index]}\n',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(text: 'Location: '),
                                          TextSpan(
                                              text: '${location[index]}\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                          TextSpan(text: 'Points: '),
                                          TextSpan(
                                              text: '${points[index]}\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent,
                                                  fontSize: 18)),
                                          TextSpan(text: 'Variation: '),
                                          TextSpan(
                                              text: '${variations[index]}',
                                              style: TextStyle(
                                                  color: Colors.greenAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))
                                        ])));
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

Widget buildTextField(String label, String prefix,
    TextEditingController controlador, Function functionChanged) {
  return TextField(
    controller: controlador,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: "$prefix: "),
    style: TextStyle(color: Colors.amber, fontSize: 25),
    onChanged: functionChanged,
    keyboardType: TextInputType.number,
  );
}
