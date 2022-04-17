import 'package:flutter/material.dart';

class dummyPage extends StatefulWidget {
  const dummyPage({Key? key}) : super(key: key);

  @override
  State<dummyPage> createState() => _dummyPageState();
}

class _dummyPageState extends State<dummyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("This is a dummy page"),
    );
  }
}
