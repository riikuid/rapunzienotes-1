import 'package:flutter/material.dart';
import 'package:noteapputs/models/NoteOperation.dart';
import 'package:provider/provider.dart';
import 'package:noteapputs/app_style.dart';
import 'dart:math';

class AddScreen extends StatelessWidget {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  @override
  Widget build(BuildContext context) {
    late String titleText;
    late String descriptionText;
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "CREATE NOTE",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              fontSize: 16,
              wordSpacing: 2,
              letterSpacing: 2),
        ),
        iconTheme: IconThemeData(color: Colors.black54),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
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
              onChanged: (value) {
                titleText = value;
              },
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
                onChanged: (value) {
                  descriptionText = value;
                },
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
                    onTap: () {
                      Provider.of<NoteOperation>(context, listen: false)
                          .addNewNote(titleText, descriptionText, color_id);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'SAVE NOTE',
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
