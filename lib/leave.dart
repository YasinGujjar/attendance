import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/url.dart';
import 'main.dart';
import 'package:intl/intl.dart';


class Leave extends StatefulWidget {
   int id;
  //MyHomePage({Key key, this.title}) : super(key: key);
  Leave({@required this.id});
  @override
  LeaveState createState() {
    return new LeaveState();
  }
}

class LeaveState extends State<Leave> {
  URL urldomain = new URL();
 Future<List> getData() async {
    var url =urldomain.domain+ "get_all_leaves_request_for_my_leaves";
    var response = await http.get(url+"?id="+widget.id.toString());
    print("record of leave"+response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00a65a),
        title: Text("Leave detailes"),
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
        columnSpacing: 20.0,
        horizontalMargin: 5.0,
        //sortColumnIndex: 1,
        sortAscending: true,
        columns: <DataColumn>[
          DataColumn(
            label: Text("From"),
            numeric: false,
            
            tooltip: "To display Date",
          ),
          DataColumn(
            label: Text("To",style: TextStyle(fontSize:11,),),
            numeric: false,
           
            tooltip: "To display Date",
          ),
          DataColumn(
            label: Text("Return"),
            numeric: false,
            
            tooltip: "To display Return",
          ),
          DataColumn(
            label: Text("Days"),
            numeric: false,
            
            tooltip: "To display total Days",
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
                        Text(name['from_date']==null ? "--" : convertDateFromString(name['from_date'].toString())),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(name['to_date']==null ? "--" : convertDateFromString(name['to_date'].toString()),style: TextStyle(fontSize:12,),),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      
                      DataCell(
                        Text(name['return_date'] ==null ? "--" : convertDateFromString(name['return_date'].toString())),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(name['total_days']==null ? "--" : name['total_days'].toString()),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(leaveDifferenceStatus(name['status_of_leave'],name['from_date'])),
                        showEditIcon: false,
                        placeholder: false,
                        //leaveDifferenceStatus(name['from_date'],name['today_date'])
                       // checkLeaveStatus(name['status_of_leave'],name['from_date'],name['today_date'])
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
    

 return bodyData();


    
  }
}
String convertDateFromString(String strDate){
 DateTime todayDate = DateTime.parse(strDate);
String formattedDate = DateFormat('dd-MMM-yy').format(todayDate);
  return formattedDate;
 }
 //cheching leave status


String leaveDifferenceStatus(int status ,String fromDate){


  var fromDateD = DateTime.parse(fromDate);
  DateTime todayDate = DateTime.now();
  print(todayDate.toString());
  final difference = fromDateD.difference(todayDate);
  print(difference);

  if(status==null && difference.inDays >=0  )
  {
    return 'Pending';
  }
  else if(status==1 ){
    return 'Granted';
  }
  else if(status==0  ){
    return 'Rejected';
  } 
  else if (difference.isNegative && status==null)
  {
    return 'Date passed';
  }
  return 'null';
}


