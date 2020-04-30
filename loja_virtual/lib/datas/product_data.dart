import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String category, id, title, description;
  double price;
  List sizes, images;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    this.id = snapshot.documentID;
    this.title = snapshot.data['title'];
    this.description = snapshot.data['description'];
    this.price = snapshot.data['price'] + 0.0;
    this.sizes = snapshot.data['sizes'];
    this.images = snapshot.data['images'];
  }

}
