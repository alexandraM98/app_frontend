import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateNote extends StatefulWidget {
  final Client client;
  final int id;
  final String body;
  const UpdateNote(
      {Key? key, required this.client, required this.id, required this.body})
      : super(key: key);

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.body;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: Column(children: [
        TextField(
          controller: controller,
          maxLines: 10,
        ),
        ElevatedButton(
            onPressed: () {
              var url =
                  Uri.parse('http://10.0.2.2:8000/notes/${widget.id}/update/');
              widget.client.put(url, body: {'body': controller.text});
              Navigator.pop(context);
            },
            child: Text('Update note!')),
        ElevatedButton(onPressed: () {}, child: Text('Calendar Page')),
      ]),
    );
  }
}
