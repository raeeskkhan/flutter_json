import 'package:flutter/material.dart';
import 'json_parsing_map.dart';
import 'parsing_json/json_parsing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JSON PARSING",
      debugShowCheckedModeBanner: false,
      home: JsonParsingMap(),
    );
  }
}
