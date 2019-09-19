import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: StreamBuilder(
              stream: Firestore.instance.collection('names').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text('Default');
                return Text(snapshot.data.documents.first);
              }),
        ),
      ),
    );
  }
}
