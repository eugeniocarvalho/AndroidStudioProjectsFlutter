import 'dart:io';

import 'package:agendacontatos/helpers/contact_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact}); //parametro opcional

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editingContact;
  bool _contactEdited = false;
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.contact == null)
      _editingContact = Contact();
    else {
      _editingContact = Contact.fromMap(widget.contact.toMap());

      //quando iniciar a tela, ele ja setar os dados do contato caso ja tenha, caso nao, ficam vazios
      _nomeController.text = _editingContact.name;
      _emailController.text = _editingContact.email;
      _phoneController.text = _editingContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(_editingContact.name ?? "Novo Contato"),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_editingContact.name != null &&
                  _editingContact.name.isNotEmpty) if (_editingContact.phone !=
                      null &&
                  _editingContact.phone.isNotEmpty) {
                Navigator.pop(context, _editingContact);
              } else
                FocusScope.of(context).requestFocus(_phoneFocus);
              else
                FocusScope.of(context).requestFocus(_nameFocus);
            },
            child: Icon(Icons.save),
            backgroundColor: Colors.red,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _editingContact.img != null
                              ? FileImage(File(_editingContact.img))
                              : AssetImage("images/person.png")),
                    ),
                  ),
                ),
                TextField(
                  controller: _nomeController,
                  focusNode: _nameFocus,
                  decoration: InputDecoration(
                    labelText: "Nome",
                  ),
                  onChanged: (text) {
                    _contactEdited = true;
                    setState(() {
                      _editingContact.name = text;

                      if (text.isEmpty) _editingContact.name = "Novo Contato";
                    });
                  },
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    helperText: "email@email.com",
                  ),
                  onChanged: (text) {
                    _contactEdited = true;
                    _editingContact.email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _phoneController,
                  focusNode: _phoneFocus,
                  decoration: InputDecoration(
                      labelText: "Telefone", helperText: "(XX) X XXXX-XXXX"),
                  onChanged: (text) {
                    _contactEdited = true;
                    _editingContact.phone = text;
                  },
                  keyboardType: TextInputType.phone,
                )
              ],
            ),
          ),
        ));
  }

  Future<bool> _requestPop() {
    if (_contactEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Sair sem salvar"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                FlatButton(
                  child: Text("Sair e Salvar"),
                  onPressed: () {
                    _editingContact.name = _nomeController.text;
                    _editingContact.email = _emailController.text;
                    _editingContact.phone = _phoneController.text;
                    Navigator.pop(context);
                    Navigator.pop(context, _editingContact);
                  },
                )
              ],
            );
          });
      return Future.value(false);
    } else
      return Future.value(true);
  }
}
