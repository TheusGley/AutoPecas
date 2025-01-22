
import 'package:flutter/material.dart';

import '../tiles/drawertiles.dart';

class CustomDrawer extends StatefulWidget {

     final PageController pageController ;

    const CustomDrawer(this.pageController, {super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

/*
    void _logout () async {

      TokenManager token = TokenManager();
      await token.clearTokens();

      setState(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false,
        );
      });
    }*/

@override
  Widget build(BuildContext context) {
    Widget buildDrawer() => Container(
          width: 400,
          decoration: const BoxDecoration(color: Colors.indigo),
        );
    return Drawer(
      child: Stack(
        children: [
          buildDrawer(),
          ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(left:10, bottom: 10),
                height: 170,
                child: Stack(
                  children: [
                    const Positioned(
                        top: 20.0,
                        left: 0.0,
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: Column(children: [
                          GestureDetector(
                            onTap: (){
                              /*
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Userpage(),
                                ),
                              );*/
                            },
                            child: Container(
                                width: 250,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 3,
                                  ),
                                ),
                              child:
                              Row(
                                  children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.indigo,
                                          width: 3
                                        )
                                      ),
                                      child:
                                  const Icon(Icons.person,size: 40,)
                                  ),
                                ),
                               /* Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text("Matheus Gley",style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),),
                                )*/
                              ]),
                            ),

                          ),
                        ])
                    ),

                  ],
                ),
              ),
              const Divider(color: Colors.indigo,),
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child:
                      Column(
                      children : [
                      DrawerTiles(Icons.home, "Home", widget.pageController,0),
                      DrawerTiles(Icons.person, "Colaboradores",widget.pageController,1),
                      DrawerTiles(Icons.accessibility, "Clientes",widget.pageController,2),
                      DrawerTiles(Icons.production_quantity_limits, "Produtos",widget.pageController,3),
                      DrawerTiles(Icons.add_box, "Fornecedor",widget.pageController,4),
                      DrawerTiles(Icons.account_balance_wallet, "Vendas",widget.pageController,5),
                      DrawerTiles(Icons.list_alt_rounded, "Categorias",widget.pageController,6),
                      DrawerTiles(Icons.update, "Atualizar",widget.pageController,8),
                        DrawerTiles(Icons.delete, "Delete",widget.pageController,9),
                        const SizedBox(height: 150,),
                       /* ElevatedButton(
                            onPressed: (){_logout();},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: MyColors.corBack,
                              padding: EdgeInsets.symmetric(vertical: 10,),

                            ),
                            child: Text("Logout",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                              ),)),*/
                        const SizedBox(height: 40,),

                        ]
                  )
                               ),
                 /* ElevatedButton(
                    onPressed: (){},
                    child:Text("Todos os Direitos Reservados © GleyDevelopment",
                      textAlign: TextAlign.center,),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 5,),
                      backgroundColor: MyColors.corFundo,
                    ),), */
                ],
              )


            ],
          )
        ],
      ),
    );
  }
}
