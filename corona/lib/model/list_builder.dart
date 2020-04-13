
import 'package:flutter/material.dart';

Widget listbuilder (Map data, int length) {
    return ListView.builder(
      itemCount: length,
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
                            'Last Updtaed: ${data["statistic_taken_at"]}'))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(data['countries_stat'][index]['country_name'],
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
                                  const EdgeInsets.fromLTRB(120, 0, 30, 50),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      data['countries_stat'][index]['cases'],
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
                                      const EdgeInsets.fromLTRB(120, 0, 30, 40),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          data['countries_stat'][index]
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
                                      const EdgeInsets.fromLTRB(90, 0, 30, 15),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          data['countries_stat'][index]
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
