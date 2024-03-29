import 'dart:convert';
import 'package:api/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePageState extends StatelessWidget {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  List alldata = [];
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser!.email);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Cat Shop"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  var response = await http.get(Uri.parse(
                      "https://62c27792876c4700f525337a.mockapi.io/api/v1/cats"));
                  List data = jsonDecode(response.body);
                  print(data);
                  data.forEach((element) {
                    alldata.add(element);
                  });

                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 16,
                          child: Container(
                            width: 700,
                            height: 400,
                            decoration: BoxDecoration(
                                color: Color(0x23249FD4),
                                borderRadius: BorderRadius.circular(20)),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text("Cat List"),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                for (var i = 0; i < alldata.length; i++)
                                  _list(
                                      "${alldata[i]['pict']}",
                                      "${alldata[i]['cats']}",
                                      "${alldata[i]['price']}")
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Text("Cat List")),
            ElevatedButton(
                onPressed: (() {
                  _signOut().then((value) => Get.off(() => LoginScreenState()));
                  SnackBar snackBar = SnackBar(content: Text("Logout Sukses"));
                  var showSnackBar =
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }),
                child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}

Widget _list(String imageAsset, String name, String price) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      children: <Widget>[
        SizedBox(height: 12),
        Container(height: 2, color: Colors.redAccent),
        SizedBox(height: 12),
        Row(
          children: <Widget>[
            CircleAvatar(backgroundImage: NetworkImage(imageAsset)),
            SizedBox(width: 12),
            Column(
              children: [
                SizedBox(
                    width: 70,
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                    )),
              ],
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.yellow[900],
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text('\$ $price'),
            ),
          ],
        ),
      ],
    ),
  );
}
