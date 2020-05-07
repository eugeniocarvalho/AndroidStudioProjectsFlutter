import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/home_tab.dart';
import 'package:lojavirtual/tabs/products_tab.dart';
import 'package:lojavirtual/widgets/cart_buttom.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButtom(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButtom(),
          body: ProductsTab(),
        ),
        Container(color: Colors.red),
        Container(color: Colors.blue,)
      ],
    );
  }
}
