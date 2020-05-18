import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PlaceTile extends StatelessWidget {

  //recebendo os dados do locais fisicos
  DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 150,
            child: Image.network(
              snapshot.data['image'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  snapshot.data['title'],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(snapshot.data['address'],
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('Ver no Mapa'),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
                onPressed: (){}
              ),
              FlatButton(
                child: Text('Ligar'),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
                onPressed: (){},
              )
            ],
          )
        ],
      ),
    );
  }
}
