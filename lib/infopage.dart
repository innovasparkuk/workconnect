import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Infopage extends StatefulWidget {
  @override
  State<Infopage > createState() => _InfopageState();
}

class _InfopageState extends State<Infopage > {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  final CollectionReference infoCollection= FirebaseFirestore.instance.collection("info");

Future<void> saveInfo() async{
  String name = nameController.text.trim();
  String desc =descController.text.trim();
  if(name.isNotEmpty && desc.isNotEmpty){
    await infoCollection.add({
      "name":name,
      "desc":desc,
      "timestamp": FieldValue.serverTimestamp(),
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Info saved")));
    nameController.clear();
    descController.clear();
  }else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter all fields")));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "name")),
            TextField(controller: descController,  decoration: InputDecoration(labelText: "description")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveInfo, child: Text("save")),
          ],
        ),
      ),
    );
  }
}
