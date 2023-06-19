import 'package:arosaje_mobile/controllers/register.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = RegisterController();

  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _pseudoController,
                decoration: InputDecoration(
                    labelText: 'Pseudo',
                    errorText: registerController.getPseudoErrorMessage),
                validator: registerController.isPseudoValid,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: registerController.getEmailErrorMessage),
                validator: registerController.isEmailValid,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: registerController.getPasswordErrorMessage,
                  labelText: 'Mot de passe',
                ),
                validator: registerController.isPasswordValid,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String message = await registerController.registerUser(
                        context,
                        _pseudoController.text,
                        _emailController.text,
                        _passwordController.text);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                },
                child: const Text('Créer mon compte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
