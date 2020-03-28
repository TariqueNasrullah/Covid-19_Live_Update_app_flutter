//Container(
//width: MediaQuery.of(context).size.width,
//height: 120,
//child: Row(
//children: <Widget>[
//Container(
//width: MediaQuery.of(context).size.width * 0.35,
//padding: EdgeInsets.only(top: 20, bottom: 5, left: 10, right: 15),
//decoration: BoxDecoration(
//border: Border(
//right: BorderSide(width: 1, color: Colors.black12),
//),
//color: Colors.grey.shade200.withOpacity(0.5)
//),
//child: Column(
//children: <Widget>[
//Text(
//'${cData[index].name}',
//style: TextStyle(
//fontWeight: FontWeight.w700,
//),
//),
//Expanded(
//child: Align(
//alignment: Alignment.bottomCenter,
//child:  Row(
//children: <Widget>[
//Expanded(
//child: Text(
//'${cData[index].total_case}',
//textAlign: TextAlign.center,
//style: TextStyle(
//fontWeight: FontWeight.w700,
//color: Colors.black38,
//fontSize: 18,
//),
//),
//),
//],
//),
//),
//),
//Expanded(
//child: Align(
//alignment: Alignment.bottomCenter,
//child: Center(
//child: Row(
//children: <Widget>[
//Expanded(
//child: Text(
//'Infected',
//textAlign: TextAlign.center,
//overflow: TextOverflow.ellipsis,
//style: TextStyle(
//color: Colors.blueAccent,
//fontStyle: FontStyle.italic,
//fontSize: 12,
//),
//),
//),
//],
//),
//)
//)
//),
//],
//),
//),
//Container(
//width: MediaQuery.of(context).size.width * 0.3,
//padding: EdgeInsets.only(top: 5, bottom: 5),
//child: Column(
//children: <Widget>[
//Container(
//child: Text('${cData[index].death}',
//textAlign: TextAlign.right,
//style: TextStyle(
//fontWeight: FontWeight.w700,
//),
//),
//width: MediaQuery.of(context).size.width,
//padding: EdgeInsets.only(right: 10, left: 2),
//decoration: BoxDecoration(
//border: Border(
//right: BorderSide(width: 1, color: Colors.black12),
//),
//),
//),
//Container(
//child: Text('${cData[index].new_death}',
//textAlign: TextAlign.right,
//),
//width: MediaQuery.of(context).size.width,
//padding: EdgeInsets.only(right: 10, left: 2),
//decoration: BoxDecoration(
//border: Border(
//right: BorderSide(width: 1, color: Colors.black12),
//),
//),
//),
//Container(
//child: Text('${cData[index].recovered}',
//textAlign: TextAlign.right,
//style: TextStyle(
//fontWeight: FontWeight.w700,
//),
//),
//width: MediaQuery.of(context).size.width,
//padding: EdgeInsets.only(right: 10, left: 2),
//decoration: BoxDecoration(
//border: Border(
//right: BorderSide(width: 1, color: Colors.black12),
//),
//),
//),
//Container(
//child: Text('${cData[index].new_case}',
//textAlign: TextAlign.right,
//),
//width: MediaQuery.of(context).size.width,
//padding: EdgeInsets.only(right: 10, left: 2),
//decoration: BoxDecoration(
//border: Border(
//right: BorderSide(width: 1, color: Colors.black12),
//),
//),
//),
//Container(
//child: Text('${cData[index].active}',
//textAlign: TextAlign.right,
//),
//width: MediaQuery.of(context).size.width,
//padding: EdgeInsets.only(right: 10, left: 2),
//decoration: BoxDecoration(
//border: Border(
//right: BorderSide(width: 1, color: Colors.black12),
//),
//),
//),
//Container(
//child: Text('${cData[index].serious}',
//textAlign: TextAlign.right,
//),
//width: MediaQuery.of(context).size.width,
//padding: EdgeInsets.only(right: 10, left: 2),
//decoration: BoxDecoration(
//border: Border(
//right: BorderSide(width: 1, color: Colors.black12),
//),
//),
//),
//],
//),
//),
//Container(
//margin: EdgeInsets.only(top: 5, bottom: 5),
//width: MediaQuery.of(context).size.width * 0.3,
//child: Column(
//children: <Widget>[
//Container(
//child: Column(
//children: <Widget>[
//Container(
//child: Text('Death',
//textAlign: TextAlign.left,
//style: TextStyle(
//color: Colors.black38,
//fontWeight: FontWeight.w700,
//),
//),
//padding: EdgeInsets.only(left: 10),
//width: MediaQuery.of(context).size.width,
//)
//],
//),
//),
//Container(
//child: Column(
//children: <Widget>[
//Container(
//child: Text('New Death',
//textAlign: TextAlign.left,
//),
//padding: EdgeInsets.only(left: 10),
//width: MediaQuery.of(context).size.width,
//)
//],
//),
//),
//Container(
//child: Column(
//children: <Widget>[
//Container(
//child: Text('Recovered',
//textAlign: TextAlign.left,
//style: TextStyle(
//color: Colors.black38,
//fontWeight: FontWeight.w700,
//),
//),
//padding: EdgeInsets.only(left: 10),
//width: MediaQuery.of(context).size.width,
//
//)
//],
//),
//),
//Container(
//child: Column(
//children: <Widget>[
//Container(
//child: Text('New Case',
//textAlign: TextAlign.left,
//),
//padding: EdgeInsets.only(left: 10),
//width: MediaQuery.of(context).size.width,
//
//)
//],
//),
//),
//Container(
//child: Column(
//children: <Widget>[
//Container(
//child: Text('Active Cases',
//textAlign: TextAlign.left,
//),
//padding: EdgeInsets.only(left: 10),
//width: MediaQuery.of(context).size.width,
//
//)
//],
//),
//),
//Container(
//child: Column(
//children: <Widget>[
//Container(
//child: Text('Serious',
//textAlign: TextAlign.left,
//),
//padding: EdgeInsets.only(left: 10),
//width: MediaQuery.of(context).size.width,
//)
//],
//),
//),
//],
//),
//)
//],
//)
//),