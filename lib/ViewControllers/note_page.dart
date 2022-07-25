// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Model/note.dart';
import '../Model/sqlite_handler.dart';
import 'dart:async';
import '../Model/utility.dart';
import '../Views/more_options_sheet.dart';
import 'package:share/share.dart';

class NotePage extends StatefulWidget {
  final Note noteInEditing;

  //constructor that takes a Note object
  NotePage(this.noteInEditing, {Key key}) : super(key: key) {
    // TODO: implement
    throw UnimplementedError();
  }

  @override
  NotePageState createState() => NotePageState();
}

class NotePageState extends State<NotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  Color note_color;
  bool _isNewNote = false;
  final _titleFocus = FocusNode();
  final _contentFocus = FocusNode();

  String _titleFrominitial;

  String _contentFromInitial;
  DateTime _lastEditedForUndo;

  Note _editableNote;

  // the timer variable responsible to call persistData function every 5 seconds and cancel the timer when the page pops.
  Timer _persistenceTimer;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _editableNote = widget.noteInEditing;
    _titleController.text = _editableNote.title;
    _contentController.text = _editableNote.content;
    note_color = _editableNote.note_color;
    _lastEditedForUndo = widget.noteInEditing.date_last_edited;

    _titleFrominitial = widget.noteInEditing.title;
    _contentFromInitial = widget.noteInEditing.content;

    if (widget.noteInEditing.id == -1) {
      _isNewNote = true;
    }
    _persistenceTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      // call insert query here
      if (kDebugMode) {
        print("5 seconds passed");
        print("editable note id: ${_editableNote.id}");
      }
      _persistData();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_editableNote.id == -1 && _editableNote.title.isEmpty) {
      FocusScope.of(context).requestFocus(_titleFocus);
    }

    return WillPopScope(
      onWillPop: _readyToPop,
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
          ),
          leading: const BackButton(
            color: Colors.black,
          ),
          actions: _archiveAction(context),
          elevation: 1,
          backgroundColor: note_color,
          title: _pageTitle(),
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext ctx) {
    return Container(
        color: note_color,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
        child: SafeArea(
          left: true,
          right: true,
          top: false,
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(5),
//          decoration: BoxDecoration(border: Border.all(color: CentralStation.borderColor,width: 1 ),borderRadius: BorderRadius.all(Radius.circular(10)) ),
                  child: EditableText(
                      onChanged: (str) => {updateNoteObject()},
                      maxLines: null,
                      controller: _titleController,
                      focusNode: _titleFocus,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      cursorColor: Colors.blue,
                      backgroundCursorColor: Colors.blue),
                ),
              ),
              const Divider(
                color: CentralStation.borderColor,
              ),
              Flexible(
                  child: Container(
                      padding: const EdgeInsets.all(5),
//    decoration: BoxDecoration(border: Border.all(color: CentralStation.borderColor,width: 1),borderRadius: BorderRadius.all(Radius.circular(10)) ),
                      child: EditableText(
                        onChanged: (str) => {updateNoteObject()},
                        maxLines: 300,
                        // line limit extendable later
                        controller: _contentController,
                        focusNode: _contentFocus,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        backgroundCursorColor: Colors.red,
                        cursorColor: Colors.blue,
                      )))
            ],
          ),
        ));
  }

  //returns a new text with "New Note" or "Edit Note" based on the value of _editableNote.id
  Widget _pageTitle() {
    return Text(_editableNote.id == -1 ? "New Note" : "Edit Note");
  }

  List<Widget> _archiveAction(BuildContext context) {
    List<Widget> actions = [];
    if (widget.noteInEditing.id != -1) {
      actions.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          child: GestureDetector(
            onTap: () => _undo(),
            child: const Icon(
              Icons.undo,
              color: CentralStation.fontColor,
            ),
          ),
        ),
      ));
    }
    actions += [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          child: GestureDetector(
            onTap: () => _archivePopup(context),
            child: const Icon(
              Icons.archive,
              color: CentralStation.fontColor,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          child: GestureDetector(
            onTap: () => bottomSheet(context),
            child: const Icon(
              Icons.more_vert,
              color: CentralStation.fontColor,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          child: GestureDetector(
            onTap: () => {_saveAndStartNewNote(context)},
            child: const Icon(
              Icons.add,
              color: CentralStation.fontColor,
            ),
          ),
        ),
      )
    ];
    return actions;
  }

  //responsible for opening the moreOptionsSheet Class and its widgets
  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return MoreOptionsSheet(
            color: note_color,
            callBackColorTapped: _changeColor,
            callBackOptionTapped: bottomSheetOptionTappedHandler,
            date_last_edited: _editableNote.date_last_edited,
          );
        });
  }

  //saves data as the user makes changes and saves and updates this value whenever it changes
  void _persistData() {
    updateNoteObject();

    if (_editableNote.content.isNotEmpty) {
      var noteDB = NotesDBHandler();

      if (_editableNote.id == -1) {
        Future<int> autoIncrementedId =
            noteDB.insertNote(_editableNote, true); // for new note
        // set the id of the note from the database after inserting the new note so for next persisting
        autoIncrementedId.then((value) {
          _editableNote.id = value;
        });
      } else {
        noteDB.insertNote(
            _editableNote, false); // for updating the existing note
      }
    }
  }

