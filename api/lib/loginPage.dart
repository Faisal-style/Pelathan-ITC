import 'package:api/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
TextEditingController _usernameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class LoginScreenState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              _text1(),
              _text2(),
              _input1(),
              _input2(),
              Center(
                child: Column(
                  children: [_LoginButton(context), _RegisternButton(context)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _text1() {
  return const Padding(
    padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
    child: Text("Masuk",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Roboto')),
  );
}

Widget _text2() {
  return const Padding(
    padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
    child: Text(
      'Silahkan Masuk Menggunakan Email yang terdaftar',
      style: TextStyle(fontFamily: 'RobotoThin', fontWeight: FontWeight.bold),
    ),
  );
}

Widget _LoginButton(BuildContext context) {
  return ElevatedButton(
      onPressed: () async {
        try {
          await _firebaseauth
              .signInWithEmailAndPassword(
                  email: _usernameController.text,
                  password: _passwordController.text)
              .then((value) {
            SnackBar snackBar = SnackBar(content: Text("Login Sukses"));
            var showSnackBar =
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Get.off(() => HomePageState());
          });
        } catch (e) {
          print(e.toString());
          SnackBar snackBar =
              SnackBar(content: Text("Login Gagal, Email atau Password Salah"));
          var showSnackBar =
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child:
          Title(color: Color.fromARGB(255, 12, 50, 239), child: Text("Login")));
}

Widget _RegisternButton(BuildContext context) {
  return ElevatedButton(
      onPressed: () async {
        try {
          await _firebaseauth.createUserWithEmailAndPassword(
              email: _usernameController.text,
              password: _passwordController.text);
          SnackBar snackBar = SnackBar(content: Text("Register Berhasil"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } catch (e) {
          print(e.toString());
          SnackBar snackBar = SnackBar(
              content: Text("Register Gagal, Email atau Password Tidak Valid"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Title(
          color: Color.fromARGB(255, 12, 50, 239), child: Text("Register")));
}

Widget _input1() {
  return Padding(
    padding: EdgeInsets.all(20),
    child: TextFormField(
      controller: _usernameController,
      decoration: const InputDecoration(
          labelText: "Email",
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 12, 50, 239)))),
    ),
  );
}

Widget _input2() {
  return Padding(
    padding: EdgeInsets.all(20),
    child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: const InputDecoration(
            labelText: "Password",
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Color.fromARGB(255, 12, 57, 239),
            )))),
  );
}
