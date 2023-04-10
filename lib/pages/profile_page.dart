
import 'dart:io';

import 'package:chat_firebase/pages/pages.dart';
import 'package:chat_firebase/services/select_image.dart';
import 'package:chat_firebase/services/services.dart';
import 'package:chat_firebase/services/upload_storage.dart';
import 'package:chat_firebase/widgets/avatar.dart';
import 'package:chat_firebase/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = 'profilePage';
  String username;
  String email;
  
  ProfilePage({Key? key, required this.username, required this.email}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  File? image_to_upload;
  String profilePic = '';
  AuthService authService = AuthService();

  @override
  void initState() {
    getFoto();
    super.initState();
  }

  getFoto() async{
    final url = await DatabaseService(FirebaseAuth.instance.currentUser!.uid).getPhoto(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      profilePic = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff10c6b1),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: [
            Center(
              child: AvatarButton(
                imageSize: 130,
                imageurl: profilePic,
                boton: false,
              ),
            ),
            const SizedBox(height: 15),
            Text(widget.username, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontSize: 20),),
            const SizedBox(height: 30),
            const Divider(height: 2),
            ListTile(
              onTap: (){
                Navigator.pushNamed(context, HomeChat.routeName);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text('Groups', style: TextStyle(color: Colors.black),),
            ),
            ListTile(
              onTap: (){},
              selected: true,
              selectedColor: const Color(0xff10c6b1),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile', style: TextStyle(color: Colors.black),),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      title:   const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          }, 
                          icon: const Icon(Icons.cancel, color: Colors.red,)
                        ),
                        IconButton(
                          onPressed: () async {
                            authService.signout().whenComplete(() {
                            Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (route) => false);
                            });
                          }, 
                          icon: const Icon(Icons.done_rounded, color: Colors.green,)
                        ),
                      ],
                    );
                  },
                );
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout', style: TextStyle(color: Colors.black),),
            ),

          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AvatarButton(
              imageurl: profilePic,
              imageSize: 130,
              onPressed: () async {
                final XFile? image = await getImage();
                if(image!=null){
                  setState(() {
                    image_to_upload = File(image.path);
                  });
                  if(image_to_upload==null){
                    return;
                  }else{
                    final upload = await uploadImage(image_to_upload!);
                    final uid = FirebaseAuth.instance.currentUser!.uid;
                    await DatabaseService(uid).userCollection.doc(uid).update({'profilePic':upload});
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeChat(),
                      )
                    );
                    showSnackbar(
                      context, 
                      Colors.greenAccent, 
                      'Foto cambiada con exito'
                    );
                  }
                }else{
                  return;
                }
              },
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Username', style: TextStyle(fontSize: 17)),
                Text(widget.username, style: const TextStyle(fontSize: 17)),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Email', style: TextStyle(fontSize: 17)),
                Text(widget.email, style: const TextStyle(fontSize: 17)),
              ],
            ),
          ],
        ),
      )
    );
  }
}