
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class SecondPage extends StatefulWidget{
  SecondPage({Key key}) : super(key : key);

  @override
  _SecondPageState createState() => _SecondPageState();
}


class _SecondPageState extends State<SecondPage> {
  Future<CoronaData> futureData;
  Future<List<DateCaseData>> _futureDateCaseData;
  Future<List<DateDeathData>> _futureDateDeathData;

  List<charts.Series<PieDataClass, String>> _seriesPiData;
  List<charts.Series> _seriesDateCaseData;
  List<charts.Series> _seriesDeathCaseData;

  @override
  void initState() {
    super.initState();
    futureData = fetchCoronaData();
    _futureDateCaseData = fetchDateCaseDate();
    _futureDateDeathData = fetchDateDeathData();
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesData, DateTime>> _createSampleData(List<DateCaseData> dCaseData) {
    List<TimeSeriesData> data = [];

    for(var value in dCaseData) {
      data.add((new TimeSeriesData(value.date, value.totalCase)));
    }

    return [
      new charts.Series<TimeSeriesData, DateTime>(
        id: 'DateCase',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesData sales, _) => sales.time,
        measureFn: (TimeSeriesData sales, _) => sales.value,
        data: data,
      )
    ];
  }

  static List<charts.Series<TimeSeriesData, DateTime>> _createDeathSampleData(List<DateDeathData> dDeathData) {
    List<TimeSeriesData> data = [];

    for(var value in dDeathData) {
      data.add((new TimeSeriesData(value.date, value.death)));
    }

    return [
      new charts.Series<TimeSeriesData, DateTime>(
        id: 'DeathCase',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesData sales, _) => sales.time,
        measureFn: (TimeSeriesData sales, _) => sales.value,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                          id: 'pichart_1',
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
                              margin: EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                          '${snapshot.data.total_case}',
                                          style: TextStyle(
                                            fontSize: 25.0
                                          ),
                                      ),
                                      Text(
                                          'Corona virus cases',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          )
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            Container(
                              height: 120,
                              margin: EdgeInsets.all(10),
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 15.0, // soften the shadow
                                    offset: Offset(0.0, 0.75),
                                  )
                                ],
                              ),
                              child:Center(
                                child: Container(
                                  color: Colors.white,
                                  child: Stack(
                                    children: <Widget>[
                                      ClipPath(
                                        clipper: LinePathClass(),
                                        child: Container(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '${snapshot.data.death}',
                                                      textAlign: TextAlign.center,
                                                      style: Theme.of(context).textTheme.display1,
                                                    ),
                                                    Text(
                                                        'Deaths',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '${snapshot.data.recovered}',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 35,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                        'Recovered',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                        )
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 120,
                              margin: EdgeInsets.all(10),
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 15.0, // soften the shadow
                                    offset: Offset(0.0, 0.75),
                                  )
                                ],
                              ),
                              child:Center(
                                child: Container(
                                  color: Colors.white,
                                  child: Stack(
                                    children: <Widget>[
                                      ClipPath(
                                        clipper: LinePathClass(),
                                        child: Container(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Text(
                                                            '${snapshot.data.mild}',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color: Colors.blueAccent
                                                            )
                                                        ),
                                                        Text(
                                                            '(${snapshot.data.mild_percentage})%',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.blueGrey
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                        'in Mild Condition',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Text(
                                                            '${snapshot.data.serious}',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color: Colors.black
                                                            )
                                                        ),
                                                        Text(
                                                            '(${snapshot.data.serious_percentage})%',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.white70,
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                        'in Critical Condition',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        )
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 120,
                              margin: EdgeInsets.all(10),
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 15.0, // soften the shadow
                                    offset: Offset(0.0, 0.75),
                                  )
                                ],
                              ),
                              child:Center(
                                child: Container(
                                  color: Colors.white,
                                  child: Stack(
                                    children: <Widget>[
                                      ClipPath(
                                        clipper: LinePathClass(),
                                        child: Container(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Text(
                                                            '${snapshot.data.recovered}',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color: Colors.blue
                                                            )
                                                        ),
                                                        Text(
                                                            '(${snapshot.data.recovered_or_discharged_percentage})%',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.blueGrey
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                        'Recovered / Discharged',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        )
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Text(
                                                            '${snapshot.data.death}',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color: Colors.black
                                                            )
                                                        ),
                                                        Text(
                                                            '(${snapshot.data.death_percentage})%',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors.white70,
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                        'Deaths',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        )
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 250,
                              margin: EdgeInsets.all(10),
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 15.0, // soften the shadow
                                    offset: Offset(0.0, 0.75),
                                  )
                                ],
                              ),
                              child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child:  FutureBuilder<List<DateCaseData>>(
                                          future: _futureDateCaseData,
                                          builder: (context, lSnapshot){
                                            if(lSnapshot.connectionState == ConnectionState.done && lSnapshot.hasData) {

                                              final timeSeriesDateCaseData = [];
                                              for(var r in lSnapshot.data) {
                                                timeSeriesDateCaseData.add(new TimeSeriesData(r.date, r.totalCase));
                                              }
                                              _seriesDateCaseData = _createSampleData(lSnapshot.data);

                                              return new charts.TimeSeriesChart(
                                                _seriesDateCaseData,
                                                animate: true,
                                                dateTimeFactory: const charts.LocalDateTimeFactory(),
                                              );
                                            }
                                            return Center(child: CupertinoActivityIndicator(),);
                                          },
                                        ),
                                      ),
                                      Center(child: Text('Date-Covid19 Case Graph'),),
                                    ],
                                  )
                              ),
                            ),
                            Container(
                              height: 250,
                              margin: EdgeInsets.all(10),
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 15.0, // soften the shadow
                                    offset: Offset(0.0, 0.75),
                                  )
                                ],
                              ),
                              child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child:  FutureBuilder<List<DateDeathData>>(
                                          future: _futureDateDeathData,
                                          builder: (context, lSnapshot){
                                            if(lSnapshot.connectionState == ConnectionState.done && lSnapshot.hasData) {

                                              final timeSeriesDateCaseData = [];
                                              for(var r in lSnapshot.data) {
                                                timeSeriesDateCaseData.add(new TimeSeriesData(r.date, r.death));
                                              }
                                              _seriesDeathCaseData = _createDeathSampleData(lSnapshot.data);

                                              return new charts.TimeSeriesChart(
                                                _seriesDeathCaseData,
                                                animate: true,
                                                dateTimeFactory: const charts.LocalDateTimeFactory(),
                                              );
                                            }
                                            return Center(child: CupertinoActivityIndicator(),);
                                          },
                                        ),
                                      ),
                                      Center(child: Text('Date-Death Graph'),),
                                    ],
                                  )
                              ),
                            ),
                          ],
                        )
                    );
                  }
                  else if(snapshot.hasError) {
                   return Container(
                     height: 50,
                     color: Colors.redAccent,
                     child: Center(child: Text('${snapshot.error}', style: TextStyle(color: Colors.white),),),
                   );
                  }
                  else {
                    return Container(height: 600, child: Center(child: CupertinoActivityIndicator(),),);
                  }
                },
              ),
            ],
      ),
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

