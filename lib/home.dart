import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_firebase/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _nome = "carregando ...";
  String _email = "carregando ...";
  String _cpf = "carregando ...";

  _logout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
    setState(() {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: ((context) => const Login())), (route) => false);
    });
  }

  _userDataLoading() {
    User? usuarioLogado = FirebaseAuth.instance.currentUser;
    FirebaseDatabase db = FirebaseDatabase.instance;

    db.ref("usuarios").child(usuarioLogado!.uid).onValue.listen((event) {
      var snapshot = event.snapshot;
      String _nomeR = (snapshot.value as dynamic)['nome'];
      String _emailR = (snapshot.value as dynamic)['email'];
      String _cpfR = (snapshot.value as dynamic)['cpf'];

      setState(() {
        if(_nomeR != null) {
          if(_emailR != null){
            if(_cpfR != null){
              _nome = "$_nomeR";
              _email = "$_emailR";
              _cpf = "$_cpfR";
            }
          }
        }
      });

    });

  }

  String _getDate() {
    var now = new DateTime.now();
    var dateFormat = new DateFormat('yyyy-MM-dd hh:mm:ss');
    String dataFormatada = dateFormat.format(now);
    return dataFormatada;
  }


  _criarPost() {
    User? usuarioLogado = FirebaseAuth.instance.currentUser;
    FirebaseDatabase db = FirebaseDatabase.instance;
    String dataFormatada = _getDate();

    Map<String, dynamic> post = {
      'nome': _nome,
      'horario': dataFormatada,
      'conteudo': "Vai brasiliam #vemCopa #Hexa"
    };
    db.ref("usuarios").child(usuarioLogado!.uid).child("posts").child(dataFormatada).set(post);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _logout();
    _userDataLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase App"),
        actions: [
          TextButton(
            onPressed: () {
              _logout();
            },
            child: const Text("Sair  ",
                style: TextStyle(color: Colors.red, fontSize: 20)),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //NOME
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    _nome,
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                //EMAIL
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    _email,
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                //CPF
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    _cpf,
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _criarPost();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black54,
                      elevation: 0,
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Text(
                      "Criar novo Post",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20, bottom: 20),
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => const List()));
                //     },
                //     style: ElevatedButton.styleFrom(
                //       primary: Colors.black54,
                //       elevation: 0,
                //       padding: const EdgeInsets.all(12),
                //     ),
                //     child: const Text(
                //       "List View",
                //       style: TextStyle(
                //         fontSize: 18,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}