import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();
  String resultado = "Informe";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Limpar os campos
  void _resetarCampos() {
    peso.text = "";
    altura.text = "";
    //Só é necessário o setState aqui porque ja foi informado
    //Para os campos que peso e altura são seus controladores
    //Então sempre vai receber esses valores
    setState(() {
      resultado = "Informe";
    });
  }

  //Calcular
  void _calcular() {
    setState(() {
      double altu = double.parse(altura.text) / 100;
      double pes = double.parse(peso.text);
      double imc = pes / (altu * altu);

      //Validação da conta do IMC
      if (imc < 18.6) {
        resultado = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        resultado = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        resultado = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        resultado = "Obesidade Grau 1 (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        resultado = "Obesidade Grau 2 (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40.0) {
        resultado = "Obesidade Grau 3 (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetarCampos,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.red,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso em (KG)",
                      labelStyle: TextStyle(color: Colors.red, fontSize: 20.0)),
                  textAlign: TextAlign.center,
                  controller: peso,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Preencha seu Peso";
                    }
                  },
                  style: TextStyle(fontSize: 15),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura em (cm)",
                      labelStyle: TextStyle(color: Colors.red, fontSize: 20.0)),
                  textAlign: TextAlign.center,
                  //Atribui uma varíavel
                  controller: altura,
                  //Chama a validação do form, para verificar se contém algo
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Preencha a altura";
                    }
                  },
                  style: TextStyle(fontSize: 15),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        //Verifica se os campos estão válidos para continuar
                        if (_formKey.currentState.validate()) {
                          _calcular();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(fontSize: 20),
                      ),
                      color: Colors.red,
                      textColor: Colors.white,
                    ),
                  ),
                ),
                Text(
                  resultado,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.red),
                )
              ],
            ),
          ),
        ));
  }
}
