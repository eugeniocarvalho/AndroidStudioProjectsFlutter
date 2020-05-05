import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
                    controller: _emailController,
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
                    controller: _passController,
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
                      color: Theme
                          .of(context)
                          .primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          model.signIn(
                              email: _emailController.text,
                              pass: _passController.text,
                              onSuccess: onSuccess,
                              onFail: onFail);
                        }
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

  void onSuccess() {
    Navigator.of(context).pop();
  }

  void onFail() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Falha ao tentar entrar'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }
}