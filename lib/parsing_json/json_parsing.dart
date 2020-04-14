import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonParingSimple extends StatefulWidget {
  @override
  _JsonParingSimpleState createState() => _JsonParingSimpleState();
}

class _JsonParingSimpleState extends State<JsonParingSimple> {
  //Call call fetch data so whatever is returned is stored in data
  Future data;

  @override
  void initState() {
    super.initState();

    //Gets the data upon initialization
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PARSING JSON"),
      ),
      body: Center(
        child: Container(
          //FutureBuilder helps with dealing with Futures
          child: FutureBuilder(
              //Needs to know where to get the data from
              //Future expects a future type and getData() is of a Future Type
              future: getData(),
              //builder: Have to pass the context of the app and data
              //snapshot is being received from getData(), done in the backend
              //AsyncSnapshot is a type of snapshot
              //AsyncSnapshot<dynamic> is to get lose ended/generic type
              builder: (context, AsyncSnapshot snapshot) {
                //Aways use if else to check for data when using AsyncSnapshot
                // and FutureBuilder
                //Check if snapshot has data FIRST
                if (snapshot.hasData) {
                  //snapshot.data is the data part from the snapshot
                  //the data is off a dynamic type meaning that it could
                  //be anything, i.e. Maps, Lists, etc.
                  return createListView(snapshot.data, context);
                  //return Text(snapshot.data[0]['id'].toString());
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  //COVID-19: "https://covid19api.herokuapp.com/confirmed";

  Future getData() async {
    Future data;
    String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);

    data = network.fetchData();

    //Will do all the work in the background to resolve our future
//    data.then((value) {
//      print(value);
//    });

    return data;
  }

  //Data is a List Type because the data received is of a type List
  //Best to explicitly state the type of Data
  Widget createListView(List data, BuildContext context) {
    return Container(
      child: ListView.builder(
          //We must state the number of items
          itemCount: data.length,
          itemBuilder: (context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Divider(
                  height: 5.0,
                ),
                ListTile(
                  title: Text("${data[index]["title"]}"),
                  subtitle: Text("${data[index]["body"]}"),
                  leading: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.black26,
                        radius: 23,
                        child: Text("${data[index]["id"]}"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class Network {
  //Creating Network Class
  final String url;

  Network(this.url);

  //Method: Fetch the JSON, Decode it so it can be Parsed
  Future fetchData() async {
    print(url);

    //Create a response,  we request then we get a response
    //Async and await go together
    //Uri.encodeFull is to avoid potential errors
    Response response = await get(Uri.encodeFull(url));

    //Status Code of 200 means everything is okay
    if (response.statusCode == 200) {
      //OK
      //response.body: We want the body of the JSON Only
      //print(response.body);
      //json.decode: take the String (response.body) and turn it into a JSON to be able to be parsed
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}

/**
 * Instance of 'Future<dynamic>': Common Error
 *
 * We cannot just print(data) because data is a of a future type
 * We have to wait to make sure the data is ready. It has been received
 *
 * **/

/** TO AVOID POTENTIAL TYPING MISTAKES, BEST TO USE PODO: PLAIN OLD DART OBJECT
 * We have to Map a field to the JSON Object(i.e. to the titles in the JSON)
 **/
