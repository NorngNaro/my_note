import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_note/api/create/add_note.dart';
import 'package:my_note/api/delete/delete_note.dart';
import 'package:my_note/api/update/update_note.dart';

class AddNote extends StatelessWidget{

  final  String identify;
  final String documentId;
  final String title;
  final String content;

  AddNote({ required this.identify,  required this.documentId,  required this.title,  required this.content});




  @override
  Widget build(BuildContext context) {
    final txt_title_controller = TextEditingController(text: title);
    final txt_content_controller = TextEditingController(text: content);

    void _back(){
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        SystemNavigator.pop();
      }
    }

    Future<void> _onWillPop() async {
      if(identify == 'add'){
        if(txt_title_controller.text != ""  || txt_content_controller.text != ""){
          CreateNote().addUser(txt_title_controller.text, txt_content_controller.text).then((value) =>{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Note saved."),
            )),
          });
          _back();
        }else{
          _back();
        }
      }else{
        if(txt_title_controller.text != title  || txt_content_controller.text != content){
          if(txt_title_controller.text == '' && txt_content_controller.text == '' ){
            DeleteNote().deleteNote(documentId).then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Note deleted."),
              )),
            _back(),
            });
          }else{
            UpdateNote().updateNote(documentId ,txt_title_controller.text, txt_content_controller.text).then((value) =>{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Note updated."),
              )),
            _back(),
            });
          }

        }else{
         _back();
        }
      }
    }

    return Scaffold(
        backgroundColor: Colors.orange.shade100,
        body: Stack(
          children: [
            Image.asset('assets/background.jpg',fit: BoxFit.cover, height: double.infinity, width: double.infinity,),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 10,right: 20),
                    child: Row(
                      children: [
                        IconButton(icon: Icon(Icons.arrow_back_ios),
                            onPressed: (){
                              print(identify);
                              _onWillPop();
                            }),
                        Text('My Notes',style: TextStyle(fontSize: 20),),
                        Spacer(flex: 1,),
                        if(identify != 'add')
                          IconButton(icon: Icon(Icons.delete),
                              onPressed: () async {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Delete!'),
                                      content: const Text('Do you want to delete this note?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                          child: const Text('NO'),
                                        ),
                                        TextButton(
                                          onPressed: () => {
                                            DeleteNote().deleteNote(documentId).then((value) => {
                                              Navigator.pop(context, 'OK'),
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: Text("Note deleted."),
                                              )),
                                              if (Navigator.canPop(context)) {
                                                Navigator.pop(context),
                                              } else {
                                                SystemNavigator.pop(),
                                              }
                                            })
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    )
                                );
                              }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    child: TextField(
                      controller: txt_title_controller,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(hintText: "Add Title",),
                      scrollPadding: EdgeInsets.all(20.0),
                      autofocus: false,
                    ),
                  ),
                  Expanded(child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: TextField(
                        controller: txt_content_controller,
                        decoration: InputDecoration(hintText: "Add Note",),
                        scrollPadding: EdgeInsets.all(20.0),
                        maxLines: 99999,
                        keyboardType: TextInputType.multiline,
                        autofocus: false,
                      )
                  ),)
                ],
              ),
            ),
          ],
        )
    );

  }
}
