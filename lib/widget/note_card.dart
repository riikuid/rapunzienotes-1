import 'package:flutter/material.dart';
import 'package:noteapputs/models/Note.dart';
import 'package:noteapputs/models/NoteOperation.dart';
import 'package:noteapputs/screens/add_screen.dart';
import 'package:noteapputs/screens/edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:noteapputs/app_style.dart';

class NotesCard extends StatefulWidget {
  final Note note;

  NotesCard(this.note);

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
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
        margin: const EdgeInsets.symmetric(vertical: 17),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditScreen(note: widget.note)),
          );
        },
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: AppStyle.cardsColor[widget.note.color_id],
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            // padding: const EdgeInsets.fromLTRB(20.0, 30, 20, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.note.title.isNotEmpty
                        ? Text(
                            widget.note.title,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppStyle.maincolor),
                            maxLines: 2,
                          )
                        : const SizedBox(),
                  ],
                ),
                widget.note.description.isNotEmpty
                    ? Text(
                        widget.note.description,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppStyle.maincolor,
                            height: 1.5),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const SizedBox(),
                const SizedBox(height: 10),
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
    );
  }
}
