import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../def/bd_con.dart';
import 'homePage.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {

  final TextEditingController _controllerNome = TextEditingController();

  final TextEditingController _controllerCpf= TextEditingController();

  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerTelefone= TextEditingController();

  final TextEditingController _controllerEndereco= TextEditingController();

  final TextEditingController _controllerPlaca= TextEditingController();





  final GlobalKey<FormState> _formKey  = GlobalKey<FormState>();

  Future<void> _cadCliente (String nome, String cpf , String email, String tel , String endereco, String placa) async {

    int cpfFormat = int.parse(cpf);
    int telFormat = int.parse(tel);

    Bd_con conn = Bd_con();
    conn.cadastroGeral("cliente", nome, cpfFormat, email,  telFormat, endereco,placa);
  }





  String? _errorText ;
  String?  _errorName ;

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.indigo,
                        width: 3,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      child: const Text(
                        "Cadastre o Cliente",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 3,
                    ),
                  ),
                  child:
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),

                    ],
                    keyboardType: TextInputType.name,
                    controller: _controllerNome,
                    decoration: const InputDecoration(
                      labelText: " Nome ",
                      labelStyle: TextStyle(color: Colors.black),
                      border: null,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 3,
                    ),
                  ),
                  child: TextFormField(
                    onChanged: (value){
                      if (value.length >= 11)
                      {
                        setState(() {
                          _errorName = "Coloque apenas 11 caracteres " ;

                        });

                      }
                      else {
                        if (_errorName != null) {
                          setState(() {
                            _errorName = null;
                          });
                        }
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    ],
                    controller: _controllerCpf,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: _errorName,
                      labelText: " CPF ",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: null,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 3,
                    ),
                  ),
                  child:
                  TextFormField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorText: _errorName,
                      labelText: " Email",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: null,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 3,
                    ),
                  ),
                  child: TextFormField(
                    controller: _controllerTelefone,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: " Telefone",
                      labelStyle: TextStyle(color: Colors.black),
                      border: null,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 3,
                    ),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _controllerPlaca,
                    decoration: InputDecoration(
                      errorText: _errorText,
                      labelText: "Placa",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: null,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 3,
                    ),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _controllerEndereco,
                    decoration: InputDecoration(
                      errorText: _errorText,
                      labelText: "Endereço",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: null,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.indigo,
                    fixedSize: const Size(200, 50),
                  ),
                  onPressed: () {

                      try {
                        _cadCliente(
                            _controllerNome.text,
                            _controllerCpf.text.toString(),
                            _controllerEmail.text,
                            _controllerTelefone.text,
                            _controllerEndereco.text,
                            _controllerPlaca.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const HomePage(), // Substitua com o widget da nova página
                          ),
                        );
                      }
                      catch (e) {
                        showCancel(context, e);

                      }
                    },
                  child: const Text("Enviar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      )),
                ),
              ),
            ]),
          ),
        ),
      );
  }
}
void showCancel(BuildContext context, Object e ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Ocorreu um erro$e',
          style: const TextStyle(
            color: Colors.lightBlueAccent,
          ),),
        content: const Text(
            "Por favor tente novamente mais tarde "),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: ()  {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}


