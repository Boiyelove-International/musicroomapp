import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {
  @override
  _EventDetail createState() => _EventDetail();
}

class _EventDetail extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView(
          children: [Container(height: 20)],
        ),
      ),
    );
  }
}
