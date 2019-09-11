import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model/url.dart';
import 'attendance.dart';
import 'schedule.dart';
import 'leave.dart';
import 'dart:async';
import 'dart:convert';
import 'main.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  
String image ;
String name;
int id;
  //MyHomePage({Key key, this.title}) : super(key: key);
  MyHomePage({@required this.image, @required this.name,@required this.id});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  int _counter = 0;
  String btntext = "Time in";
  Color btncolor = Color(0xff00a65a);
   String _name="";
  String _password="";
  String argName = "";
  String argPassword="";


  URL urldomain = new URL();
  


  MyApp ap=new MyApp();
  /* Future getData() async {
    final response =
        await http.get(urldomain.domain + "getdata.php?getDashboard=get");
    var abc = json.decode(response.body);
    // print(abc[0]['Name']);
    return abc[0]['Name'];
    

    // pro_img =(abc[0]['Name']);

    // return json.decode(response.body);
    // List userMap = jsonDecode(response.body);
//var user = User.fromJson(userMap);

/* print('Email : ${user.email}!');
print(' And the password is  ${user.password}.'); */
  }
 */  void getInitialTimeinstate() async{
    var url =urldomain.domain+ "check_time";
    var response = await http.get(url+"?id="+widget.id.toString());
    print('Intial time: ${response.body}'); 
    if (response.body == "do_time_out") {
      setState(() {
        btntext = "Time out";
        btncolor = Colors.red;
      });
    }
    else if (response.body == "do_time_in") {
      setState(() {
        btntext = "Time in";
        btncolor = Color(0xff00a65a);
      });
    }
    else if (response.body == "on_leave") {
      setState(() {
        btntext = "On Leave";
        btncolor = Colors.white;

      });
    }
    else {
      setState(() {
        btntext = "Attendance Marked";
        btncolor = Color(0xff00a65a);
      });
    }

  }

  void timein() async {
   
    //print(widget.id);
   if (btntext=="Time in")
   {
      var url = urldomain.domain + "time_in";
    var response = await http.get(url+"?id="+widget.id.toString());
   
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.body == "time_in") {
      setState(() {
        btntext = "Time out";
        btncolor = Colors.red;
      });

      print("Scvvv");
    } else {
      print("error timein");
    }
   }
    else if(btntext=="Time out")
   {
     var url = urldomain.domain + "time_out";
     var response = await http.get(url+"?id="+widget.id.toString());

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.body == "time_out") {
       setState(() {
        btntext = "Attendance Marked";
        btncolor = Colors.white;
      });
      print("Save..");
    } else {
      print("error timeout");
    }

   } 

    else if(btntext=="Attendance Marked")
   {
      showReview(context);
      print("Sorry attendance marked");

       } 
       
       else if(btntext=="On Leave")
   {
      showReview2(context);
      print("User on leave");

       } 

