import 'package:flutter/material.dart';

import '../def/bd_con.dart';
import 'homePage.dart';

class VendasPage extends StatefulWidget {
  const VendasPage({super.key});

  @override
  State<VendasPage> createState() => _VendasPageState();
}

GlobalKey<FormState> _formKey  = GlobalKey<FormState>();


TextEditingController _controllerValorTotal = TextEditingController();
TextEditingController _dateController = TextEditingController();
TextEditingController _controllerQuatidade = TextEditingController();




List<String> _cliente = [' '];
List<String> _formaPagamento = [' '];
List<String> _vendedor= [' '];
List<String> _produto= [' '];
List<String> valorCusto = [''];
List<String> _status= ['Pago ', 'Andamento', 'Perdida'];
DateTime? _selectedDate = DateTime.now();
String _selectedCliente = _cliente.first;
String _selectedFormaPag = _formaPagamento.first;
String _selectedVendedor  = _vendedor.first;
String _selectedstatus = _status.first;
String _selectedproduto = _produto.first;
String select_valor = _produto.first;


String quantidade = "";


String Valor_total = '0';
List<String> InitialValue = [' '];




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
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

class _VendasPageState extends State<VendasPage> {

  @override
  void initState() {
    _getData();
  }


  Future<void> _cadVendas( DateTime data, String status, String produto, String cliente,String pagamento, String vendedor) async {

    List<String> partsProduto = produto.split('-').map((e) => e.trim()).toList();
    String produtoID = partsProduto[0];

    List<String> parts = cliente.split('-').map((e) => e.trim()).toList();
    String clienteID = parts[0];

    List<String> parts2 = pagamento.split('-').map((e) => e.trim()).toList();
    String pagamentoID = parts2[0];

    List<String> parts3 = vendedor.split('-').map((e) => e.trim()).toList();
    String vendedorID = parts3[0];

    Bd_con conn = Bd_con();
    conn.cadVendas(
        "venda",
        data,
        status,
        int.parse(produtoID),
        int.parse(clienteID),
        int.parse(pagamentoID),
        int.parse(vendedorID),
        _controllerQuatidade.text
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),  // Define a data mínima
      lastDate: DateTime(2100),   // Define a data máxima
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = "${pickedDate.year.toString().padLeft(4, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<bool> _getData() async {
    Bd_con connect = Bd_con();

    final List<List<dynamic>> responseProduto = await connect.select_all('*', 'produto');
    final List<List<dynamic>> responseCliente = await connect.select_all('*', 'cliente');
    final List<List<dynamic>> responseFormaPag = await connect.select_all('*', 'forma_pagamento');
    final List<List<dynamic>> responseVendedor = await connect.select_all('*', 'vendedor');

    List<String> formattedProduto = [];
    List<String> formattedCliente = [];
    List<String> formattedFormaPag = [];
    List<String> formattedVendedor = [];
    List<String> valorCusto1 = [];

    for (var row in responseProduto) {
      formattedProduto.add("${row[0]} - ${row[1]} -  ${row[3]}");
    }
    for (var row in responseCliente) {
      formattedCliente.add("${row[0]} - ${row[1]}");
    }
    for (var row in responseFormaPag) {
      formattedFormaPag.add("${row[0]} - ${row[1]}");
    }
    for (var row in responseVendedor) {
      formattedVendedor.add("${row[0]} - ${row[1]}");
    }

    print("Resposta formatada: $formattedProduto");
    print("Resposta formatada: $formattedCliente");
    print("Resposta formatada: $formattedFormaPag");
    print("Resposta formatada: $formattedVendedor");


    setState(() {
      _cliente = formattedCliente;
      _formaPagamento = formattedFormaPag;
      _vendedor = formattedVendedor;
      _produto = formattedProduto;
      valorCusto = valorCusto1;

    });

    if (formattedCliente.isNotEmpty && formattedFormaPag.isNotEmpty) {
      print("Dados recebidos com sucesso!");
      return true;
    } else {
      print("Nenhum dado encontrado.");
      return false;
    }
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      child: const Text(
                        "Faça uma venda",
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
                  DropdownMenu<String>(
                    initialSelection: InitialValue.first,
                    onSelected: (String? newValue) {

                      setState(() {
                        _selectedproduto = newValue!;
                        select_valor = newValue;
                      });
                    },
                    width: 280,
                    menuHeight: 400,
                    // menuStyle: MenuStyle(),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    dropdownMenuEntries: _produto
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
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
                keyboardType: TextInputType.number,
                onChanged: (value){
                  setState(() {
                    quantidade = value;
                  });

                },
                controller: _controllerQuatidade,
                decoration: const InputDecoration(
                  labelText: "Quantidade ",
                  labelStyle: TextStyle(color: Colors.black),
                  border: null,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
                ),),
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
                    controller: _dateController,
                    decoration: const InputDecoration(
                      iconColor: Colors.black,
                      icon: Icon(Icons.calendar_today),
                      labelText: "Selecione a data",
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),  // Mostra o seletor de data
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
                  child:
                  DropdownMenu<String>(
                    initialSelection: InitialValue.first,
                    onSelected: (String? newValue) {
                      // This is called when the user selects an item.
                      setState(() {
                        _selectedstatus = newValue!;
                      });
                    },
                    width: 280,
                    menuHeight: 400,
                    // menuStyle: MenuStyle(),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    dropdownMenuEntries: _status
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
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
                  DropdownMenu<String>(
                    initialSelection: InitialValue.first,
                    onSelected: (String? newValue) {
                      // This is called when the user selects an item.
                      setState(() {
                        _selectedstatus = newValue!;
                      });
                    },
                    width: 280,
                    menuHeight: 400,
                    // menuStyle: MenuStyle(),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    dropdownMenuEntries: _cliente
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
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
                  DropdownMenu<String>(
                    initialSelection: InitialValue.first,
                    onSelected: (String? newValue) {
                      // This is called when the user selects an item.
                      setState(() {
                        _selectedstatus = newValue!;
                      });
                    },
                    width: 280,
                    menuHeight: 400,
                    // menuStyle: MenuStyle(),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    dropdownMenuEntries: _formaPagamento
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
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
                  DropdownMenu<String>(
                    initialSelection: InitialValue.first,
                    onSelected: (String? newValue) {
                      // This is called when the user selects an item.
                      setState(() {
                        _selectedVendedor = newValue!;
                      });
                    },
                    width: 280,
                    menuHeight: 400,
                    // menuStyle: MenuStyle(),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    dropdownMenuEntries: _vendedor
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
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
                      _cadVendas(
                          _selectedDate!,
                          _selectedstatus,
                          _selectedproduto,
                          _selectedCliente,
                          _selectedFormaPag,
                          _selectedVendedor
                          );
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
