import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  _validaCampo() {}
  _logarUsuario() {}


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
                ElevatedButton(onPressed: _validaCampo, child: Text("Entrar"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}