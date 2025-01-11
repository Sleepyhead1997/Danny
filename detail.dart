import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MyForm extends StatefulWidget {
  LatLng coordinate;

  MyForm({required this.coordinate});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController _LocationTextEditingController =
      TextEditingController();
  TextEditingController _LatitudeTextEditingController =
      TextEditingController();
  TextEditingController _LongtitudeTextEditingController =
      TextEditingController();
  TextEditingController _DescribeTextEditingController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _LatitudeTextEditingController.text = widget.coordinate.latitude.toString();
    _LongtitudeTextEditingController.text =
        widget.coordinate.longitude.toString();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void addData() async {
    try {
      await firestore.collection('location').add({
        'location': _LocationTextEditingController.text,
        'latitude': _LatitudeTextEditingController.text,
        'longtitude': _LongtitudeTextEditingController.text,
        'describe': _DescribeTextEditingController.text,
      });

      
      // print("test");
      // print('Data added successfully.');
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _LocationTextEditingController,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Location';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _LatitudeTextEditingController,
              decoration: InputDecoration(
                labelText: 'Latitude',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                  return 'Please enter your Latitude';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _LongtitudeTextEditingController,
              decoration: InputDecoration(
                labelText: 'Longtitude',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                  return 'Please enter your Longtitude';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _DescribeTextEditingController,
              decoration: InputDecoration(
                labelText: 'Describe',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancle'),
                ),
                SizedBox(width: 4.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // do something with the form data
                      String name = _textEditingController.text;
                      print('Name: $name');
                      addData();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
