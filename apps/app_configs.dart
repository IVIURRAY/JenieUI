import 'package:flutter/material.dart';
import 'commuter.dart';

List appConfig = [
  App('Commuter', Icon(Icons.train), CommuterApp()),
  App('Commuter', Icon(Icons.train), CommuterApp()),
  App('Commuter', Icon(Icons.train), CommuterApp()),
  // App('Other', Icon(Icons.trending_down), ''),
];

class App {
  String name;
  Icon appIcon;
  var appLandingPage;

  App(this.name, this.appIcon, this.appLandingPage);

}