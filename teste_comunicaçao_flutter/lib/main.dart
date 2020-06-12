import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
 
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

@override
void initState(){
  super.initState();

  _readData().then((data){
    remedi = json.decode(data);
    List medHr = remedi.values.toList();
    print(remedi.length);
    print(remedi);
    print(medHr[1]);
  });
}

final DBRef = FirebaseDatabase.instance.reference();
final med1 = TextEditingController();

 Map<String, dynamic> remedi = Map();
 
String a;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
            
              height: 60,
              width: 130,
              child: 
            RaisedButton(
              color: Colors.blue,
              onPressed: update,child: Text('on'),),
            ),
            SizedBox(height: 30,),
            Container(
              height: 60,
              width: 130,
              child: 
            RaisedButton(
              color: Colors.blue,
              onPressed: update2,child: Text('off'),),
            ),
            

            RaisedButton(child: Text("ADD"), onPressed:(){remedi["teste"] = "aaa";
            },color: Colors.red,),
            RaisedButton(
              color: Colors.blue,
              onPressed: (){
                _saveData();
              },child: Text('save'),),
          ],
        ),
      ),
    );
  }

void escrever(){
  DBRef.child("LED").set({
    'valor':'teste'
  });
}

  void update(){
DBRef.child("LED").update({
  'LED':'ON'
});
  }
    void update2(){
DBRef.child("LED").update({
  'LED':'OFF'
});
  }
Future<File> _getFile() async{
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }
  Future<File> _saveData()async {
    String data = json.encode(remedi);
    final file =  await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async{
    try{
      final file = await _getFile();
      return file.readAsString();
    }catch(e){
      return null;
    }
  }
  

}



