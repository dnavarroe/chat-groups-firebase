import 'package:chat_firebase/pages/pages.dart';
import 'package:chat_firebase/services/services.dart';
import 'package:chat_firebase/utils/responsive.dart';
import 'package:chat_firebase/widgets/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String username;
  const ChatPage(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.username})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = '';

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin(){
    DatabaseService(FirebaseAuth.instance.currentUser!.uid).getChats(widget.groupId).then((val){
      setState(() {
        chats = val;
      });
    });
    DatabaseService(FirebaseAuth.instance.currentUser!.uid).getGroupAdmin(widget.groupId).then((value) {
      setState(() {
        admin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(widget.groupName),
        backgroundColor: const Color(0xff10c6b1),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => GroupInfo(
                    groupId: widget.groupId,
                    groupName: widget.groupName,
                    adminName: admin,
                  ),
                )
              );
            }, 
            icon: const Icon(Icons.info)
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Positioned(bottom: 0, right: 0,child: Image.asset('assets/fondo.jpg')),
            Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(child: chatMessage()),
              const Divider(height: 2),
              Container(
                alignment: Alignment.bottomCenter,
                width: Responsive.of(context).width,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  width: Responsive.of(context).width,
                  color: Colors.grey[400],
                  child: Row(children: [
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Send a message...',
                          hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                          border: InputBorder.none,
                        ),
                      ), 
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: (){
                        sendMessage();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xff10c6b1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(child: Icon(Icons.send, color: Colors.white)),
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
          ]
        ),
      )
    );
  }

  chatMessage(){
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      sentByMe: widget.username ==
                          snapshot.data.docs[index]['sender']);
                },
              )
            : Container();
      },
    );
  }
  sendMessage(){
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.username,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService(FirebaseAuth.instance.currentUser!.uid).sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }
}
