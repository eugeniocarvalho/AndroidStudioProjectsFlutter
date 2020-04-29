import 'package:flutter/material.dart';
import 'package:lojavirtual/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 20, 20, 20),
            Color.fromARGB(100, 150, 150, 150)
          ], begin: Alignment.topCenter, end: Alignment.bottomLeft)),
        );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 0, 15, 8),
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Text("Flutter's\nClothing",
                        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Olá,',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          GestureDetector(
                            child: Text('Entre ou cadastre-se >',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            onTap: (){

                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, 'Inicio'),
              DrawerTile(Icons.list, 'Produtos'),
              DrawerTile(Icons.location_on, 'Lojas'),
              DrawerTile(Icons.playlist_add_check, 'Meus Pedidos')
            ],
          )
        ],
      ),
    );
  }
}
