import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class FirstPage extends StatefulWidget{
  FirstPage({Key key}) : super(key : key);

  @override
  _FirstPageState createState() => _FirstPageState();
}


class _FirstPageState extends State<FirstPage> {
  Future<CoronaData> futureData;

  List<charts.Series<PieDataClass, String>> _seriesPiData;


  // Pull to refresh codes
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    futureData = fetchCoronaData();
    setState(() {
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 3000));
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  // pull to refresh ends



  @override
  void initState(){
    super.initState();
    futureData = fetchCoronaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: ListView(
            children: <Widget>[
              FutureBuilder<CoronaData>(
                future: futureData,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    var pieData = [
                      new PieDataClass("Deaths", snapshot.data.death, Color(0xFF2A324E)),
                      new PieDataClass("Recovered", snapshot.data.recovered, Color(0xff6bb5ff)),
                      new PieDataClass("Active Cases", snapshot.data.active, Colors.blueAccent),
                    ];
                    _seriesPiData = List<charts.Series<PieDataClass, String>>();
                    _seriesPiData.add(
                        charts.Series(
                          data: pieData,
                          domainFn: (PieDataClass item, _) => item.label,
                          measureFn: (PieDataClass item, _) => item.value,
                          colorFn: (PieDataClass item, _) =>
                              charts.ColorUtil.fromDartColor(item.colorVal),
                          labelAccessorFn: (PieDataClass row, _) => '${row.value}',
                        )
                    );

                    return Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 200,
                              child: Center(
                                child: charts.PieChart(
                                  _seriesPiData,
                                  animate: false,
                                  animationDuration: Duration(seconds: 1),
                                  behaviors: [
                                    new charts.DatumLegend(
                                      outsideJustification: charts.OutsideJustification.endDrawArea,
                                      position: charts.BehaviorPosition.bottom,
                                      horizontalFirst: true,
                                      desiredMaxRows: 5,
                                      cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                                      entryTextStyle: charts.TextStyleSpec(
                                        color: charts.MaterialPalette.black,
                                        fontFamily: 'Georgia',
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                  defaultRenderer: new charts.ArcRendererConfig(
                                    arcWidth: 60,
                                    arcRendererDecorators: [
                                      new charts.ArcLabelDecorator(
                                        labelPosition: charts.ArcLabelPosition.outside,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                height: 160.0,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                          'Corona virus cases',
                                          style: TextStyle(
                                            fontSize: 25.0,
                                          )
                                      ),
                                      Text(
                                          '${snapshot.data.total_case}',
                                          style: Theme.of(context).textTheme.display1
                                      )
                                    ],
                                  ),
                                )
                            ),
                          ],
                        )
                    );
                  }
                  else {
                    return Container(height: 360, child: Center(child: CupertinoActivityIndicator(),));
                  }
                },
              ),
              Container(
                height: 120,
                child: Stack(
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "COVID-19",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Symptoms",
                              style: Theme.of(context).textTheme.title,
                            ),
                          ],
                        )
                    ),
                    Container(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width *0.5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(1),
                                    blurRadius: 100.0,
                                    spreadRadius: 5.0,
                                  ),
                                ]
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/fever.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "High Fever",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/tired.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Tiredness",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/cough.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Dry Cough",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/throat.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Sore Throat",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/breath.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Shortness of Breath",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/muscle_pain.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Aches and Pains",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 120,
                child: Stack(
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Preventions",
                              style: Theme.of(context).textTheme.title,
                            ),
                          ],
                        )
                    ),
                    Container(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width *0.5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.withOpacity(1),
                                    blurRadius: 100.0,
                                    spreadRadius: 5.0,
                                  ),
                                ]
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/wash.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Wash Hands",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/face.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Avoid Touching Face",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/mask.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Use Mask",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/home.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Stay Home",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "images/distance.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Social Distance",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
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


class CoronaData {
  final int total_case ,death, recovered, active, closed, mild, serious, recovered_or_discharged;
  final double mild_percentage, serious_percentage, recovered_or_discharged_percentage, death_percentage;

  CoronaData({
    this.total_case,
    this.death,
    this.recovered,
    this.active,
    this.closed,
    this.mild,
    this.mild_percentage,
    this.serious,
    this.serious_percentage,
    this.recovered_or_discharged,
    this.recovered_or_discharged_percentage,
    this.death_percentage,
  });

  factory CoronaData.fromJson(Map<String, dynamic> json) {
    return CoronaData(
        total_case: json['total_case'],
        death: json['death'],
        recovered: json['recovered'],
        active: json['active'],
        closed: json['closed'],
        mild: json['mild'],
        mild_percentage: json['mild_percentage'],
        serious: json['serious'],
        serious_percentage: json['serious_percentage'],
        recovered_or_discharged: json['recovered_or_discharged'],
        recovered_or_discharged_percentage: json['recovered_or_discharged_percentage'],
        death_percentage: json['death_percentage'],
    );
  }
}

Future<CoronaData> fetchCoronaData() async {
  Map<String, String> headers = {
    "Authorization": "Token c5b0055ac01688ccfc0d5641b9526b88963868a0"
  };

  try{
    final response = await http.get("http://35.247.165.9:8080/currentSituation/", headers: headers);

    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);
      if(decodedJson.length < 1) {
        throw Exception('Failed to fetch data from server.');
      }
      return CoronaData.fromJson(decodedJson[0]);
    } else {
      throw Exception('Failed to load Data');
    }
  } catch(e) {
//    print(e);
    throw Exception("Can't Connect to API");
  }
}

class PieDataClass {
  final String label;
  final int value;
  final Color colorVal;

  PieDataClass(this.label, this.value, this.colorVal);
}
