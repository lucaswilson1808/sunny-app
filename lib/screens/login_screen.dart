import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Fluttertoast.showToast(msg: "Login successful!");

        // Navigate to MainScreen
        Navigator.pushReplacementNamed(context, '/main_screen');
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message ?? "An error occurred.");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: loginUser,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Login"),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register'); // Add register screen
                        },
                        child: const Text(
                          "Don't have an account? Register",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}