import 'package:postgres/postgres.dart';

import 'package:firebase_auth/firebase_auth.dart';
//
// Future<void> connect() async {
//
// }


class Bd_con {

  Future<bool> authentication(String email, String password) async {
    
      try{
          
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        print("Login Bem sucedido: ${userCredential.user!.email}");
        return true;
        }
      catch (e) {
      print("Erro ao fazer login: $e");
        return false;
    
    }
  }

 
  


  Future<List<List<dynamic>>> select(String column, String table,
      String restricao, String obj) async {
    final conn = await Connection.open(
      Endpoint(
        host: '192.168.100.4',
        port: 5432,
        database: 'autopecas',
        username: 'postgres',
        password: 'admin',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
    print('Conexão estabelecida');


     final result = await conn.execute(
         Sql.named('SELECT $column FROM $table WHERE $restricao=$obj'));

     await conn.close();

     return result;
   }

   Future<void> connectToDatabase() async {
     final conn = await Connection.open(
       Endpoint(
         host: '192.168.100.4',
         // Endereço do host
         port: 5432,
         // Porta do PostgreSQL
         database: 'postgres',
         // Nome do banco de dados
         username: 'postgres',
         // Nome de usuário
         password: 'admin', // Senha
       ),
       settings: const ConnectionSettings(
         sslMode: SslMode.disable, // Ajuste se necessário
       ),
     );
     try {
       print('Conexão estabelecida com sucesso!');

       // Aqui você pode adicionar outras operações para testar a conexão

     } catch (e) {
       print('Erro ao conectar: $e');
     } finally {
       await conn.close(); // Fecha a conexão
     }
   }

   Future<List<List<dynamic>>> select_all(String column, String table) async {
     final conn = await Connection.open(
       Endpoint(
         host: '192.168.100.4',
         port: 5432,
         database: 'autopecas',
         username: 'postgres',
         password: 'admin',
       ),
       settings: const ConnectionSettings(sslMode: SslMode.disable),
     );

     print('Conexão estabelecida');

     // Executa a consulta SQL
     final result = await conn.execute(Sql.named('SELECT $column FROM $table'));

     print('Resultado da query: $result');

     await conn.close();

     // Retorna o resultado diretamente como uma lista de listas
     return result; // Cada linha é uma lista de valores
   }


   Future<bool> cadColaboradores(String table, String nome, int cpf,
       String email, int tel, String login, String pass) async {
     final conn = await Connection.open(
       Endpoint(
         host: '192.168.100.4',
         port: 5432,
         database: 'autopecas',
         username: 'postgres',
         password: 'admin',
       ),
       settings: const ConnectionSettings(sslMode: SslMode.disable),
     );

     print('Conexão estabelecida');

     // Executa a consulta SQL
     final result = await conn.execute(
         'insert into $table (nome, cpf, email, telefone, usuario, senha) values (\'$nome\', \'$cpf\', \'$email\', \'$tel\', \'$login\', \'$pass\')'
     );

     print('Resultado da query: $result');

     await conn.close();

     // Retorna o resultado diretamente como uma lista de listas

     return true;
   }

   //Def para cadastro fornecedor ou cliente


   Future<bool> cadastro(String table, String nome,) async {
     final conn = await Connection.open(
       Endpoint(
         host: '192.168.100.4',
         port: 5432,
         database: 'autopecas',
         username: 'postgres',
         password: 'admin',
       ),
       settings: const ConnectionSettings(sslMode: SslMode.disable),
     );

     print('Conexão estabelecida');

     // Executa a consulta SQL
     final result = await conn.execute(
         'insert into $table (descricao) values (\'$nome\')'
     );

     print('Resultado da query: $result');

     await conn.close();

     // Retorna o resultado diretamente como uma lista de listas

     return true;
   }


   Future<bool> cadFornecedor(String table, String nome, int cnpj, String email,
       int tel, String endereco) async {
     final conn = await Connection.open(
       Endpoint(
         host: '192.168.100.4',
         port: 5432,
         database: 'autopecas',
         username: 'postgres',
         password: 'admin',
       ),
       settings: const ConnectionSettings(sslMode: SslMode.disable),
     );

     print('Conexão estabelecida');

     // Executa a consulta SQL
     final result = await conn.execute(
         'insert into $table (nome, cnpj, email, telefone, endereco) values (\'$nome\', \'$cnpj\', \'$email\', \'$tel\', \'$endereco\')'
     );

     print('Resultado da query: $result');

     await conn.close();

     // Retorna o resultado diretamente como uma lista de listas

     return true;
   }

   Future<bool> cadastroGeral(String table, String nome, int cpf, String email,
       int tel, String endereco, String placa) async {
     final conn = await Connection.open(
       Endpoint(
         host: '192.168.100.4',
         port: 5432,
         database: 'autopecas',
         username: 'postgres',
         password: 'admin',
       ),
       settings: const ConnectionSettings(sslMode: SslMode.disable),
     );

     print('Conexão estabelecida');

     // Executa a consulta SQL
     final result = await conn.execute(
         'insert into $table (nome, cpf, email, telefone, usuario, senha) values (\'$nome\', \'$cpf\', \'$email\', \'$tel\', \'$endereco\', \'$placa\')'
     );

     print('Resultado da query: $result');

     await conn.close();

     // Retorna o resultado diretamente como uma lista de listas

     return true;
   }


   Future<bool> cadastroProduto(String table, String descricao,
       double precoCusto, double precoVenda, int estoqueAtual,
       String idFornecedor, String idCategoria) async {
     //
     final conn = await Connection.open(
       Endpoint(
         host: '192.168.100.4',
         port: 5432,
         database: 'autopecas',
         username: 'postgres',
         password: 'admin',
       ),
       settings: const ConnectionSettings(sslMode: SslMode.disable),
     );

     print('Conexão estabelecida');

     // Executa a consulta SQL
     final result = await conn.execute(
         'INSERT INTO $table (descricao, preco_custo, preco_venda, estoque_atual, id_fornecedor, id_categoria) '
             'VALUES (\'$descricao\', \'$precoCusto\', \'$precoVenda\', \'$estoqueAtual\', \'$idFornecedor\', \'$idCategoria\')'
     );

     print('Resultado da query: $result');

     await conn.close();

     // Retorna o resultado diretamente como uma lista de listas

     return true;
   }

   Future<bool> cadVendas(
       String table,
       DateTime dataVenda,
       String status,
       int idProduto,
       int idCliente,
       int formaPagamento,
       int idVendedor,
       String quantidade
       ) async {

     // Formatação manual da data (yyyy-MM-dd)
     String parsedDate = "${dataVenda.year.toString()}-${dataVenda.month.toString().padLeft(2, '0')}-${dataVenda.day.toString().padLeft(2, '0')}";

     final conn = await Connection.open(
       Endpoint(
         host: '192.168.100.4',
         port: 5432,
         database: 'autopecas',
         username: 'postgres',
         password: 'admin',
       ),
       settings: const ConnectionSettings(sslMode: SslMode.disable),
     );

     final List<List<dynamic>>  resultado = await select("preco_venda","produto", "id_produto", "$idProduto");

     String valorCusto = "0";

     for (var row in resultado) {
       valorCusto = ("${row[0]}");
     }

     double valortotal = int.parse(quantidade) * double.parse(valorCusto) ;



     // Inserir a venda
     await conn.execute(
         'INSERT INTO $table (dt_venda, valor_total, status_venda, id_cliente, id_forma_pagamento, id_vendedor) '
             'VALUES (\'$parsedDate\', $valortotal, \'$status\', $idCliente, $formaPagamento, $idVendedor)'
     );

     // Pegar o último ID inserido
     final result = await conn.execute(
         'SELECT currval(pg_get_serial_sequence(\'$table\', \'id_venda\'))'
     );

     // Extrair o valor correto da resposta de 'execute'
     var idVenda = result.first[0] as int;  // Certifique-se de que está extraindo o valor corretamente

     print('ID da venda inserida: $idVenda');

     await conn.close();

     // Agora você pode usar id_venda em itemVenda
     itemVenda(quantidade,  idProduto, idVenda);

     return true;
   }
   Future<bool> itemVenda(
       String quantidade,
       int idProduto,
       int idVenda,
       ) async {


     final List<List<dynamic>>  resultado = await select("preco_venda","produto", "id_produto", "$idProduto");

     final conn = await Connection.open(
       Endpoint(
         host: '192.168.100.4',
         port: 5432,
         database: 'autopecas',
         username: 'postgres',
         password: 'admin',
       ),
       settings: const ConnectionSettings(sslMode: SslMode.disable),
     );

     String valorCusto = "0";

     for (var row in resultado) {
       valorCusto = ("${row[0]}");
     }

     double valortotal = int.parse(quantidade) * double.parse(valorCusto) ;

     final result = await conn.execute(
         'INSERT INTO item_venda (quantidade, valor_total_item, id_produto, id_venda) '
             'VALUES (\'$quantidade\', \'$valortotal\', \'$idProduto\', \'$idVenda\')'
     );

     print('Resultado da query: $result');

     await conn.close();

     return true;
   }



   Future<String> updateItem(String table, List<String> columns, List<String> valores, int whereCondition) async {
     final conn = await Connection.open(
       Endpoint(
         host: '192.168.100.4',
         port: 5432,
         database: 'autopecas',
         username: 'postgres',
         password: 'admin',
       ),
       settings: const ConnectionSettings(sslMode: SslMode.disable),
     );

     // Verifica se a quantidade de colunas e valores é igual
     if (columns.length != valores.length) {
       throw Exception("A quantidade de colunas e valores não corresponde.");
     }

     // Constrói a parte do SQL para SET dinamicamente
     String setClause = '';
     for (int i = 0; i < columns.length; i++) {
       setClause += '${columns[i]} = \'${valores[i]}\',';
     }

     // Remove a última vírgula do setClause
     setClause = setClause.substring(0, setClause.length - 1);

     // Constrói a query final com o whereCondition
     final query = 'UPDATE $table SET $setClause WHERE id_$table = $whereCondition';

     // Executa a query diretamente
     final result = await conn.execute(query);

     await conn.close();

     // Retorna true se ao menos uma linha foi afetada
     return result.toString();
   }

   Future<String> delete(String itemId, String table) async {
     final conn = await Connection.open(
       Endpoint(
         host: '192.168.100.4',
         port: 5432,
         database: 'autopecas',
         username: 'postgres',
         password: 'admin',
       ),
       settings: const ConnectionSettings(sslMode: SslMode.disable),
     );

     print(itemId);
 //    int ID = int.parse(itemId);

     final query = 'DELETE FROM $table    WHERE id_$table = $itemId;';

     final result = await conn.execute(query);

     await conn.close();

     return result.toString();
   }


 }