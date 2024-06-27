import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CommentsScreen extends StatefulWidget {
  final String eventId; // Assuming each event has a unique ID

  CommentsScreen( this.eventId);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController _commentController = TextEditingController();
  late String _localEventId;

  @override
  void initState() {
    super.initState();
    _localEventId = widget.eventId; // Assigning value here
  }
  CollectionReference commentsRef = FirebaseFirestore.instance.collection('events').doc("_localEventId").collection('comments');

  Future<void> _addComment() async {
    if (_commentController.text.trim().isNotEmpty) {
      await commentsRef.add({
        'text': _commentController.text,
        'user': FirebaseAuth.instance.currentUser!.uid, // Assuming you want to save the user's UID
        'timestamp': DateTime.now(),
      });
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          backgroundColor: Colors.white,
          title: Text("Comments",
          style: TextStyle(
            color: Colors.black,
          ),
          )),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: commentsRef.orderBy('timestamp', descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error fetching comments'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final comment = snapshot.data!.docs[index];
                    final commentTime = DateFormat('hh:mm a').format(comment['timestamp'].toDate());

                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance.collection('users').doc(comment['user']).get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                          final userDoc = snapshot.data!;
                          final userName = "${userDoc['first']} ${userDoc['last']}";
                          return ListTile(
                            title: Text(comment['text']),
                            subtitle: Text('By $userName at $commentTime'),
                          );
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return ListTile(
                            title: Text(comment['text']),
                            subtitle: Text('Loading name...'),
                          );
                        } else {
                          return ListTile(
                            title: Text(comment['text']),
                            subtitle: Text('Failed to load name'),
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(hintText: 'Enter your comment...',),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
