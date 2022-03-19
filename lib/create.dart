import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CreateNote extends StatefulWidget {
  final Client client;
  const CreateNote({Key? key, required this.client}) : super(key: key);

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: Column(children: [
        TextField(
          controller: controller,
          maxLines: 10,
        ),
        ElevatedButton(
            onPressed: () {
              var url = Uri.parse('http://10.0.2.2:8000/notes/create/');
              widget.client.post(url, body: {'body': controller.text});
              Navigator.pop(context);
            },
            child: Text('Create note:')),
      ]),
    );
  }
}
