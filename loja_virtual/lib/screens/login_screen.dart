import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Entrar'),
          centerTitle: true,
        ),
        body:
        //tudo que estiver abaixo no scopedModelDescedant vai ter acesso ao model
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());

          return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains('@'))
                        return 'Email Inválido';
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Senha'),
                    obscureText: true,
                    validator: (text) {
                      if (text.length < 6 || text.isEmpty)
                        return 'Senha inválida';
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Esqueci minha senha',
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      child: Text(
                        'Entrar',
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}

                        model.signIn();
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      child: Text(
                        'Criar conta',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        //ao clicar em criar conta abre a tela de criar conta
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ));
        }));
  }
}
