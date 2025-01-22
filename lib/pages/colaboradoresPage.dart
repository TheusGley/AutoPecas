// import 'dart:ffi';

import 'package:autopecas/def/bd_con.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homePage.dart';

class ColaboradoresPage extends StatefulWidget {
   const ColaboradoresPage({super.key});

  @override
  State<ColaboradoresPage> createState() => _ColaboradoresPageState();
}

class _ColaboradoresPageState extends State<ColaboradoresPage> {
   final TextEditingController _controllerNome = TextEditingController();

   final TextEditingController _controllerCpf  = TextEditingController();

   final TextEditingController _controllerEmail = TextEditingController();

   final TextEditingController _controllerTelefone = TextEditingController();

   final TextEditingController _controllerLogin = TextEditingController();

   final TextEditingController _controllerSenha = TextEditingController();

   final TextEditingController _controllerConfirm = TextEditingController();

   final TextEditingController _controllerUsuario = TextEditingController();


   final GlobalKey<FormState> _formKey  = GlobalKey<FormState>();

   bool _obscureText = true;

   String? _errorText ;
   String?  _errorName ;

   Future<void> _insert (String table , String nome , String cpf,String email, String tel,String login , String pass) async {

     int cpfFormat = int.parse(cpf);
     int telFormat = int.parse(tel);

     Bd_con conn = Bd_con();
     conn.cadColaboradores(table, nome, cpfFormat, email, telFormat, login, pass);
   }

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
                        "Cadastre o Colaborador",
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
                      labelText: " Cpf ",
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
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: " Email",
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
                    controller: _controllerUsuario,
                    decoration: const InputDecoration(
                      labelText: " Usuario ",
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
                    keyboardType: TextInputType.visiblePassword,
                    controller: _controllerSenha,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      errorText: _errorText,
                      labelText: " Senha",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: null,
                        suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            }),
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
                    obscureText: _obscureText,
                    controller: _controllerConfirm,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      errorText: _errorText,
                      labelText: " Confirme a Senha",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: null,
                      suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          }),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.indigo,
                  ),
                  onPressed: () {
                    if (_controllerSenha.text == _controllerConfirm.text) {
                      try {
                        _insert(
                            "vendedor",
                            _controllerNome.text,
                            _controllerCpf.text.toString(),
                            _controllerEmail.text,
                            _controllerTelefone.text,
                            _controllerUsuario.text,
                            _controllerSenha.text);
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
                    }
                    else{
                      setState(() {
                        _errorText = "As senhas não conferem" ;
                      });
                    }
                  } ,
                  child: const Text("Cadastrar",
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

