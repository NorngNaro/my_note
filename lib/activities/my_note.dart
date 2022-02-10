import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_note/activities/add_note.dart';
import 'package:my_note/api/get/get_my_notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_note/api/get/get_search_note.dart';
import 'package:platform_device_id/platform_device_id.dart';

class MyNotes extends StatefulWidget{

  @override
  State<MyNotes> createState() => _MyNotesState();

}

class _MyNotesState extends State<MyNotes> {
  var txt_search_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/background.jpg',fit: BoxFit.cover, height: double.infinity, width: double.infinity,),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,top: 20),
                    child: Text('My Notes',textAlign: TextAlign.left ,style: TextStyle(color: Colors.black,fontSize: 34,fontWeight: FontWeight.bold),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 10),
                  child: CupertinoSearchTextField(
                    autofocus: false,
                    onChanged: (String value){
                      setState(() {
                        txt_search_controller.text = value;
                        txt_search_controller.selection = TextSelection(
                            baseOffset: value.length,
                            extentOffset: value.length);
                      });
                    },
                    controller: txt_search_controller,

                  ),
                ),

                if(txt_search_controller.text == '')
                  Expanded(
                    child: GetMyNotes(collection: '0d6989cdc86f3699').allNotes,
                  ),
                if(txt_search_controller.text != '')
                  Expanded(
                    child: GetSearchNote(collection: '0d6989cdc86f3699', search: txt_search_controller.text).searchNote,
                  )
              ],
            ),

          ),
        ],
      ),

      floatingActionButton : new FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AddNote(identify: 'add',documentId: '',title: '',content: '',)));
        },
        backgroundColor: Colors.yellow.shade600,
        child: const Icon(Icons.add),
      ),
    );
  }
}