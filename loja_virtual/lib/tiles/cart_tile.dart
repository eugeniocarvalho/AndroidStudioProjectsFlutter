import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/cart_product.dart';
import 'package:lojavirtual/datas/product_data.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {}

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProduct.productData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection('products')
                  .document(cartProduct.category)
                  .collection('itens')
                  .document(cartProduct.pid)
                  .get(),
              //esse snapshot é o dado que acabamos de obter do BD
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //convertendo o documento que recebe do firebase e
                  // armazenando no producData, para que nao tenha que procurar toda vez
                  //salvos os dados
                  cartProduct.productData =
                      ProductData.fromDocument(snapshot.data);
                  //mostro os dados
                  return _buildContent();
                } else
                  return Container(
                    height: 70,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
              },
            )
          :
          //se ja tem todos os dados, mostro os dados
          _buildContent(),
    );
  }
}
