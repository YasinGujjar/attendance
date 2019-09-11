import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/url.dart';
import 'main.dart';
import 'package:intl/intl.dart';


class Schedule extends StatefulWidget {
   int id;
  //MyHomePage({Key key, this.title}) : super(key: key);
  Schedule({@required this.id});
  @override
  ScheduleState createState() {
    return new ScheduleState();
  }
}

class ScheduleState extends State<Schedule> {
 
  URL urldomain = new URL();
 Future<List> getData() async {
    var url =urldomain.domain+ "getScheduleForthisID";
    var response = await http.get(url+"?id="+widget.id.toString());
    print("Schedule Data"+response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00a65a),
        title: Text("Schedule Detailes"),
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

class ItemList extends StatefulWidget {
final List list;

  ItemList({this.list});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
var names;

//_TimeState timewidget = new _TimeState();

var time;

int counter;
 String convertTimeFromString(String time){
    String hours = time.substring(0,2);
    String minutes = time.substring(3,5);
    TimeOfDay formatedTime = TimeOfDay(hour: int.parse(hours), minute: int.parse(minutes));
    print(formatedTime.format(context));
    return formatedTime.format(context);
  }

  Widget bodyData() => Align(
    alignment: Alignment.topCenter,
    
    child: DataTable(
      
        onSelectAll: (b) {},
        columnSpacing: 20.0,
        horizontalMargin: 0.0,
        //sortColumnIndex: 1,
        sortAscending: true,
        columns: <DataColumn>[
          DataColumn(
            label: Text("From"),
            numeric: false,
            
            tooltip: "To display Date",
          ),
          DataColumn(
            label: Text("To",style: TextStyle(fontSize:11, ),),
            numeric: false,
           
            tooltip: "To display Date",
          ),
          DataColumn(
            label: Text("From"),
            numeric: false,
            
            tooltip: "To display time",
          ),
          DataColumn(
            label: Text("To",),
            numeric: false,
            
            tooltip: "To display time",
          ),
           DataColumn(
            label: Text("Status"),
            numeric: false,
            
            tooltip: "To display Status",
          ),
        ],
        rows: widget.list
            .map(
              (name) => DataRow(
                    cells: [
                      DataCell(
                        Text(convertDateFromString(name['from_date'])),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(convertDateFromString(name['to_date'])),
                        showEditIcon: false,
                        placeholder: false,
                        //convertDateFromString(name['status']
                      ),
                      DataCell(
                        FittedBox(
                          fit:BoxFit.contain,
                          child: Text(convertTimeFromString(name['from_time']))),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        FittedBox(
                          fit:BoxFit.contain,
                          child: Text(convertTimeFromString(name['to_time']))),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                       DataCell(
                        Text(checkStatus(name['status'])),
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

    
    print(widget.list.length);
       if(widget.list == null)
    {
      counter=0;}
    else
    {
      counter=widget.list.length;
    }
    for(int i=0;i<widget.list.length;i++)
    {
      names=[{"today_date":widget.list[i]['today_date'],"time":widget.list[i]['time']}];
    }
   

 return bodyData();

  }
}
//date conversion
 String convertDateFromString(String strDate){
 DateTime todayDate = DateTime.parse(strDate);
String formattedDate = DateFormat('dd-MMM-yy').format(todayDate);
  return formattedDate;
 }
//time conversion

 

//cheching status
String checkStatus(int strstatus)
{String finalstatus;
  if (strstatus==0)
  {
    finalstatus="Archived";
  }
  else if(strstatus==1)
  {
    finalstatus="Active";
  }
  else
  {
    finalstatus="--";
  }
  return finalstatus;
}

