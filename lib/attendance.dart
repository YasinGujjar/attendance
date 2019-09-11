import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/url.dart';
import 'main.dart';
import 'package:intl/intl.dart';


class Attendance extends StatefulWidget {
   int id;
  //MyHomePage({Key key, this.title}) : super(key: key);
  Attendance({@required this.id});
  @override
  AttendanceState createState() {
    return new AttendanceState();
  }
}

class AttendanceState extends State<Attendance> {
  URL urldomain = new URL();
 Future<List> getData() async {
    var url =urldomain.domain+ "get_attendance_for_logined_user";
    var response = await http.get(url+"?id="+widget.id.toString());
    print("Attendance Data"+response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00a65a),
        title: Text("Attendance details"),
      ),
      
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(list: snapshot.data)
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
final List list;
var names;
var time;
int counter;
  ItemList({this.list});
  
  Widget bodyData() => Align(
    alignment: Alignment.topCenter,
    child: DataTable(
        onSelectAll: (b) {},
        columnSpacing: 40.0,
        horizontalMargin: 20.0,
        //sortColumnIndex: 1,
        sortAscending: true,
        columns: <DataColumn>[
          DataColumn(
            label: Text("Date"),
            numeric: false,
            
            tooltip: "To display Date",
          ),
          DataColumn(
            label: Text("in/out",style: TextStyle( fontSize:12,),),
            numeric: false,
           
            tooltip: "To display Time",
          ),
          DataColumn(
            label: Text("Hours"),
            numeric: false,
            
            tooltip: "To display Hours",
          ),
          DataColumn(
            label: Text("Status"),
            numeric: false,
            
            tooltip: "To display Status",
          ),
        ],
        rows: list
            .map(
              (name) => DataRow(
                    cells: [
                      DataCell(
                        Text(name['today_date']==null ? "--" : convertDateFromString(name['today_date'].toString())),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(name['time_in']==null? "--":convertTimeFromString(name['time_in'].toString())),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      
                      DataCell(
                        Text(name['total_worked_hours'] ==null ? "--" : name['total_worked_hours'].toString()),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(name['attendance_status']==null ? "--" : name['attendance_status'].toString()),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                    ],
                  ),
            )
            .toList()),
  );
  
  @override
  Widget build(BuildContext context) {
    print(list.length);
       if(list == null)
    {
      counter=0;}
    else
    {
      counter=list.length;
    }
    for(int i=0;i<list.length;i++)
    {
      names=[{"today_date":list[i]['today_date'],"time":list[i]['time']}];
    }

 return bodyData();

  }
}

 String convertTimeFromString(String strDate){
 DateTime todayDate = DateTime.parse(strDate);
String formattedDate = DateFormat('hh:mm a').format(todayDate);
  return formattedDate;
 }
 String convertDateFromString(String strDate){
 DateTime todayDate = DateTime.parse(strDate);
String formattedDate = DateFormat('dd-MMM-yy').format(todayDate);
  return formattedDate;
 }