class DateCaseData {
  final int totalCase;
  final DateTime date;
  DateCaseData({this.totalCase, this.date});

  factory DateCaseData.fromJson(Map<String, dynamic> json) {
   return DateCaseData(
     totalCase: json['case'],
     date: DateTime.parse(json['date']),
   );
  }
}

class DateDeathData {
  final int death;
  final DateTime date;
  DateDeathData({this.death, this.date});

  factory DateDeathData.fromJson(Map<String, dynamic> json) {
    return DateDeathData(
      death: json['death'],
      date: DateTime.parse(json['date']),
    );
  }
}

Future<List<DateCaseData>> fetchDateCaseDate() async {
  await Future.delayed(Duration(milliseconds: 1000));
  Map<String, String> headers = {
    "Authorization": "Token c5b0055ac01688ccfc0d5641b9526b88963868a0"
  };
  try {
    final response = await http.get("http://35.247.165.9:8080/dateCaseDataList/", headers: headers);

    if(response.statusCode == 200) {
      var decodedJson = json.decode(response.body);
      List<DateCaseData> _dateCaseDataList = [];

      for(var r in decodedJson) {
        _dateCaseDataList.add(DateCaseData.fromJson(r));
      }

      return _dateCaseDataList;
    } else {
      throw Exception("Can't Connect to API");
    }
  } catch(e) {
    throw Exception("Can't Connect to API");
  }
}

Future<List<DateDeathData>> fetchDateDeathData() async {
  await Future.delayed(Duration(milliseconds: 1000));
  Map<String, String> headers = {
    "Authorization": "Token c5b0055ac01688ccfc0d5641b9526b88963868a0"
  };
  try {
    final response = await http.get("http://35.247.165.9:8080/DateDeathDataList/", headers: headers);

    if(response.statusCode == 200) {
      var decodedJson = json.decode(response.body);
      List<DateDeathData> _dateDeathDataList = [];

      for(var r in decodedJson) {
        _dateDeathDataList.add(DateDeathData.fromJson(r));
      }

      return _dateDeathDataList;
    } else {
      throw Exception("Can't Connect to API");
    }
  } catch(e) {
    throw Exception("Can't Connect to API");
  }
}

Future<CoronaData> fetchCoronaData() async {
  await Future.delayed(Duration(milliseconds: 1000));
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

class LinePathClass  extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    var path = Path();
    path.moveTo(size.width*0.55, 0);
    path.lineTo(size.width*0.45, size.height);
    path.lineTo((size.width), size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

/// Sample time series data type.
class TimeSeriesData {
  final DateTime time;
  final int value;

  TimeSeriesData(this.time, this.value);
}

