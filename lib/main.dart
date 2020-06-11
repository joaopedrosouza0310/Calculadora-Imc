import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: HomeImc()));
}

class HomeImc extends StatefulWidget {
  @override
  _HomeImcState createState() => _HomeImcState();
}

class _HomeImcState extends State<HomeImc> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _info = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    setState(() {
      pesoController.text = "";
      alturaController.text = "";
      _info = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularImc() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;

      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _info = "Abaixo do peso: ${imc.toStringAsPrecision(3)}";

        //TODO: adicionar o restante
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    color: Colors.green,
                    size: 120,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira seu peso!";
                        }
                      },
                      style: TextStyle(color: Colors.green, fontSize: 25),
                      controller: pesoController,
                      decoration: InputDecoration(
                          labelText: "Peso (KG)",
                          labelStyle: TextStyle(color: Colors.green))),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      controller: alturaController,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua altura!";
                        }
                      },
                      style: TextStyle(color: Colors.green, fontSize: 25),
                      decoration: InputDecoration(
                          labelText: "Altura (CM)",
                          labelStyle: TextStyle(color: Colors.green))),
                  //Para definir a altura
                  Padding(
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calcularImc();
                          }
                        },
                        color: Colors.green,
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                  ),
                  Text(
                    _info,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  )
                ],
              ),
            )));
  }
}
