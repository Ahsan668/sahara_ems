import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as Path;
class DataController extends GetxController{


  FirebaseAuth auth = FirebaseAuth.instance;

  DocumentSnapshot? myDocument;



  var allUsers  = <DocumentSnapshot>[].obs;
  var filteredUsers = <DocumentSnapshot>[].obs;
  var allEvents = <DocumentSnapshot>[].obs;
  var filteredEvents = <DocumentSnapshot>[].obs;
  var joinedEvents = <DocumentSnapshot>[].obs;

  var isEventsLoading = false.obs;


  var isMessageSending = false.obs;
  sendMessageToFirebase({
    Map<String,dynamic>? data,
    String? lastMessage,
    String? grouid
  })async{

   isMessageSending(true);

    await FirebaseFirestore.instance.collection('chats').doc(grouid).collection('chatroom').add(data!);
    await FirebaseFirestore.instance.collection('chats').doc(grouid).set({
      'lastMessage': lastMessage,
      'groupId': grouid,
      'group': grouid!.split('-'),
    },SetOptions(merge: true));

    isMessageSending(false);

  }


  createNotification(String recUid){
    FirebaseFirestore.instance.collection('notifications').doc(recUid).collection('myNotifications').add({
      'message': "Send you a message.",
      'image': myDocument!.get('image'),
      'name': myDocument!.get('first')+ " "+ myDocument!.get('last'),
      'time': DateTime.now()
    });
  }

  getMyDocument(){
    FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid)
        .snapshots().listen((event) {
          myDocument = event;
    });
  }

 Future<String> uploadImageToFirebase(File file)async{
    String fileUrl = '';
    String fileName = Path.basename(file.path);
    var reference = FirebaseStorage.instance.ref().child('myfiles/$fileName');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      fileUrl = value;
    });
    print("Url $fileUrl");
    return fileUrl;
  }

 Future<String> uploadThumbnailToFirebase(Uint8List file)async{
   String fileUrl = '';
   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
   var reference = FirebaseStorage.instance.ref().child('myfiles/$fileName.jpg');
   UploadTask uploadTask = reference.putData(file);
   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
   await taskSnapshot.ref.getDownloadURL().then((value) {
     fileUrl = value;
   });


   print("Thumbnail $fileUrl");

   return fileUrl;
 }

 Future<bool> createEvent(Map<String,dynamic> eventData)async{
   bool isCompleted = false;

   await FirebaseFirestore.instance.collection('events')
   .add(eventData)
   .then((value) {
     isCompleted = true;
     Get.snackbar('Event Uploaded', 'Event is uploaded successfully.',
         colorText: Colors.white,backgroundColor: Colors.blue);
   }).catchError((e){
     isCompleted = false;
   });


   return isCompleted;
 }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyDocument();
    getUsers();
    getEvents();
  }


  var isUsersLoading = false.obs;

  getUsers(){
    isUsersLoading(true);
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      allUsers.value = event.docs;
      filteredUsers.value.assignAll(allUsers);
      isUsersLoading(false);
     });
  }


  getEvents(){
    isEventsLoading(true);

    FirebaseFirestore.instance.collection('events').snapshots().listen((event) {
      allEvents.assignAll(event.docs);
      filteredEvents.assignAll(event.docs);


    joinedEvents.value =   allEvents.where((e){
        List joinedIds = e.get('joined');

        return joinedIds.contains(FirebaseAuth.instance.currentUser!.uid);

      }).toList();





      isEventsLoading(false);
     });


  }

  Future<String> getCurrentUserName() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    // Assuming the user's first and last names are stored as 'first' and 'last' in the Firestore document.
    String firstName = userDoc.get('first');
    String lastName = userDoc.get('last');

    return "$firstName $lastName";
  }
  Future<void> addCommentToEvent(String eventId, String comment) async {
    String userName = await getCurrentUserName(); // Fetching user's name
    await FirebaseFirestore.instance.collection('events').doc(eventId).collection('comments').add({
      'text': comment,
      'userName': userName, // Storing user's name instead of UID
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // addCommentToEvent(String eventId, String comment) async {
  //   String userName = await getCurrentUserName();
  //   await FirebaseFirestore.instance.collection('events').doc(eventId).collection('comments').add({
  //     'text': comment,
  //     'userName': userName,
  //     'timestamp': FieldValue.serverTimestamp(),
  //   });
  // }








}