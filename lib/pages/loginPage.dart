

import 'package:autopecas/def/bd_con.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';


class loginPage extends StatefulWidget {
   const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool _obscureText = true;
  Bd_con conn = Bd_con();

  final List<Map<String, String>> _users = [];


  final TextEditingController _controllerUsuario = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();



  Future<bool> userLogin(email, password) async {

    final bool produtoResponse = await conn.authentication(email, password);

    if (produtoResponse==false) {
      print("Nenhum usuário encontrado.");
      return produtoResponse;
    }
    else {
      return produtoResponse;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: 
           Material(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child:
                Text(
                  "AutoPeças",
                  style: TextStyle(
                    color: Colors.teal[200],
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 40),
                child: Container(
                  width: 300,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: SizedBox(
                        child: Icon(Icons.person, size: 200),
                      ),
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, left: 20.0, right: 20.0),
                child:
                Container(
                  width: 400,
                  height: 240,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.blue,
                      width: 1
                    )
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          controller: _controllerUsuario,
                          decoration: const InputDecoration(
                            labelText: "Email ou Usuario",
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child:
                          TextField(
                            obscureText: _obscureText,
                            controller: _controllerSenha,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              labelText: "Senha ",
                              labelStyle: const TextStyle(color: Colors.black),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText =
                                      !_obscureText; // Alterna a visibilidade
                                    });
                                  }),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0, left: 20.0, right: 20.0, bottom: 35.0),
                child: ElevatedButton(onPressed: () async {

                  bool loginSuccess = await userLogin(_controllerUsuario.text, _controllerSenha.text);
                  if (loginSuccess == true) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomePage())
                    );
                  }
                  else {
                    showCancel(context);
                  }
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                  ),
                  child: const Text(
                      "Entrar", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  )
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed:() {
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //     builder: (context) => Registerpage(),
              //     //   ),
              //     // );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.black,
              //   ),
              //   child: Text("Registre-se",
              //     style: TextStyle(
              //       color: Colors.blue,
              //       fontSize: 20,
              //     ),),
              // )
            ],
          ),
        ),
      )
    );  
  }
}


void showCancel(BuildContext context, ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Ocorreu um erro' ,
          style: TextStyle(
            color: Colors.lightBlueAccent,
          ),),
        content: const Text(
            "Por favor verifique as credenciais!"),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: ()  {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

