import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_note/activities/add_note.dart';
import 'package:platform_device_id/platform_device_id.dart';

class GetMyNotes {

  final  String collection;

  GetMyNotes({ required this.collection });

  final db = FirebaseFirestore.instance;

  Widget get allNotes{
    return Padding(
      padding: const EdgeInsets.only(left: 10 , right: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: db.collection(collection).orderBy("range",descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
              children: snapshot.data!.docs.map((doc) {
                return GestureDetector(
                  onTap: () =>  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => AddNote(
                            identify: 'view',
                            documentId: doc.reference.id,
                            title: doc.get('title'),
                            content: doc.get('content')))),
                  },
                  child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 200,
                            height: 15,
                            child: const DecoratedBox(
                              decoration: const BoxDecoration(
                                  color: Colors.yellow
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 125,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.ideographic,
                                      children: [
                                        Text(doc.get('title'),maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold),),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 3),
                                          child: Text(doc.get('content'), overflow: TextOverflow.ellipsis, maxLines: 5,),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text('Created date: '+ doc.get('date'), overflow: TextOverflow.ellipsis, maxLines: 1,
                                          style: TextStyle(fontSize: 12 , color: Colors.grey)),
                                      ),)
                                  ],
                                )
                            ),
                          ),
                        ],
                      )
                  ),
                );
              }).toList(),
            );
        },
      ),
    );

  }

}