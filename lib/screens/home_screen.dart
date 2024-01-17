import 'package:flutter/material.dart';
import 'package:noteapputs/models/Note.dart';
import 'package:noteapputs/models/NoteOperation.dart';
import 'package:noteapputs/screens/add_screen.dart';
import 'package:noteapputs/screens/edit_screen.dart';
import 'package:noteapputs/widget/note_card.dart';
import 'package:noteapputs/widget/note_tile.dart';
import 'package:provider/provider.dart';
import 'package:noteapputs/app_style.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLayout = false;

  void _toggleLayout() {
    setState(() {
      isLayout = !isLayout;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<NoteOperation>(context, listen: false).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddScreen()));
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: AppStyle.maincolor,
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "MY NOTES",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    wordSpacing: 2,
                    letterSpacing: 2),
              ),
              GestureDetector(
                onTap: _toggleLayout,
                child: Icon(
                  isLayout ? Icons.list_alt_outlined : Icons.grid_view_rounded,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<NoteOperation>(
        builder: (context, NoteOperation data, child) {
          if (data.getNotes.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/image_nothing.png",
                    width: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Nothing is Here",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF4D5270),
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            );
          } else {
            return isLayout
                ? Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: data.getNotes.length,
                      itemBuilder: (context, index) {
                        return NotesCard(data.getNotes[index]);
                      },
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: data.getNotes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return NoteTie(data.getNotes[index]);
                      },
                    ),
                  );
          }
        },
      ),
    );
  }
}
