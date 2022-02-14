import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Github Search"),
      ),
      body: Column(children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Type your search...",
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(itemBuilder: (_, id) {
            // ListView is Scrollable and so needs size. But i do not know the size, so I use expanded.
            return const ListTile();
          }),
        ),
      ]),
    );
  }
}
