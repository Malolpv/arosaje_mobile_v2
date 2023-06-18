import 'package:flutter/material.dart';

class GardenDetails extends StatefulWidget {
  const GardenDetails({super.key});

  @override
  State<GardenDetails> createState() => _GardenDetailsState();
}

class _GardenDetailsState extends State<GardenDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Garden details')),
    );
  }
}
