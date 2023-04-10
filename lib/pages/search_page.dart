import 'package:chat_firebase/helpers/helper_function.dart';
import 'package:chat_firebase/pages/pages.dart';
import 'package:chat_firebase/services/services.dart';
import 'package:chat_firebase/widgets/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static String routeName = 'searchPage';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearched = false;
  bool isJoined = false;
  String username = '';
  User? user;

  @override
  void initState() {
    super.initState();
    getCurrentUserIdandName();
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  getCurrentUserIdandName() async {
    HelperFunctions.getUserNameFromSF().then((value) {
      username = value!;
    });
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xff10c6b1),
          title: const Text(
            'Search',
            style: TextStyle(
                fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: const Color(0xff10c6b1).withOpacity(0.2),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: searchController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search groups...',
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 16)),
                  )),
                  IconButton(
                      onPressed: () {
                        initiateSearchMethod();
                      },
                      icon: const Icon(Icons.search)),
                ],
              ),
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xff10c6b1)),
                  )
                : groupList()
          ],
        ));
  }

  initiateSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await DatabaseService(FirebaseAuth.instance.currentUser!.uid)
          .searchByName(searchController.text)
          .then((snapshot) {
        setState(() {
          searchSnapshot = snapshot;
          isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  groupList() {
    return hasUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return groupTile(
                username,
                searchSnapshot!.docs[index]['groupId'],
                searchSnapshot!.docs[index]['groupName'],
                searchSnapshot!.docs[index]['admin'],
              );
            },
          )
        : Container();
  }

  joinedOrNot(
      String username, String groupId, String groupName, String admin) async {
    await DatabaseService(user!.uid)
        .isUserJoined(groupName, groupId, username)
        .then((value) => {
              setState(
                () {
                  isJoined = value;
                },
              )
            });
  }

  Widget groupTile(
      String username, String groupId, String groupName, String admin) {
    //funtion to check wheter user already exists in group
    joinedOrNot(username, groupId, groupName, admin);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: const Color(0xff10c6b1),
        child: Text(
          groupName.substring(0, 2).toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        groupName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text('Admin: ${getName(admin)}'),
      trailing: InkWell(
        onTap: () async {
          await DatabaseService(user!.uid)
              .toggleGroupJoin(groupId, username, groupName);
          if(isJoined){
            setState(() {
              isJoined = !isJoined;
            });
            //TODO:Mostrar un snackabar que diga que se unio al grupo
            showSnackbar(context, Colors.greenAccent, 'Se unio al grupo');

            Future.delayed(const Duration(seconds: 2), (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    groupId: groupId, 
                    groupName: groupName, 
                    username: username
                  ),
                )
              );
            });
          }else{
            setState(() {
              isJoined=!isJoined;
            });
            showSnackbar(context, Colors.greenAccent, 'Se salio del grupo');
          }
        },
        child: isJoined
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.redAccent,
                  border: Border.all(color: Colors.white, width: 1)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text('Leave', style: TextStyle(color: Colors.white)),
              )
            : Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff10c6b1),
                  border: Border.all(color: Colors.white, width: 1)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text('Join Now', style: TextStyle(color: Colors.white)),
            ),
      ),
    );
  }
}
