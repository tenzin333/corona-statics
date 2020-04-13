

import 'package:corona/screen/world_data.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'model/list_builder.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter',
      theme: ThemeData.dark(),
      home: WorldPage()
      ,
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _textEditingController = TextEditingController();

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





  Widget searchValues() {
    if (searchItem.isEmpty) {
       
       return listbuilder(data,data['countries_stat'].length);

     
    }
    else{
       print("about to for loop");
      for (int i = 0; i < data['countries_stat'].length; i++) {
        if (searchItem['Country']
            .toString()
            .contains((data['countries_stat'][i]['country_name'].toString()))) {
          print("conditin is true");
          searchItem['Cases'] = data['countries_stat'][i]['cases'];
          searchItem['Deaths'] = data['countries_stat'][i]['deaths'];
          searchItem['Recovered'] =
              data['countries_stat'][i]['total_recovered'];
          print(searchItem['Cases']);
          print(searchItem['Deaths']);
          print(searchItem['Recovered']);
        }
      }
      return ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(20),
            height: 500,
            width: 750,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 80,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text('Last Updtaed:12'))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(searchItem['Country'],
                            style: TextStyle(fontSize: 30))),
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
                                padding:
                                    const EdgeInsets.fromLTRB(35, 0, 0, 50),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Cases',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.red)),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(140, 0, 30, 50),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(searchItem['Cases'],
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.red))),
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
                                    padding: const EdgeInsets.fromLTRB(
                                        35, 10, 0, 40),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Deaths',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.red))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        140, 0, 30, 40),
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(searchItem['Deaths'],
                                            style: TextStyle(
                                                fontSize: 30,
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
                                    padding: const EdgeInsets.fromLTRB(
                                        35, 10, 0, 15),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Recovered',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        100, 0, 30, 15),
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(searchItem['Recovered'],
                                            style: TextStyle(
                                              fontSize: 30,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Wise Data'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: TextField(
            controller: _textEditingController,
            onChanged: (value) {
              searchItem['Country'] = _textEditingController.text;
            },
            style: TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        searchValues();
                      });
                    }),
                hintText: 'Search Country'),
          ),
        ),
      ),
    
      body: RefreshIndicator(child: searchValues() ,onRefresh: refreshList),
    );
  }
}
