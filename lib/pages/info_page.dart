// Tortorici Nico, 5CIA, 28/02/2022

import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info'),),
      body:  const Text('© Tortorici Nico, 2022'),
    );
  }
}
