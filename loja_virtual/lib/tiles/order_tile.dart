import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

              final colorPrimary = Theme.of(context).primaryColor;
              int status = snapshot.data['status'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Código do produto: ${snapshot.data.documentID}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _buildProductText(snapshot.data),
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _buildProductTextTotal(snapshot.data),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  Text(
                    'Status do Pedido: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle('1', 'Preparação', status, 1, colorPrimary),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildCircle('2', 'Transporte', status, 2, colorPrimary),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildCircle('3', 'Entrega', status, 3, colorPrimary)

                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductText(DocumentSnapshot snapshot) {
    String text = '\nDescrição: \n\n';

    //Navegando por cada produto, listando-os, pegando a quantidade, titulo e preço
    for (LinkedHashMap p in snapshot.data['products'])
      text +=
      '${p['quantity']} x ${p['product']['title']} (R\$ ${p['product']['price']
          .toStringAsFixed(2)})';

    return text;
  }

  String _buildProductTextTotal(DocumentSnapshot snapshot) {
    return 'Total: R\$ ${snapshot.data['totalPrice'].toStringAsFixed(2)}';
  }

  Widget _buildCircle(String title, String subtitle, int status, int thisStatus, var primaryColor){

    Color backColor;
    Widget child;

    if (status < thisStatus){
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white));
    }
    else
      if (status == thisStatus){
        backColor = primaryColor;
        child = Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Text(title, style: TextStyle(color: Colors.white)),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          ],
        );
      }
      else {
        backColor = Colors.green;
        child = Icon(Icons.check, color: Colors.white);
      }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle)
      ],
    );
  }
}
