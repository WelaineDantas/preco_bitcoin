import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _preco = "0";

  Future<Map> _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("image/bitcoin.png"),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Center(
                child: FutureBuilder<Map>(
                  future: _recuperarPreco(),
                  builder: (context, snapshot) {
                    String resultado;

                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                        break;
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          resultado = "Erro ao carregar dados." +
                              snapshot.error.toString();
                        } else {
                          double valor = snapshot.data["BRL"]["buy"];
                          resultado = "R\$ ${valor.toString()}";
                        }

                        break;
                    }

                    return Text(
                      resultado,
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.grey[700],
                      ),
                    );
                  },
                ),
              ),
            ),
            RaisedButton(
              padding:
                  EdgeInsets.only(right: 30, left: 30, top: 15, bottom: 15),
              textColor: Colors.white,
              child: Text(
                "Atualizar",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                setState(() {
                  _recuperarPreco();
                });
              },
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
