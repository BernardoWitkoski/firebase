import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FutureListView extends StatefulWidget {
  const FutureListView({Key? key}) : super(key: key);

  @override
  State<FutureListView> createState() => _FutureListViewState();
}

class _FutureListViewState extends State<FutureListView> {

  List<String> posts = [];
  Future<List<String>> _listaPosts() async {
    FirebaseDatabase db = FirebaseDatabase.instance;
    User? user = FirebaseAuth.instance.currentUser;
    var snapshot, _keys, _data;
    posts.clear();

    //acessando os posts no banco
    await db
    .ref("usuarios")
    .child(user!.uid)
    .child("posts")
    .once()
    .then((value) => {
      snapshot = value.snapshot,
      _keys = snapshot.value.keys,
      _data = snapshot.value,
      print(_data),
      for(var key in _keys) {posts.add(key)}
    });
    return posts;
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_listaPosts();
  }
  @override
  Widget build(BuildContext context) {
    var corpo = Expanded(
      child: FutureBuilder<List<String>>(
        future: _listaPosts(),
        builder: ((context, snapshot) {
          var state = snapshot.connectionState;
          if(state == ConnectionState.waiting){
            return Center(child: 
            Column(children: [
              Text("Carregando Mensagens"),
              CircularProgressIndicator()
              ]),
            );
          } else if(state == ConnectionState.done) {
            //construir list view
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text("${posts[index].toString()}")
                  )
                );
              }),
            );
          }else {
            return Container();
          }
        }),
    ));
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        
      ),
    );
  }
}