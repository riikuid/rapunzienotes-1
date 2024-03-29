import 'package:flutter/material.dart';
import 'package:noteapputs/app_style.dart';
import 'package:noteapputs/models/Note.dart';
import 'package:noteapputs/models/NoteOperation.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final Note note;

  EditScreen({required this.note});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool isLoading = false;
  late TextEditingController _descriptionController;
  late TextEditingController _titleController;
  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.note.description);
    _titleController = TextEditingController(text: widget.note.title);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NoteOperation noteOperation = Provider.of<NoteOperation>(context);

    handleSave() async {
      setState(() {
        isLoading = true;
      });
      await noteOperation.editNote(
          widget.note.id, _titleController.text, _descriptionController.text);
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[widget.note.color_id],
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          "EDIT NOTE",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              fontSize: 16,
              letterSpacing: 2,
              wordSpacing: 2),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Title',
                hintStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppStyle.maincolor,
              ),
              controller: _titleController,
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Description',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: AppStyle.maincolor,
                ),
                controller: _descriptionController,
              ),
            ),
            SizedBox(
              height: 50,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Center(
                  child: GestureDetector(
                    onTap: handleSave,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'UPDATE NOTE',
                            style: TextStyle(
                                color: Colors.black87,
                                wordSpacing: 2,
                                letterSpacing: 2),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
