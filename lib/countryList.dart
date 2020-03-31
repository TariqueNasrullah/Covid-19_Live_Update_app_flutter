import 'package:flutter/material.dart';
import 'countryData.dart';

class CountryList extends StatefulWidget{
  final List<CountryData> cData;

  const CountryList({Key key, this.cData}) : super(key: key);

  @override
  _CountryListState createState() => _CountryListState();

}

class _CountryListState extends State<CountryList>{
  var mainData = List<CountryData>();
  var tempData = List<CountryData>();
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    mainData.addAll(widget.cData);
    tempData.addAll(widget.cData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: TextField(
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18.0)))
              ),
              onChanged: (value) {
                filterSearch(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tempData.length,
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
                                    '${tempData[index].name}',
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
                                            child: new Text(
                                              '${tempData[index].total_case}',
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
                                    child: Text('${tempData[index].death}',
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
                                    child: Text('${tempData[index].new_death}',
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
                                    child: Text('${tempData[index].recovered}',
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
                                    child: Text('${tempData[index].new_case}',
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
                                    child: Text('${tempData[index].active}',
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
                                    child: Text('${tempData[index].serious}',
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
            ),
          )
        ],
      ),
    );
  }

  void filterSearch(String query){
    if(query.isNotEmpty) {
      var temp = List<CountryData>();
      mainData.forEach((item) {
        if(item.name.toLowerCase().contains(query.toLowerCase())) {
          temp.add(item);
        }
        setState(() {
          tempData.clear();
          tempData.addAll(temp);
        });
      });
    } else {
      setState(() {
        tempData.clear();
        tempData.addAll(mainData);
      });
    }
  }
}