import 'package:assignment_5/widget/input_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLogin = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? "Login" : "Registration"),
        backgroundColor: Colors.greenAccent,
      ),

      body: Center(
        child: SizedBox(
          width: 330,
          child: Card(
            color: Colors.greenAccent,
            child: Padding(
              padding: const EdgeInsets.all(20.0),

              child: Form(
                key: _formKey,

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin ? "Login Form" : "Registration Form",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20),

                    // Name Field
                    if (!isLogin)
                      InputField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        labelText: "Name",
                        hintText: "Enter Your Name",
                        prefixIcon: Icon(Icons.person),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is Empty!!";
                          }
                          return null;
                        },
                      ),

                    if (!isLogin) SizedBox(height: 15),

                    // Email Field
                    InputField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      labelText: "Email",
                      hintText: "Enter Your Email",
                      prefixIcon: Icon(Icons.email),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is Empty!!";
                        }

                        if (!RegExp(
                          r'^[\w.-]+@[\w.-]+\.\w+$',
                        ).hasMatch(value)) {
                          return "Enter Valid Email!!";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 15),

                    // Password Field
                    InputField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      labelText: "Password",
                      hintText: "Enter Your Password",
                      prefixIcon: Icon(Icons.lock),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is Empty!!";
                        }

                        if (value.length < 6) {
                          return "Minimum 6 Characters!!";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    // Login / Register Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isLogin
                                    ? "Login Successful!"
                                    : "Registration Successful!",
                              ),
                            ),
                          );
                        }
                      },

                      child: Text(isLogin ? "Login" : "Register"),
                    ),

                    SizedBox(height: 10),

                    // Switch Login / Registration
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },

                      child: Text(
                        isLogin
                            ? "Create New Account? Register"
                            : "Already Have Account? Login",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
