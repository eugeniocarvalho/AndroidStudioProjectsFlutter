import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Carrinho'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
              int p = model.products.length;
              //se for nulo mostra 0
              return Text(
                '${p ?? 0} ${p <= 1 ? 'ITEM' : 'ITENS'}',
                style: TextStyle(fontSize: 18),
              );
            }),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
        if (model.isLoading && UserModel.of(context).isLoggedIn())
          return Center(child: CircularProgressIndicator());
        else if (!UserModel.of(context).isLoggedIn())
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.remove_shopping_cart,
                    size: 80, color: Theme.of(context).primaryColor),
                SizedBox(height: 16),
                Text(
                  'Faça o login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                RaisedButton(
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    })
              ],
            ),
          );
          else if (model.products == null || model.products.length == 0)
            return Center(
              child: Text('Nenhum item adicionado no carrinho',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center
              ),
            );

        return null;
      }),
    );
  }
}
