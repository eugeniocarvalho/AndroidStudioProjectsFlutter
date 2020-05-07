import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/cart_product.dart';
import 'package:lojavirtual/datas/product_data.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: 120,
            child: Image.network(
              cartProduct.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    cartProduct.productData.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18
                    )
                  ),
                  Text(
                    'Tamanho ${cartProduct.size}',
                    style: TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 18
                    ),
                  ),
                  Text(
                    'R\$ ${cartProduct.productData.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                            Icons.remove),
                             onPressed: (){}
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                          icon: Icon(
                              Icons.add),
                              onPressed: (){}
                      ),
                      IconButton(icon: Icon(Icons.delete), onPressed: (){})
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProduct.productData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance.collection('products')
                  .document(cartProduct.category).collection('itens')
                  .document(cartProduct.pid).get(),
              //esse snapshot é o dado que acabamos de obter do BD
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //convertendo o documento que recebe do firebase earmazenando no producData, para que nao tenha que procurar toda vez
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
