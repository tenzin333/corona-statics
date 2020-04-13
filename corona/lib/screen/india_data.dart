import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  LinkedHashMap data;
  Map searchItem = new Map();
  TextEditingController _textEditingController= new TextEditingController();

  var stateNames = [
    "Maharashtra",
    "Tamil Nadu",
    "Delhi",
    "Kerala",
    "Telangana",
    "Uttar Pradesh",
    "Andhra Pradesh",
    "Rajasthan",
    "Madhya Pradesh",
    "Karnataka",
    "Gujarat",
    "Jammu and Kashmir",
    "Haryana",
    "Punjab",
    "West Bengal",
    "Bihar",
    "Assam",
    "Uttarakhand",
    "Odisha",
    "Chandigarh",
    "Ladakh",
    "Andaman and Nicobar Islands",
    "Chhattisgarh",
    "Goa",
    "Himachal Pradesh",
    "Puducherry",
    "Jharkhand",
    "Manipur",
    "Mizoram",
    "Arunachal Pradesh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Lakshadweep",
    "Meghalaya",
    "Nagaland",
    "Sikkim",
    "Tripura"
  ];

  final String url =
      "https://corona-virus-world-and-india-data.p.rapidapi.com/api_india";
  Widget listbuilder() {
    return ListView.builder(
      itemCount: data == null ? 0 : data['state_wise'].length,
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
                            'Last Updtaed: ${data['state_wise']['${stateNames[index]}']['lastupdatedtime']}'))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text('${stateNames[index]}',
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
                                      data['state_wise']['${stateNames[index]}']
                                          ['confirmed'],
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
                                          data['state_wise']
                                                  ['${stateNames[index]}']
                                              ['deaths'],
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
                                          data['state_wise']
                                                  ['${stateNames[index]}']
                                              ['recovered'],
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
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<dynamic> getJsonData() async {
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

  Future refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    return getJsonData();
  }

  Widget searchValues() {
    if (searchItem.isEmpty) {
      return listbuilder();
    } else {
      print("about to for loop");
      for (int i = 0; i < data['state_wise'].length; i++) {
        if (searchItem['Country']
            .toString()
            .contains((stateNames[i].toString()))) {
          print("conditin is true");
          searchItem['Cases'] =
              data['state_wise']['${stateNames[i]}']['confirmed'];
          searchItem['Deaths'] =
              data['state_wise']['${stateNames[i]}']['deaths'];
          searchItem['Recovered'] =
              data['state_wise']['${stateNames[i]}']['recovered'];
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
                          child: Text('Last Updtaed: ${data['state_wise']['${stateNames[index]}']['lastupdatedtime']} '))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(searchItem['Country'],
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
                                    const EdgeInsets.fromLTRB(90, 0, 30, 50),
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
                                        90, 0, 30, 40),
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
                                        70, 0, 30, 15),
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
        title: Text('State Wise Data'),
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
      body: RefreshIndicator(child: searchValues(), onRefresh: refreshList),
    );
  }
}