//use to read file on server
    //print(await http.read('http://example.com/foobar.txt'));
  }

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitialTimeinstate();
    //getData();
    /// print("alllllllll");
  }

  @override
  Widget build(BuildContext context) {
    
   // getData();
    var myGroup = AutoSizeGroup();
    // MediaQueryData queryData = MediaQuery.of(context);
    //  double devicePixelRatio = queryData.devicePixelRatio;
    TextStyle style30 = new TextStyle(
      inherit: true,
      fontSize: 30.0,
      color: Color(0xff686868),
      //fontSize: 30,

      // fontFamily: 'Montserrat'
    );
    TextStyle style20 = new TextStyle(
      inherit: true,
      color: Color(0xff686868),
      //fontSize: 30,

      // fontFamily: 'Montserrat' ,
      fontSize: 20.0,
    );
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(

      
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //title: Text(widget.title),
        backgroundColor: Color(0xff00a65a),

        // action button

        // action button
        /*  IconButton(
              icon: Icon(Icons.airline_seat_legroom_reduced),
              onPressed: () {
                
              }, */
        // ),
        leading: new Container(
           /* child: CircleAvatar(
              backgroundImage:
                NetworkImage(widget.image),
                  minRadius: 2,
                 maxRadius: 2,
                ), */
               ),
        title: Text('Attendance System'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_pin,
              size: 40.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
      
      body:
       ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          height:
                              270.0, // ScreenUtil.getInstance().setHeight(270), //270.0,
                          // color: Color(0xff00a65a),
                          decoration: BoxDecoration(
                            color: Color(0xff00a65a),
                            image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.2),
                                  BlendMode.dstATop),
                              image: AssetImage('assets/1img.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height: 200,
                                  width: 300,
                                  // color: Colors.red,
                                  child: Center(
                                    child: Container(
                                              child: CircleAvatar(
                                                backgroundImage:
                                                    NetworkImage(widget.image),
                                                //ExactAssetImage("assets/1img.jpg"),

                                                minRadius: 80,
                                                maxRadius: 80,
                                              ),
                                            ),
                                          
                                    /* child: CircleAvatar(
                                      backgroundImage:NetworkImage(pro_img),
                                          //ExactAssetImage("assets/1img.jpg"),
                                                                              
                                                                               minRadius: 80,
                                      maxRadius: 80,
                                    ), */
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  // width: 300,
                                  //color: Colors.blue,
                                  child: Text(
                                    widget.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      //fontFamily: 'Montserrat'
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 100.0,
                        color: Color(0xff00a65a),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Card(
                                  elevation: 5.0,
                                  child: Container(
                                    height: 90,
                                    child: Center(
                                      child: Container(
                                        //  height: 60,

                                        // color: Colors.red,

                                        child: new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '999',
                                              style: TextStyle(
                                                color: Color(0xff686868),
                                                fontSize: 25,

                                                //fontFamily: 'Montserrat'
                                              ),
                                            ),
                                            Text(
                                              'Days',
                                              style: TextStyle(
                                                color: Color(0xff686868),
                                                fontSize: 15,
                                                //fontFamily: 'Montserrat'
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: Card(
                                  elevation: 5.0,
                                  child: Container(
                                    height: 90,
                                    child: Center(
                                      child: Container(
                                        //height: 60,
                                        //color: Colors.red,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '999',
                                              style: TextStyle(
                                                color: Color(0xff686868),
                                                fontSize: 25,
                                                // fontFamily: 'Montserrat'
                                              ),
                                            ),
                                            Text(
                                              'Days',
                                              style: TextStyle(
                                                color: Color(0xff686868),
                                                fontSize: 15,
                                                //fontFamily: 'Montserrat'
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: Card(
                                  elevation: 5.0,
                                  child: Container(
                                    height: 90,
                                    child: Center(
                                      child: Container(
                                        // height: 60,
                                        //color: Colors.red,

                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '999',
                                              style: TextStyle(
                                                color: Color(0xff686868),
                                                fontSize:
                                                    25, // ScreenUtil(allowFontScaling: true).setSp(30),

                                                //fontFamily: 'Montserrat'
                                              ),
                                            ),
                                            Text(
                                              'Days',
                                              style: TextStyle(
                                                color: Color(0xff686868),
                                                fontSize:
                                                    15, // ScreenUtil(allowFontScaling: true).setSp(20),
                                                //fontFamily: 'Montserrat'
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 80,
                          //color: Colors.blue,
                          child: Card(
                            elevation: 5.0,
                            child: Container(
                              // color: Colors.pink,
                              child: OutlineButton(
                                child: Text(btntext),
                                onPressed: () {
                                  // var now = new DateTime.now();
                                  timein();
//var berlinWallFell = new DateTime.utc(1989, 11, 9);
//var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");
//print(now);
                                }, //callback when button is clicked
                                borderSide: BorderSide(
                                  color: btncolor, //Color of the border
                                  style:
                                      BorderStyle.solid, //Style of the border
                                  width: 2, //width of the border
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 5.0,
            child: ListTile(
                title: Text('Attendance'),
                subtitle: Text('System'),
                leading:
                    const Icon(Icons.desktop_windows, color: Color(0xff00a65a)),
                trailing: SizedBox(
                  width: 50,
                  height: 50,
                  child: RaisedButton(
                    child: const Icon(Icons.attachment, color: Colors.white),
                    color: Color(0xff00a65a),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Attendance(id: widget.id,)),);
                    },
                  ),
                )),
          ),
          Card(
            elevation: 5.0,
            child: ListTile(
                title: Text('Schedule'),
                subtitle: Text('System'),
                leading:
                    const Icon(Icons.desktop_windows, color: Color(0xff00a65a)),
                trailing: SizedBox(
                  width: 50,
                  height: 50,
                  child: RaisedButton(
                    child: const Icon(Icons.attachment, color: Colors.white),
                    color: Color(0xff00a65a),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Schedule(id: widget.id)),);
                    },
                  ),
                )),
          ),
          Card(
            elevation: 5.0,
            child: ListTile(
                title: Text('Leave'),
                subtitle: Text('System'),
                leading:
                    const Icon(Icons.desktop_windows, color: Color(0xff00a65a)),
                trailing: SizedBox(
                  width: 50,
                  height: 50,
                  child: RaisedButton(
                    child: const Icon(Icons.attachment, color: Colors.white),
                    color: Color(0xff00a65a),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => Leave(id: widget.id)),);
                    },
                  ),
                )),
          ),
          Padding(padding: EdgeInsets.only(top: 70))
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()  {
           argName="null";
                    argPassword="null";
                    print("name:"+argName+" Password:"+argPassword);
                    saveNamePreference(argName,argPassword);
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);

        },
        tooltip: 'Logout',
        icon: Icon(Icons.exit_to_app),
        label: Text("Logout"),
        backgroundColor: Color(0xff00a65a),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
Future<bool> showReview(context) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
                height: 350.0,
                width: 200.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(height: 150.0),
                        Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              color: Color(0xff00a65a)),
                        ),
                        Positioned(
                            top: 50.0,
                            left: 94.0,
                            child: Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45.0),
                                  border: Border.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 2.0),
                                 image: DecorationImage(
                                   image: ExactAssetImage('assets/sad.png'),
      fit: BoxFit.cover,
                                 ) ),
                            ))
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Sorry! Attendance Already Marked Try Next Day ',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                          ),
                        )),
                    SizedBox(height: 15.0),
                    FlatButton(
                      child: Center(
                        child: Text(
                          'OKAY',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14.0,
                              color: Colors.teal),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.transparent
                    )
                  ],
                )));
      });
}
//for on leave

Future<bool> showReview2(context) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
                height: 350.0,
                width: 200.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(height: 150.0),
                        Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              color: Color(0xff00a65a)),
                        ),
                        Positioned(
                            top: 50.0,
                            left: 94.0,
                            child: Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45.0),
                                  border: Border.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 2.0),
                                 image: DecorationImage(
                                   image: ExactAssetImage('assets/sad.png'),
      fit: BoxFit.cover,
                                 ) ),
                            ))
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Sorry! User is on Leave Try Next Day ',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                          ),
                        )),
                    SizedBox(height: 15.0),
                    FlatButton(
                      child: Center(
                        child: Text(
                          'OKAY',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14.0,
                              color: Colors.teal),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.transparent
                    )
                  ],
                )));
      });
}
