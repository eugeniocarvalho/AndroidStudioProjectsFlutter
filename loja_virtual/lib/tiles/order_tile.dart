import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class OrderTile extends StatelessWidget {
  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('orders')
                .document(orderId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Código do produto: ${snapshot.data.documentID}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _buildProductText(snapshot.data),
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(_buildProductTextTotal(snapshot.data),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                  ],
                );
              }
            }
            ),
      ),
    );
  }

  String _buildProductText(DocumentSnapshot snapshot){
    String text = '\nDescrição: \n\n';

    //Navegando por cada produto, listando-os, pegando a quantidade, titulo e preço
    for (LinkedHashMap p in snapshot.data['products'])
      text += '${p['quantity']} x ${p['product']['title']} (R\$ ${p['product']['price'].toStringAsFixed(2)})\n';

    return text;
  }

  String _buildProductTextTotal(DocumentSnapshot snapshot){
    return 'Total: R\$ ${snapshot.data['totalPrice'].toStringAsFixed(2)}\n';
  }
}
