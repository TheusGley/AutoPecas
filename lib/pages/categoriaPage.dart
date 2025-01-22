

import 'package:flutter/material.dart';
import 'package:autopecas/def/bd_con.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class categoriaPage extends StatefulWidget {
   const categoriaPage({super.key});

  @override
  State<categoriaPage> createState() => _categoriaPageState();
}


class _categoriaPageState extends State<categoriaPage> {
   late List<String> _categorias = [' '];
   late String _selectedValue ;
   List<String> InitialValue = [' '];
   late Map<String,dynamic> _produtos  = {};
   late String responseQuery  ;

   Future<bool>? _futureData;

   @override
   void initState() {
     super.initState();
     _futureData =_getData();
   }

  Future<bool> _getData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    try{
      QuerySnapshot querySnapshot  = await firestore.collection('categoria').get(); 
     
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          print("Nome: ${doc.id}, Dados: ${doc.data()}");
          
            setState(() {
            _categorias.add(doc.id);
            });
    }

  
      // Obtém os dados do documento

    return true;
  } catch (e) {
    print("Erro ao carregar dados: $e");
    return false;
  }
}




   Future<bool> _getProdutos (String newValue) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference categoriaRef = firestore.doc('categoria/$newValue');
      try{
            QuerySnapshot querySnapshot = await firestore
        .collection('produto')
        .where('categoria', isEqualTo: categoriaRef)
        .get();
          setState(() {
                _produtos = {};
                });
    
          for (QueryDocumentSnapshot doc in querySnapshot.docs) {
              var produtoData = doc.data() as Map<String, dynamic>;

        // Cria um mapa para armazenar quantidade, preco_venda e preco_custo
        var produtoInfo = {
          'quantidade': produtoData['estoque'],
          'preco_venda': produtoData['preco_venda'],
          'preco_custo': produtoData['preco_custo'],
        };
        print(produtoInfo);         
        // Atualiza o estado com os produtos encontrados
        setState(() {
          _produtos[doc.id] = produtoInfo;
        });
      }
      return true;
    }  catch (e) {
    print("Erro ao buscar documentos filtrados: $e");
    return false; // Retorna falha em caso de erro
  } finally {
    // Atualiza o Future com sucesso ou erro
    setState(() {
      _futureData = Future.value(true);
    });
  }
}


   @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
          const Padding(padding: EdgeInsets.only(top:20, bottom: 20),
          child: Text("Categorias",style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w700,
           ),),),
            DropdownMenu<String>(
              initialSelection: InitialValue.first,
              onSelected: (String? newValue) {
                setState(() {
                  _selectedValue = newValue!;
                });
                _getProdutos(newValue!);
              },
              width: 230,
              menuHeight: 400,
              // menuStyle: MenuStyle(),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              dropdownMenuEntries: _categorias
                  .map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(
                    value: value, label: value);
              }).toList(),
            ),
            FutureBuilder<bool>(
              future: _futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Exibir indicador de carregamento enquanto a conexão é estabelecida
                  return const Padding(
                    padding: EdgeInsets.only(top: 200.0),
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  // Se houve um erro na consulta, exibir uma mensagem de erro
                  return const Text("Erro ao buscar dados");
                }

                if (_produtos.isNotEmpty) {
                  // Exibir os produtos quando a conexão for bem-sucedida
                  return Column(
                    children: [
                      for (var index = 0; index < _produtos.length; index++)
                        GestureDetector(
                          onTap: () {
                            // Código para navegação ou ações no clique
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.indigo,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Text(_produtos.keys.elementAt(index).toString(), // Nome do produto
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(_produtos.values.elementAt(index).toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                } else {
                  // Caso nenhum dado seja encontrado
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo,
                      ),
                    child: const SizedBox(
                      child: Text("Nenhum Produto encontrado"),
                    ),
                  ),
                  );
                }
              },
            )        ],
        ),
      ),
    );
  }
}


