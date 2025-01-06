import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/core/data/controller/database/database_controller.dart';
import 'package:flutter_test_shopping_getx/core/data/model/database/user_model.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/landing_screen.dart';
import 'package:flutter_test_shopping_getx/presentation/widget/snackbar_widget.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorMessage;
  bool _isLoading = false; // Loading state

  final controller = Get.put(DatabaseController());

  Future<void> _register() async {
    setState(() {
      _errorMessage = null; // Clear any previous error messages
      _isLoading = true; // Start loading
    });

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = "Please enter both email and password.";
        _isLoading = false; // Stop loading
      });
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Handle successful registration
      print("Registered successfully: ${userCredential.user?.email}");

      Get.to(LandingScreen());
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage =
            e.message ?? "No error found!!!"; // Display error message
        _isLoading = false; // Stop loading
      });
      print("Error during registration: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              if (_isLoading) // Show loading indicator
                const CircularProgressIndicator()
              else
                GestureDetector(
                  onTap: () async {
                    final name = _fullNameController.text.obs;
                    final email = _emailController.text.obs;
                    final password = _passwordController.text.obs;
                    if (name.isEmpty && email.isEmpty && password.isEmpty) {
                      return;
                    }
                    controller
                        .insertUser(
                      model: UserModel(
                        name: name,
                        email: email,
                        password: password,
                        image: "asset/images/profile.jpg".obs,
                      ),
                    )
                        .then(
                      (value) {
                        return snackbarWidget(
                          image: "asset/animations/happy.gif",
                          title: "Successful!",
                          subtitle: "Create an account successfully!",
                        );
                      },
                    );
                    _register();
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
