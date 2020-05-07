import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/datas/cart_product.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  //para ter o usuario atual
  UserModel user;

  //tem todos os produtos do carrinho
  List<CartProduct> products = [];

  bool isLoading = false;

  //quando criar o cart, passa o usuario atual, para
  // armazenar os dados no usuario atual
  CartModel(this.user);

  //serve pra acessar o cartModel de qualquer lugar do app
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    //salvando o item do carrinho e pegando o id do carrinho e salvando tambem
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance.collection('users').document(user.firebaseUser.uid).collection('cart').document(cartProduct.cid).delete();

    products.remove(cartProduct);
    notifyListeners();
  }
}
