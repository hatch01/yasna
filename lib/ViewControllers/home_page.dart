import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'stagerred_view.dart';
import '../Model/note.dart';
import 'note_page.dart';
import '../Model/utility.dart';

enum ViewType {
  list,
  staggered
}


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  ViewType notesViewType ;
  @override void initState() {
    super.initState();
    notesViewType = ViewType.staggered;
  }

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
          ),

          actions: _appBarActions(),
          elevation: 1,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text("Notes"),
        ),
        body: SafeArea(right: true, left:  true, top: true, bottom: true,child:   _body(),),
        bottomSheet: _bottomBar(),
      );

  }

  Widget _body() {
    if (kDebugMode) {
      print(notesViewType);
    }
    return StaggeredGridPage(notesViewType: notesViewType,);
  }

  //Contains a FlatButton widget that is responsible for calling the _newNoteTapped function to take us to
  //a new page to create a new note
  Widget _bottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          child: const Text(
            "New Note\n",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _newNoteTapped(context),
        )
      ],
    );
  }

/* responsible for creating a new route using the Navigator.push class*/
  void _newNoteTapped(BuildContext ctx) {
    // "-1" id indicates the note is not new
    var emptyNote = Note(-1, "", "", DateTime.now(), DateTime.now(), Colors.white);
    Navigator.push(ctx,MaterialPageRoute(builder: (ctx) => NotePage(emptyNote)));
  }

  //sets the viewType to either grid or list based on the noteViewType value
  void _toggleViewType(){
    setState(() {
      CentralStation.updateNeeded = true;
      if(notesViewType == ViewType.list)
      {
        notesViewType = ViewType.staggered;

      } else {
        notesViewType = ViewType.list;
      }

    });
  }

  List<Widget> _appBarActions() {

    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          child: GestureDetector(
            onTap: () => _toggleViewType() ,
            child: Icon(
              notesViewType == ViewType.list ?  Icons.developer_board : Icons.view_headline,
              color: CentralStation.fontColor,
            ),
          ),
        ),
      ),
    ];
  }


}
