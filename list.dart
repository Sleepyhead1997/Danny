import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Location"),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection("location").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              List<DocumentSnapshot> docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;
                  String location = data['location'];
                  String describe = data['describe'];
                  String latitude = data['latitude'];
                  String longtitude = data['longtitude'];

                  return ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(location),
                    subtitle: Text(describe),
                  );
                },
              );
            }
          },
        ));
  }
}
