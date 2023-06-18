import 'dart:async';
import 'dart:convert';

import 'package:arosaje_mobile/controllers/list_gardens.dart';
import 'package:arosaje_mobile/models/garden.dart';
import 'package:flutter/material.dart';

class ListGardens extends StatefulWidget {
  final ListGardensController listGardensController;

  ListGardens(this.listGardensController, {super.key});

  @override
  State<ListGardens> createState() => _ListGardensState();
}

class _ListGardensState extends State<ListGardens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes jardins'),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.menu)),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.settings))
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => {},
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: widget.listGardensController.fetchGardens(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: widget.listGardensController.gardens.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final item = widget.listGardensController.gardens[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage:
                                MemoryImage(base64Decode(item.picture))),
                        title: Text(item.name),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    );
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
