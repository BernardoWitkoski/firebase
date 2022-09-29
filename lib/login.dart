import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_firebase/criarConta.dart';
import 'package:projeto_firebase/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  _login() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if(email.isNotEmpty && email.contains("@")){
      if(senha.isNotEmpty && senha.length >= 6);
        FirebaseAuth auth = FirebaseAuth.instance;
        auth.signInWithEmailAndPassword(email: email, password: senha).then((value) => {
          setState((){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: ((context) => const Home())), (route) => false);
          }),
        });
    }

  }

  _verificarUsuarioLogado() {
    User? usuarioLogado = FirebaseAuth.instance.currentUser;
    if(usuarioLogado != null) {
      setState(() {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: ((context) => const Home())), (route) => false);
      });
    }
  }

  void initState() {
    super.initState();
    _verificarUsuarioLogado();
  }

  // _logarUsuario() {}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // login image
                Padding(
                  padding: EdgeInsets.all(5), 
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5), 
                  child: TextField(
                    controller: _controllerSenha,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      hintText: "Senha",
                    ),
                  ),
                ),
                ElevatedButton(onPressed: _login, child: Text("Entrar")),
                Padding(padding: EdgeInsets.all(15), 
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => const CriarConta())));
                    }, 
                    child: const Text("Criar conta"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}