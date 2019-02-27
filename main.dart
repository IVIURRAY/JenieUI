import 'package:flutter/material.dart';
import 'apps/app_configs.dart';

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
          crossAxisCount: 3,
          children: List.generate(appConfig.length, (index) {
            return Center(   
              child: Card( 
                elevation: 5,
                
                // color: Colors.,
                // margin: EdgeInsets.all(10),           
                child: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => appConfig[index].appLandingPage));
                  },
                  icon: appConfig[index].appIcon,
                  iconSize: 80,
                  // tooltip: 'App $index',
                  color: Colors.deepPurple,
              )
              )
            );
          }),
        ),
    );
  }
}

