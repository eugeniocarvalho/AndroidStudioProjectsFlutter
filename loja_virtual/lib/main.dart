import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/cart_model.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //scpédmodel é para acessar o estado do usuario em qualquer lugar do app
    return ScopedModel<UserModel>(
        //tudo que estiver abaixo no scopedModel vai ter acesso ao Usermodel e
        // vai ser modificado, caso tenha alguma coisa aconteça no userMode
        model: UserModel(),
        //scoped do carrinho é abaixo do scoped do usuario porque o
        // carrinho precisa ter acesso ao usuario atual
        child: ScopedModel<CartModel>(
          model: CartModel(),
          child: MaterialApp(
            title: "Flutter's Clothing",
            theme: ThemeData(
                primarySwatch: Colors.lightBlue,
                primaryColor: Color.fromARGB(255, 4, 125, 141)),
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          ),
        ));
  }
}
