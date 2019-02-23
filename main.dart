import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Jenie());

class Jenie extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Jenie',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Homepage'),
    );
  }

}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this would produce 2 rows.
          crossAxisCount: 2,
          children: List.generate(5, (index) {
            return Center(               
                child: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CommuterApp()));
                  },
                  icon: Icon(Icons.category),
                  iconSize: 80,
                  tooltip: 'App $index',
                  color: Colors.deepPurple,
              )
            );
          }),
        ),
    );
  }
}

class CommuterApp extends StatefulWidget {
  @override
  CommuterAppState createState() => new CommuterAppState();
}

class CommuterAppState extends State<CommuterApp> {

  List trains = [];

    CommuterAppState(){
      getTrainTimes();
    }

    getTrainTimes() async {
    var response = await http.get(
      Uri.encodeFull("http://127.0.0.1:5000/commuter"),
      headers: {
        "Accept": "application/json"
      }
    );
    print(json.decode(response.body));
    setState(() {
      trains = json.decode(response.body);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Commuter'),
      ),
      body: GridView.count(
        crossAxisCount: 1,
        children: getChildren(),
      )
    );
  }

  getChildren() {
    print('train len ');
    print(trains.length);

    // somehow fix this - train times need to be loaded earlier
    if (trains.length == 0) {
        return List.generate(1, (index) {
        return Center(
          child: Text('No data available...')
          );
      }
    );
  }
    

    return List.generate(trains.length, (index) {
        return Center(
          child: RichText(
              text: TextSpan(
                text: 'Platform ' + trains[index]['platform'],
                style: TextStyle(fontSize: 60, color: Colors.deepPurple),
                children: <TextSpan>[
                  TextSpan(text: '\n' + trains[index]['dest']),
                  TextSpan(text: '\n' + trains[index]['dept']),
                ]
              )
          )
        );
      }
    );
  }
}
