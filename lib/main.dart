import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String _result;
  String _resultIMC;

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() {
      _result = '';
      _resultIMC = '';
    });
  }

  void calculateImc() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100.0;
    double imc = weight / (height * height);

    setState(() {
      _result = "IMC: ${imc.toStringAsPrecision(2)}\n";
      if (imc < 16.0)
        _resultIMC = "Magreza grave";
      else if (imc > 16.0 && imc < 17.0)
        _resultIMC = "Magreza moderada";
      else if (imc > 17.0 && imc < 18.5)
        _resultIMC = "Magreza leve";
      else if (imc > 18.5 && imc < 25.0)
        _resultIMC = "Saudável";
      else if (imc > 25.0 && imc < 30.0)
        _resultIMC = "Sobrepeso";
      else if (imc > 30.0 && imc < 35.0)
        _resultIMC = "Obesidade Grau I";
      else if (imc > 35.0 && imc < 40.0)
        _resultIMC = "Obesidade Grau II (severa)";
      else if (imc > 40.0)
        _resultIMC = "Obesidade Grau III (mórbida)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange, 
        cursorColor: Colors.orange,
                primarySwatch: Colors.orange,
        accentColor: Colors.orange,
        accentIconTheme: Theme.of(context).accentIconTheme.copyWith(
          color: Colors.white
        ),
        primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
          color: Colors.white
        )
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm())));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('IMC', style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.black87,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetFields();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Peso (kg)",
              error: "Insira seu peso!",
              controller: _weightController),
          buildTextFormField(
              label: "Altura (cm)",
              error: "Insira uma altura!",
              controller: _heightController),
          buildCalculateButton(),
          buildTextResultBold(),
          buildTextResult()
        ],
      ),
    );
  }

  Padding buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calculateImc();
          }
        },
        child: Text('CALCULAR', style: TextStyle(fontSize: 14, color: Colors.black87)
        ),
      ),
    );
  }

  Padding buildTextResult() {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Text(
        _result,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
    );
  }

  Padding buildTextResultBold() {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Text(
        _resultIMC,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
      ),
    );
  }

  Padding buildTextFormField(
    {TextEditingController controller, String error, String label}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelStyle: TextStyle(color: Colors.black87),
          labelText: label
        ),
        controller: controller,
        validator: (text) {
          return text.isEmpty ? error : null;
        },
      )
    );
  }
}