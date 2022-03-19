// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:app_frontend/create.dart';
import 'package:app_frontend/note.dart';
import 'package:app_frontend/update.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Django Frontend',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Django Frontend'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Note> notes = [];

  @override
  void initState() {
    _retrieveNotes();
    super.initState();
  }

  void _retrieveNotes() async {
    notes = [];

    http.Response response =
        await client.get(Uri.parse('http://10.0.2.2:8000/notes'));

    List jsonData = json.decode(response.body);

    jsonData.forEach((element) {
      notes.add(Note.fromMap(element));
    });
    //print(notes);
    setState(() {});
  }

  void _deleteNote(int id) {
    var url = Uri.parse('http://10.0.2.2:8000/notes/$id/delete/');
    client.delete(url);
    _retrieveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retrieveNotes();
        },
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(notes[index].body),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UpdateNote(
                          client: client,
                          body: notes[index].body,
                          id: notes[index].id,
                        )));
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _deleteNote(notes[index].id);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreateNote(
                  client: client,
                ))),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
