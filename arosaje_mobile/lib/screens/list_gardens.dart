import 'dart:async';
import 'dart:convert';

import 'package:arosaje_mobile/components/bottom_nav.dart';
import 'package:arosaje_mobile/controllers/list_gardens.dart';
import 'package:arosaje_mobile/models/garden.dart';
import 'package:flutter/material.dart';
import '../navigation/navigation.dart';
import 'package:provider/provider.dart';

class ListGardens extends StatefulWidget {
  final ListGardensController listGardensController =
      ListGardensController("mytoken");

  ListGardens({super.key});

  @override
  State<ListGardens> createState() => _ListGardensState();
}

class _ListGardensState extends State<ListGardens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Mes jardins'),
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomNav(0),
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
                        onTap: () {
                          Provider.of<NavigationController>(context,
                                  listen: false)
                              .changeScreen('/gardenDetails');
                        },
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
