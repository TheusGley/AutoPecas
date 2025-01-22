import 'package:autopecas/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'update.dart';
import '../def/bd_con.dart';

class DeletePage extends StatefulWidget {
  const DeletePage( {super.key});

  @override
  State<DeletePage> createState() => _deleteItem();
}

class _deleteItem extends State<DeletePage> {
  late final List<String> _tabelas = ['produto', 'fornecedor', 'cliente', 'vendedor'];
  late List<String> _itens = [' '];
  List<String> InitialValue = [' '];

  late String _selectedValue;
  late Map<String, dynamic> _produtos = {};
  Future<bool>? _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _getData();
  }

  Future<bool> _getData() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulando uma demora
    return true;
  }

  Future<bool> _getProdutos(String newValue) async {
    Bd_con connect = Bd_con();
    _produtos = {}; // Limpa os produtos anteriores

    final List<List<dynamic>> ItemResponse = await connect.select_all('*', newValue);

    if (ItemResponse.isEmpty) {
      print("Nenhuma categoria encontrada.");
      return false;
    }

    List<String> formattedResponse = [];
    for (var row in ItemResponse) {
      formattedResponse.add("${row[0]} - ${row[1]}");
    }

    print("Resposta formatada: $formattedResponse");

    setState(() {
      _itens = formattedResponse; // Atualiza os itens da tabela selecionada
    });

    return true;
  }

  Future<bool> _delete(String tabela, String itemId) async{
    Bd_con conn = Bd_con();
  try{
    await conn.delete(tabela, itemId);
    return true;

  }
  catch (e) {
    print(e.toString());

    return false;

    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                "Escolha a Tabela",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            DropdownMenu<String>(
              initialSelection: InitialValue.first,
              onSelected: (String? newValue) {
                setState(() {
                  _selectedValue = newValue!;
                  _futureData = _getProdutos(newValue);
                });
              },
              width: 230,
              menuHeight: 400,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              dropdownMenuEntries: _tabelas
                  .map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            FutureBuilder<bool>(
              future: _futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 200.0),
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Text("Erro ao buscar dados");
                }
                if (_itens.isNotEmpty) {
                  return Column(

                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          "Escolha o item que deseja deletar",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      for (var index = 0; index < _itens.length; index++)
                        GestureDetector(
                          onTap: () async {
                            List<String> parts = _itens[index].split('-').map((e) => e.trim()).toList();
                            String idItem = parts[0];
                            String tabela = _selectedValue;
                            bool result = await _delete(idItem, tabela);
                            if (result){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage() // Substitua com o widget da nova página
                                ),
                              );
                            }else{
                              showCancel(context,"Algo falhou");

                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.indigo,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _itens[index],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.indigo,
                      ),
                      child: const Text("Nenhum Produto encontrado"),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

