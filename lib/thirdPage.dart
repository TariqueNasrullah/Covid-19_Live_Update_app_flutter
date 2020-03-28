import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;


class ThirdPage extends StatefulWidget {
  final String data;
  ThirdPage({Key key, @required this.data}) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  Future<List<CountryData>> _futureData;

  // pull to refresh code
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    print('here');
    setState(() {
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  // pull to refresh ends

  @override
  void initState(){
    super.initState();
    _futureData = fetchCountryData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Data', style: TextStyle(color: Colors.lightBlueAccent),),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: _futureData,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return getListView(snapshot.data);
          }
          else if(snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'),);
          }
          return Center(child: CupertinoActivityIndicator(),);
        },
      ),
    );
  }
}

class CountryData {
  final String name;
  final int total_case, new_case, death, new_death, recovered, active, serious;

  CountryData({
    this.name,
    this.total_case,
    this.new_case,
    this.death,
    this.new_death,
    this.recovered,
    this.active,
    this.serious
  });

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      name: json['name'],
      total_case: json['total_case'],
      new_case: json['new_case'],
      death: json['death'],
      new_death: json['new_death'],
      recovered: json['recovered'],
      active: json['active'],
      serious: json['serious'],
    );
  }
}

Future<List<CountryData>> fetchCountryData() async {
  await Future.delayed(Duration(milliseconds: 1000));
  Map<String, String> headers = {
    "Authorization": "Token c5b0055ac01688ccfc0d5641b9526b88963868a0"
  };

  try{
    final response = await http.get("http://35.187.233.163:8080/countryDataList/", headers: headers);
    if(response.statusCode == 200) {
      List<CountryData> countryDataList = [];
      var decodedCountryResponse = json.decode(response.body);
      for(var row in decodedCountryResponse){
        var cd = CountryData.fromJson(row);
        countryDataList.add(cd);
      }
      return countryDataList;
    } else {
      throw Exception("Can't Connect to API");
    }
  } catch(e) {
    throw Exception("Can't Connect to API");
  }
}

Widget getListView(List<CountryData> cData) {
  var listView = ListView.builder(
    itemCount: cData.length,
    itemBuilder: (context, index){
      return Card(
        child: Container(
            height: 120,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
//                    width: MediaQuery.of(context).size.width * 0.35,
                    padding: EdgeInsets.only(top: 20, bottom: 5, left: 10, right: 15),
                    decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(width: 1, color: Colors.black12),
                        ),
                        color: Colors.grey.shade200.withOpacity(0.5)
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          '${cData[index].name}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child:  Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '${cData[index].total_case}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black38,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Center(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Infected',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
//                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text('${cData[index].death}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(right: 10, left: 2),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 1, color: Colors.black12),
                            ),
                          ),
                        ),
                        Container(
                          child: Text('${cData[index].new_death}',
                            textAlign: TextAlign.right,
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(right: 10, left: 2),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 1, color: Colors.black12),
                            ),
                          ),
                        ),
                        Container(
                          child: Text('${cData[index].recovered}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(right: 10, left: 2),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 1, color: Colors.black12),
                            ),
                          ),
                        ),
                        Container(
                          child: Text('${cData[index].new_case}',
                            textAlign: TextAlign.right,
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(right: 10, left: 2),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 1, color: Colors.black12),
                            ),
                          ),
                        ),
                        Container(
                          child: Text('${cData[index].active}',
                            textAlign: TextAlign.right,
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(right: 10, left: 2),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 1, color: Colors.black12),
                            ),
                          ),
                        ),
                        Container(
                          child: Text('${cData[index].serious}',
                            textAlign: TextAlign.right,
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(right: 10, left: 2),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 1, color: Colors.black12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
//                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text('Death',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                padding: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width,
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text('New Death',
                                  textAlign: TextAlign.left,
                                ),
                                padding: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width,
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text('Recovered',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                padding: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width,

                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text('New Case',
                                  textAlign: TextAlign.left,
                                ),
                                padding: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width,

                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text('Active Cases',
                                  textAlign: TextAlign.left,
                                ),
                                padding: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width,

                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text('Serious',
                                  textAlign: TextAlign.left,
                                ),
                                padding: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      );
    },
  );
  
  return listView;
}