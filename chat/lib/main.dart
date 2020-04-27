import 'package:chat/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {

  runApp(MyApp());

  /*QuerySnapshot snapshot = await Firestore.instance.collection('mensagens').getDocuments();
  snapshot.documents.forEach((d) {
    print(d.data);
  });

   */
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.blueAccent
        )
      ),
      home: ChatScreen(),
    );
  }
}