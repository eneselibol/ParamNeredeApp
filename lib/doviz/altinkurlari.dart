import 'package:flutter/material.dart';
import 'package:paramnerede_app/doviz/dovizkurlari.dart';
import 'package:paramnerede_app/login_screen/user_repository.dart';
import 'package:provider/provider.dart';
import '../kartlarim.dart';
import '../sqflite_islemleri.dart';
import 'kurlar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AltinKurlari extends StatefulWidget {
  const AltinKurlari({Key key}) : super(key: key);

  @override
  _AltinKurlariState createState() => _AltinKurlariState();
}

class _AltinKurlariState extends State<AltinKurlari> {
  Future<Currency> getCurrency() async {
    final baseUrl = "https://finans.truncgil.com/today.json";
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode != 200) {
      throw Exception("Veri getirelemedi");
    }
    final convertedResponse = utf8.decode(response.body.runes.toList());
    final myjson = json.decode(convertedResponse);
    return Currency.fromJson(myjson);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer(
      builder: (context, UserRepository userRepo, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(""),
          backgroundColor: Color.fromRGBO(70, 70, 70, 1),
        ),
        drawer: Drawer(
          child: Container(
            color: Color.fromRGBO(70, 70, 70, 0.9),
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.2,
                  child: UserAccountsDrawerHeader(
                    margin: EdgeInsets.only(bottom: 0),
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(70, 70, 70, 1)),
                    accountName: Text(""),
                    accountEmail: Text(
                      userRepo.user.email,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SqfliteIslemleri()));
                          },
                          child: ListTile(
                            title: Text(
                              "Anasayfa",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Kartlarim()));
                          },
                          child: ListTile(
                            title: Text(
                              "Kartlar??m",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DovizKurlari()));
                          },
                          child: ListTile(
                            title: Text(
                              "D??viz Kuru",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AltinKurlari()));
                          },
                          child: ListTile(
                            title: Text(
                              "Alt??n Kuru",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: FractionalOffset.bottomLeft,
                    child: Container(
                      child: Row(mainAxisSize: MainAxisSize.max, children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.red,
                              onPressed: () {
                                userRepo.signOut();
                              },
                              child: Text(
                                "????k???? yap",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: FutureBuilder(
          future: getCurrency(),
          builder: (context, AsyncSnapshot<Currency> currency) {
            if (!currency.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView(children: [
                Column(
                  children: [
                    Table(
                      children: [
                        TableRow(children: [
                          TableCell(
                              child: Container(
                            padding: EdgeInsets.only(
                                left: 15, right: 10, bottom: 10, top: 10),
                            child: Text(
                              '??sim',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white70),
                            ),
                          )),
                          TableCell(
                              child: Container(
                            padding: EdgeInsets.only(
                                left: 55, right: 0, bottom: 10, top: 10),
                            child: Text(
                              'Al????',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white70),
                            ),
                          )),
                          TableCell(
                              child: Container(
                            padding: EdgeInsets.only(
                                left: 30, right: 30, bottom: 10, top: 10),
                            child: Text(
                              'Sat????',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white70),
                            ),
                          )),
                        ]),
                        TableRow(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            children: [
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  'Gram Alt??n',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 50, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.gramAltin.al,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 30, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.gramAltin.sat,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )),
                            ]),
                        TableRow(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            children: [
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  '??eyrek Alt??n',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 50, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.ceyrekAltin.al,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 30, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.ceyrekAltin.sat,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              )),
                            ]),
                        TableRow(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            children: [
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  'Yar??m Alt??n',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 50, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.yarimAltin.al,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 30, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.yarimAltin.sat,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )),
                            ]),
                        TableRow(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            children: [
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  'Tam Alt??n',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 50, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.tamAltin.al,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 30, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.tamAltin.sat,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              )),
                            ]),
                        TableRow(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            children: [
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  'Cumhuriyet Alt??n??',
                                  style: TextStyle(fontSize: 15),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 50, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.cumhuriyetAltini.al,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 30, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.cumhuriyetAltini.sat,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )),
                            ]),
                        TableRow(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            children: [
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  'Ata Alt??n',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 50, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.ataAltin.al,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 30, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.ataAltin.sat,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              )),
                            ]),
                        TableRow(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            children: [
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  '14 Ayar Alt??n',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 50, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.the14AyarAltin.al,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 30, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.the14AyarAltin.sat,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )),
                            ]),
                        TableRow(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            children: [
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  '18 Ayar Alt??n',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 50, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.the18AyarAltin.al,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 30, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.the18AyarAltin.sat,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              )),
                            ]),
                        TableRow(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            children: [
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  '22 Ayar Bilezik',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 50, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.the22AyarBilezik.al,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 30, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.the22AyarBilezik.sat,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )),
                            ]),
                        TableRow(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            children: [
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  'G??m????',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 50, right: 0, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.gumus.al,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              )),
                              TableCell(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    left: 30, right: 10, bottom: 10, top: 10),
                                child: Text(
                                  currency.data.gumus.sat,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white70),
                                ),
                              )),
                            ])
                      ],
                    ),
                  ],
                ),
              ]);
            }
          },
        ),
      ),
    );
  }
}
