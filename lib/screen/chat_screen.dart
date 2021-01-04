import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection('chats/LjL8bfm2wng8lPZiwm6m/messages')
          .snapshots(),
        builder: (ctx, streamSnapshot) {
          if( streamSnapshot.connectionState == ConnectionState.waiting ) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.documents;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) =>
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text( documents[index]['text'] ),
                ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.
          instance.
          collection('chats/LjL8bfm2wng8lPZiwm6m/messages').
          add({
            'text': 'This is added by clicking plus button.',
          });
        },
      ),
    );
  }
}
