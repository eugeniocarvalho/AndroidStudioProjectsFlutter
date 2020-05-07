import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/datas/product_data.dart';

class CartProduct {
  //cid é cart ID, pid é product ID
  String cid, category, pid, size;
  int quantity;

  //os dados dos produtos dos carrinhos
  ProductData productData;

  CartProduct();

  //vai pegar todos os itens do carrinho e transformar num cart_product
  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    category = document.data['category'];
    pid = document.data['pid'];
    quantity = document.data['quantity'];
    size = document.data['size'];
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'pid' : pid,
      'quantity': quantity,
      'size': size,
      //'product': productData.toResumedMap()
    };
  }
}