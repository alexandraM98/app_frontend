import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app_frontend/note.dart';
import 'package:http/http.dart' as http;

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes {
    return [..._notes];
  }

  fetchTasks() async {
    final url = 'http://localhost:8000/notes/?format=json';
    final response = await http.get(Uri(path: url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
    }
  }
}
