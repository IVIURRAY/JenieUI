import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CommuterApp extends StatefulWidget {
  @override
  CommuterAppState createState() => new CommuterAppState();
}

class CommuterAppState extends State<CommuterApp> {

  List trains = [];

    @override
    void initState(){
      super.initState();
      getTrainTimes();
    }

    getTrainTimes() async {
      try {
        var response = await http.get(
        Uri.encodeFull("http://127.0.0.1:5000/commuter"),
          headers: {
            "Accept": "application/json"
          }
        );
        print(json.decode(response.body));
        trains = json.decode(response.body);
      } catch (e) {
        debugPrint('Unable to connect to API!!!');
        trains = [];
      }

      setState(() {
        this.trains = trains;
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
        children: displayTrains(),
        childAspectRatio: this.trains.isEmpty ? 1:2,
      )
    );
  }

  displayTrains() {
    if (trains.isEmpty) {
        return displayNoTrains(); 
    } else {
      return displayTrainData();
    }
  }

  List<Widget> displayTrainData() {
    print(trains);
    return List.generate(trains.length, (index) {
        return Container(
          child: Card(
          elevation: 10,
          margin: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Container(  
                padding: EdgeInsets.all(5),
                child: FloatingActionButton(
                  onPressed: null,
                  child: trains[index]['platform'] != '' ? Text(trains[index]['platform'], style: TextStyle(fontSize: 30),) : Icon(Icons.train)
                )
              ),
              Container(
                child: Text('Departure: ' + trains[index]['dept'], style: TextStyle(fontSize: 30)),
              )
            ],
          )
        )
        );
      });
      }

  List<Widget> displayNoTrains(){
    return List.generate(1, (index) {
        return Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text(
                'No data loaded...',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              new RaisedButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(90.0)),
                padding: const EdgeInsets.all(10.0),
                textColor: Colors.white,
                color: Colors.deepPurple,
                onPressed: getTrainTimes,
                child: Icon(Icons.refresh, size: 150,),
              ),
            ],
          ),
        );
      });   
  } 

}

