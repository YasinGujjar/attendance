import 'package:flutter/material.dart';
//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert' ;
import 'package:http/http.dart' as http;
import 'model/url.dart';
import 'model/user.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
 
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
       // fontFamily: 'Montserrat',
        /*  textTheme: TextTheme(
          title: TextStyle(fontSize: 100)
        ) */
      ),
      home: LoginPage(),
      routes: <String, WidgetBuilder>
      {
        '/login':(BuildContext context )=> new LoginPage(),
        //'/home':(BuildContext context )=> new  MyHomePage(),
      }
    );
  }
}


class LoginPage extends StatefulWidget {
  
  @override
  

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _name="";
  String _password="";
  String argName = "";
  String argPassword="";
  
  
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();
   URL urldomain =new URL();
   
  void  addData() async
{
  var url=urldomain.domain+"user_login";
  final response = await http.get(url+"?email="+_controller.text+"&"+"password="+_controller1.text+"&"+"login=abc"); 

print('Response status: ${response.statusCode}');
print('Response body: ${response.body}');
var jsonResponse = json.decode(response.body);

var RequestResponse=jsonResponse['response'];

print(RequestResponse['message']);

if (RequestResponse['message']=="success")
{
  var name=jsonResponse['0']['first_name'];
var id = jsonResponse['0']['employee_id'];
print(id);
var image="http://gbc.zeenosofts.com/blog/public/images/"+jsonResponse['0']['photo_url'];
print(image);
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(image:image, name:name,id:id )),);
 //  Navigator.of(context).pushReplacementNamed('/home');
}
else if(RequestResponse['message']=="error")
{
  showReview(context);
  print("error login");
} 

//use to read file on server
 //print(await http.read('http://example.com/foobar.txt'));

}

//satrtup login

 void  startlogin() async
{
  var url=urldomain.domain+"user_login";
  final response = await http.get(url+"?email="+_name+"&"+"password="+_password+"&"+"login=abc"); 

print('Response status: ${response.statusCode}');
print('Response body: ${response.body}');
var jsonResponse = json.decode(response.body);

var RequestResponse=jsonResponse['response'];

print(RequestResponse['message']);

if (RequestResponse['message']=="success")
{
  var name=jsonResponse['0']['first_name'];
var id = jsonResponse['0']['employee_id'];
print(id);
var image="http://gbc.zeenosofts.com/blog/public/images/"+jsonResponse['0']['photo_url'];
print(image);
  // Navigator.of(context).pushReplacementNamed('/home');

   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(image:image, name:name,id:id )),);
}
else if(RequestResponse['message']=="error")
{
  //showReview(context);
  print("error login");
} 

//use to read file on server
 //print(await http.read('http://example.com/foobar.txt'));

}


 Future getData() async {
    final response =
        await http.get(urldomain.domain+"getdata.php");
        var abc=json.decode(response.body);
        print(abc[0]['Code']);

   // return json.decode(response.body);
  // List userMap = jsonDecode(response.body);
//var user = User.fromJson(userMap);

/* print('Email : ${user.email}!');
print(' And the password is  ${user.password}.'); */

  }
  @override
  
  void initState() {
    // TODO: implement initState
    super.initState();
    //for stop rotattion
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      
    ]);
    //print("alllllllll");
    loadNamePreference().then(updateValue) ;
    loadPasswordPreference().then(updateValue2);
    
    //startlogin();
    //print(_name);
    //print(_password);

   // print("allllldhfjdhfjllll");

  }
  @override
  Widget build(BuildContext context) {
   print(_name);
    print(_password);
    return new Scaffold(
      
      body:
       Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage('assets/office.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: new Column(
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
               Container(
                 padding: EdgeInsets.only(top:0.0),

                   child: Icon(
                     Icons.person,
                     color: Color(0xff00a65a),
                     size: 50.0,
                   ),

               ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "EMAIL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:   Color(0xff00a65a),

                    fontSize: 15.0,
                    ),
                  ),
                      ),
                    ),
                  ],
                  ),
                ),
                new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                  color:    Color(0xff00a65a),

                width: 0.5,
                  style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'username@example.com',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                    ),
                  ],
                ),
                ),

                new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 40.0),
                child: new Text(
                  "PASSWORD",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00a65a),
                    fontSize: 15.0,
                  ),
                ),
                    ),
                  ),
                ],
                ),
                new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                  color: Color(0xff00a65a),
                  width: 0.5,
                  style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                child: TextField(
                  controller: _controller1,
                  obscureText: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '*********',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                    ),
                  ],
                ),
                ),

                new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: new FlatButton(
                child: new Text(
                  "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00a65a),
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.end,
                ),
                onPressed: () => {},
                    ),
                  ),
                ],
                ),
                new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                child: new FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color: Color(0xff00a65a),
                  onPressed: ()  {
                    argName=_controller.text;
                    argPassword=_controller1.text;
                    print("name:"+argName+" Password:"+argPassword);
                    saveNamePreference(argName,argPassword);
                    addData();
                   // getData();
                 //  loadNamePreference().then(updateValue);
                  // loadPasswordPreference().then(updateValue2);
                   // showReview(context);
                  /*  if (response.body=="Success")
{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
                   
} */
                  },
                  child: new Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 20.0,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Expanded(
                          child: Text(
                            "LOGIN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                    ),
                  ],
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  



  }

 void updateValue(String name) {

    setState(() {
      if(name.toString().isNotEmpty ) {
        this._name = name;
        print("yes");
      }
      else
        print('error1');
    });
  }
   void updateValue2(String password) {

    setState(() {
      if(password.toString().isNotEmpty) {
        this._password = password;
        startlogin();
      }
      else
        print('error2');
    });
  }

}


Future<bool> saveNamePreference(String name, String password) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('name', name);
 pref.setString('password', password);
  return true;
}

Future<String> loadNamePreference() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  String name = pref.getString('name');
  return name;
}
Future<String> loadPasswordPreference() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  String password = pref.getString('password');
  return password;
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
                          'Login Failed ',
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