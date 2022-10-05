import 'package:flutter/material.dart';

class ListaView extends StatefulWidget {
  const ListaView({Key? key}) : super(key: key);

  @override
  State<ListaView> createState() => _ListaViewState();
}

class _ListaViewState extends State<ListaView> {
  @override
  Widget build(BuildContext context) {
    //pegando o tamanho da tela e armazenando em uma variavel
    var largura = MediaQuery.of(context).size.width;
    var altura = MediaQuery.of(context).size.height;
    //pegando o tamanho da AppBar
    var alturaAppbar = AppBar().preferredSize.height;
    // subtraindo para termos a area útil
    var alturaCorpo = altura - alturaAppbar;


    var corpo = Container(
      width: largura,
      height: alturaCorpo,
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              print("AQUI");
            },
          title: const Text("Bem vindo!"),
          subtitle: const Text("Olá <nome usuário>"),  
          ),
          ListTile(
          title: const Text("Bem vindo!"),
          subtitle: const Text("Olá <nome usuário>"),  
          ),
          ListTile(
          title: const Text("Bem vindo!"),
          subtitle: const Text("Olá <nome usuário>"),  
          ),
          ListTile(
          title: const Text("Bem vindo!"),
          subtitle: const Text("Olá <nome usuário>"),  
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        //montando list view, interface na variavel corpo;
        child: Column(children: [corpo],)
      ),
    );
  }
}