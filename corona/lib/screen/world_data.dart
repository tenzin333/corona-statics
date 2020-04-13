import 'package:corona/main.dart';

import 'package:corona/screen/india_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class WorldPage extends StatefulWidget {
  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
 Map searchItem = new Map();
  Map data;
  final String url =
      "https://corona-virus-world-and-india-data.p.rapidapi.com/api";

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(Uri.encodeFull(url), headers: {
      "x-rapidapi-host": "corona-virus-world-and-india-data.p.rapidapi.com",
      "x-rapidapi-key": "3e7ab7e94emshca396c25538373fp14c862jsna3dd4addf531"
    });
    setState(() {
      try {
        data = json.decode(response.body);
        
      } catch (e) {
        print(e);
      }
    });

    return "Success";
  }

  Future<String> refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    return getJsonData();
  }

  
  Widget listbuilder() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(20),
          height: 500,
          width: 750,
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: 80,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                            'Last Updtaed: ${data['world_total']["statistic_taken_at"]}'))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text('World Data',
                          style: TextStyle(fontSize: 35))),
                ),
                Positioned(
                  //Card1
                  top: 110,
                  child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 60),
                      height: 200,
                      width: 500,
                      child: Card(
                        color: Color(0xFFf4e8c1),
                        elevation: 30,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 0, 0, 50),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Cases',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red)),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(90, 0, 30, 50),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                     data['world_total']['total_cases'],
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.red))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                //Card2 widget
                Positioned(
                  top: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 0),
                          width: 500,
                          height: 200,
                          child: Card(
                            color: Color(0XFFa0c1b8),
                            elevation: 30,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60)),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(35, 10, 0, 40),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Deaths',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.red))),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(90, 0, 30, 40),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          data['world_total']
                                              ['total_deaths'],
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.red))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
                //Card 3 widget
                Positioned(
                  top: 300,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: 550,
                          child: Card(
                            color: Color(0XFFcbbcf6),
                            elevation: 30,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60)),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(35, 10, 0, 15),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Recovered',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold))),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(70, 0, 30, 15),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          data['world_total']
                                              ['total_recovered'],
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.green,
                                          ))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar( title:Text('World Data')
      
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('tenzin'),
            accountEmail: Text('tenthinlay007@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.deepOrangeAccent,
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondPage()));
              },
              title: Text("India State Wise Data"),
              leading: Icon(Icons.web),
            ),
          ),
        
Card(
            child: ListTile(
              title: Text("Country Wise Data"),
              leading: Icon(Icons.web),
              onTap: (){
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyApp()));
              }
              ,
            ),
          ),
           
                  Card(
            child: ListTile(
              title: Text("Exit"),
              leading: Icon(Icons.exit_to_app),
              onTap: (){
           SystemNavigator.pop();
              }
              ,
            ),
          ),
        ],
      )),
          body: RefreshIndicator(child: listbuilder() ,onRefresh: refreshList),



    );

  }
}