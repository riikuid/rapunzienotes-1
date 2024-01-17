import 'package:flutter/material.dart';
import 'package:noteapputs/models/Note.dart';
import 'package:noteapputs/models/NoteOperation.dart';
import 'package:noteapputs/screens/add_screen.dart';
import 'package:noteapputs/screens/edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:noteapputs/app_style.dart';

class NoteTie extends StatefulWidget {
  final Note note;

  NoteTie(this.note);

  @override
  State<NoteTie> createState() => _NoteTieState();
}

class _NoteTieState extends State<NoteTie> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteOperation>(context, listen: false).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        final note = Provider.of<NoteOperation>(context, listen: false);
        setState(() {
          note.removeNote(widget.note.id);
        });
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditScreen(note: widget.note)),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppStyle.cardsColor[widget.note.color_id],
              borderRadius: BorderRadius.circular(15)),
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 30, 20, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.note.title,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppStyle.maincolor),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.note.description,
                    style: TextStyle(
                        fontSize: 16, color: AppStyle.maincolor, height: 1.5),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.note.createdTime,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
