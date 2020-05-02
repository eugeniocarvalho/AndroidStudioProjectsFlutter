import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: 'Nome completo'),
              validator:(text) {
                if (text.isEmpty)
                  return 'Nome inválido';
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration:  InputDecoration(hintText: 'Email'),
              validator: (text) {
                if (text.isEmpty || !text.contains('@'))
                  return 'E-mail inválido';
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Senha',
              ),
              obscureText: true,
              validator: (text) {
                if (text.isEmpty || text.length < 6)
                  return 'Senha inválida';
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(hintText: 'Edenreço'),
              validator: (text){
                if (text.isEmpty)
                  return 'Endereço inválido';
                return null;
              },
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 44,
              child: RaisedButton(
                child: Text(
                  'Cadastrar-se',
                  style: TextStyle(fontSize: 18)),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  if(_formKey.currentState.validate()){
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