// this function will ne used to save the updated editing value of the note to the local variables as user types
  void updateNoteObject() {
    _editableNote.content = _contentController.text;
    _editableNote.title = _titleController.text;
    _editableNote.note_color = note_color;
    if (kDebugMode) {
      print("new content: ${_editableNote.content}");
      print(widget.noteInEditing);
      print(_editableNote);
      print("same title? ${_editableNote.title == _titleFrominitial}");
      print("same content? ${_editableNote.content == _contentFromInitial}");
    }

    if (!(_editableNote.title == _titleFrominitial &&
            _editableNote.content == _contentFromInitial) ||
        (_isNewNote)) {
      // No changes to the note
      // Change last edit time only if the content of the note is mutated in compare to the note which the page was called with.
      _editableNote.date_last_edited = DateTime.now();
      if (kDebugMode) {
        print("Updating date_last_edited");
      }
      CentralStation.updateNeeded = true;
    }
  }

  //Handles callbacks on the MoreOptionsSheet
  void bottomSheetOptionTappedHandler(MoreOptions tappedOption) {
    if (kDebugMode) {
      print("option tapped: $tappedOption");
    }
    switch (tappedOption) {
      case MoreOptions.delete:
        {
          if (_editableNote.id != -1) {
            _deleteNote(_globalKey.currentContext);
          } else {
            _exitWithoutSaving(context);
          }
          break;
        }
      case MoreOptions.share:
        {
          if (_editableNote.content.isNotEmpty) {
            Share.share("${_editableNote.title}\n${_editableNote.content}");
          }
          break;
        }
      case MoreOptions.copy:
        {
          _copy();
          break;
        }
    }
  }

  //deletes a saved note from the database when the user selects delete from the bottom sheet
  void _deleteNote(BuildContext context) {
    if (_editableNote.id != -1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm ?"),
              content: const Text("This note will be deleted permanently"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      _persistenceTimer.cancel();
                      var noteDB = NotesDBHandler();
                      Navigator.of(context).pop();
                      noteDB.deleteNote(_editableNote);
                      CentralStation.updateNeeded = true;

                      Navigator.of(context).pop();
                    },
                    child: const Text("Yes")),
                TextButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    child: const Text("No"))
              ],
            );
          });
    }
  }

  //responsible for responding whenever the user selects on a color by changing the color and saving the color
  //value to the database
  void _changeColor(Color newColorSelected) {
    if (kDebugMode) {
      print("note color changed");
    }
    setState(() {
      note_color = newColorSelected;
      _editableNote.note_color = newColorSelected;
    });
    if (_editableNote.id != -1) {
      var noteDB = NotesDBHandler();
      _editableNote.note_color = note_color;
      noteDB.insertNote(_editableNote, false);
    }
    CentralStation.updateNeeded = true;
  }

  //this function is called whenever the user clicks on the plus icon to add a new note from
  //an already existing note.
  void _saveAndStartNewNote(BuildContext context) {
    _persistenceTimer.cancel();
    var emptyNote =
        Note(-1, "", "", DateTime.now(), DateTime.now(), Colors.white);
    Navigator.of(context).pop();
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => NotePage(emptyNote)));
  }

  Future<bool> _readyToPop() async {
    _persistenceTimer.cancel();
    //show saved toast after calling _persistData function.

    _persistData();
    return true;
  }

  //build a pop up for whenever a user clicks on the archive icon,
  // this prompt asks the user if he is sure before proceeding to archive the note

  void _archivePopup(BuildContext context) {
    if (_editableNote.id != -1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm ?"),
              content: const Text("This note will be archived"),
              actions: <Widget>[
                TextButton(
                    onPressed: () => _archiveThisNote(context),
                    child: const Text("Yes")),
                TextButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    child: const Text("No"))
              ],
            );
          });
    } else {
      _exitWithoutSaving(context);
    }
  }

  //this function is called whenever a user clicks on a new note but no value is entered
  void _exitWithoutSaving(BuildContext context) {
    _persistenceTimer.cancel();
    CentralStation.updateNeeded = false;
    Navigator.of(context).pop();
  }

  //responsible for archiving the note
  void _archiveThisNote(BuildContext context) {
    Navigator.of(context).pop();
    // set archived flag to true and send the entire note object in the database to be updated
    _editableNote.is_archived = 1;
    var noteDB = NotesDBHandler();
    noteDB.archiveNote(_editableNote);
    // update will be required to remove the archived note from the staggered view
    CentralStation.updateNeeded = true;
    _persistenceTimer.cancel(); // shutdown the timer

    Navigator.of(context).pop(); // pop back to staggered view
    // TODO: OPTIONAL show the toast of deletion completion

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("deleted")));
  }

  //this function duplicates a note with the selected id whenever
  //copy is tapped on from the bottom sheet
  void _copy() {
    var noteDB = NotesDBHandler();
    Note copy = Note(-1, _editableNote.title, _editableNote.content,
        DateTime.now(), DateTime.now(), _editableNote.note_color);

    var status = noteDB.copyNote(copy);
    status.then((querySuccess) {
      if (querySuccess) {
        CentralStation.updateNeeded = true;
        Navigator.of(_globalKey.currentContext).pop();
      }
    });
  }

//undo changes made to the text using FLutter's TextController method
  void _undo() {
    _titleController.text = _titleFrominitial; // widget.noteInEditing.title;
    _contentController.text =
        _contentFromInitial; // widget.noteInEditing.content;
    _editableNote.date_last_edited =
        _lastEditedForUndo; // widget.noteInEditing.date_last_edited;
  }
}
