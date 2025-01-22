import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../def/bd_con.dart';
import 'homePage.dart';

class Update extends StatefulWidget {
  final String IdItem;
  final String tabela;

  const Update({
    super.key,
    required this.IdItem,
    required this.tabela,
  });

  @override
  State<Update> createState() => UpdateState();
}

class UpdateState extends State<Update> {
  late int qtdCampo = 0;
  Bd_con connect = Bd_con();
  List<TextEditingController> _controllers = [];
  List<List<dynamic>> responseQuery = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> colunas = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    String table = widget.tabela;

    List<String> columns = [];
    String idColumn = "";

    if (table == "produto") {
      columns = ["descricao", "preco_custo", "preco_custo", "estoque_atual"];
      idColumn = "id_produto";
    } else if (table == "cliente") {
      columns = ["nome", "cpf_cnpj", "email", "telefone", "endereco", "placa"];
      idColumn = "id_cliente";
    } else if (table == "fornecedor") {
      columns = ["nome", "cnpj", "email", "telefone", "endereco"];
      idColumn = "id_fornecedor";
    } else if (table == "vendedor") {
      columns = ["nome", "cpf", "email", "telefone"];
      idColumn = "id_vendedor";
    } else {
      // Handle unknown table case
      return;
    }

    final List<List<dynamic>> response = await connect.select(
        columns.join(", "), table, idColumn, widget.IdItem);

    setState(() {
      qtdCampo = columns.length;
      _controllers = List.generate(qtdCampo, (i) => TextEditingController());
      responseQuery = response;
      colunas = columns;


      if (response.isNotEmpty) {
        for (int i = 0; i < qtdCampo; i++) {
          _controllers[i].text = response[0][i].toString();
        }
      }
    });
  }

  Future<String> update() async {
    String table = widget.tabela;

    List<String> columns;
    List<String> values = _controllers.map((controller) => controller.text).toList();

    if (table == "produto") {
      columns = ['descricao', 'preco_custo', 'estoque_atual'];
    } else if (table == "cliente") {
      columns = ['nome', 'cpf_cnpj', 'email', 'telefone', 'endereco', 'placa'];
    } else if (table == "fornecedor") {
      columns = ['nome', 'cpf_cnpj', 'email', 'telefone', 'endereco'];
    } else if (table == "vendedor") {
      columns = ['nome', 'cpf', 'email', 'telefone'];
    } else {
      return "false";
    }

    final String response = await connect.updateItem(
        table, columns, values, int.parse(widget.IdItem));

    return "true";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
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
                      child: Text(
                        "Atualize o ${widget.tabela}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              for (int i = 0; i < qtdCampo; i++)
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
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                      ],
                      keyboardType: TextInputType.name,
                      controller: _controllers[i],
                      decoration: InputDecoration(
                        labelText : colunas[i].toString(),
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
                    backgroundColor: Colors.indigo,
                    fixedSize: const Size(200, 50),
                  ),
                  onPressed: () {
                    try {
                      update().then((success) {
                        if (success == "true") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        } else {
                          // Handle unsuccessful update
                          showCancel(context, "Atualização falhou");
                        }
                      });
                    } catch (e) {
                      showCancel(context, e.toString());
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    fixedSize: const Size(200, 50),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showCancel(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Ocorreu um erro: $message',
          style: const TextStyle(
            color: Colors.lightBlueAccent,
          ),
        ),
        content: const Text(
          "Por favor tente novamente mais tarde.",
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
