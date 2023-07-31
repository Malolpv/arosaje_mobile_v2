import 'dart:io';

import 'package:arosaje_mobile/controllers/add_garden.dart';
import 'package:arosaje_mobile/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddGardenScreen extends StatefulWidget {
  final AddGardenController addGardenController;

  const AddGardenScreen(this.addGardenController, {super.key});

  @override
  State<AddGardenScreen> createState() => _AddGardenScreenState();
}

class _AddGardenScreenState extends State<AddGardenScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un jardin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            AnimatedBuilder(
                animation: widget.addGardenController,
                builder: (context, child) {
                  return (widget.addGardenController.image != null &&
                          widget.addGardenController.errorMessage == null)
                      ? CircleAvatar(
                          backgroundImage: FileImage(File(
                              widget.addGardenController.image?.path ?? "")),
                          radius: 48,
                        )
                      : Text(widget.addGardenController.errorMessage ?? "");
                }),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    maximumSize:
                        Size(MediaQuery.of(context).size.width / 2, 40)),
                onPressed: () => _pickImage(ImageSource.camera),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Prendre une photo"), Icon(Icons.camera)],
                )),
            TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nom du jardin'),
                validator: widget.addGardenController.isNameValid),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  bool success = false;

                  success = await widget.addGardenController
                      .addGarden(_nameController.text);

                  String message = (success)
                      ? 'Jardin Créé'
                      : widget.addGardenController.requestErrorMessage ??
                          "Erreur lors de l'ajout";
                  if (success) {
                    Provider.of<NavigationController>(context, listen: false)
                        .changeScreen('/listGardens');
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                }
              },
              child: const Text('Ajouter'),
            ),
          ]),
        ),
      ),
    );
  }

  void _pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(source: source);
    if (imageFile != null) {
      widget.addGardenController.selectImage(imageFile);
    }
  }
}
