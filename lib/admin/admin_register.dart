import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:questionapp/admin/admin_login.dart';
import 'package:questionapp/pages/home.dart';
import 'package:questionapp/services/datebase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminRegister extends StatefulWidget {
  const AdminRegister({super.key});

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
// VARIBLES
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  bool isLoading = false;
// FUNCTIONS
  Future setUserPref(username, userImageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    if (username != null) {
      prefs.setString("username", username);
      prefs.setString("userImageUrl", userImageUrl);
    }
  }

  Future register() async {
    setState(() {
      isLoading = true; // Show loading indicator when the user taps
    });

// Check if the selectedImage is null
    if (selectedImage == null) {
      setState(() {
        isLoading = false; // Stop loading if no image is selected
      });
      // Show an error or message to the user if no image is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image before registering')),
      );
      return;
    }

    try {
      // Perform the database operation
      Map<String, String> res = await DatabaseMethods().setNewUser(
        selectedImage!,
        userNameController.text,
        userPasswordController.text,
        confirmPasswordController.text,
        context,
      );

      // Store user information in preferences
      await setUserPref(res['username'], res['userImage']);

      // Navigate to home screen
      Route route = MaterialPageRoute(builder: (context) => const Home());
      Navigator.pushReplacement(context, route);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sorry, some error occurred: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future setUsernamePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", userNameController.text.toString());
    prefs.clear();
  }

  Future getImage() async {
    // Загрузка изображения, если оно выбрано

    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      selectedImage = File(image!.path);
    }
  }

// WIDGET
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFededeb),
      body: SingleChildScrollView(
        child: isLoading
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              )
            : Container(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 8),
                      padding:
                          const EdgeInsets.only(top: 45, left: 20, right: 20),
                      height: MediaQuery.of(context).size.height / 1.14,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 53, 51, 51),
                                Colors.black
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(
                                  MediaQuery.of(context).size.width, 110))),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 30, right: 30, top: 60),
                      child: Form(
                          child: Column(
                        children: [
                          const Text(
                            "Register page",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Material(
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  selectedImage == null
                                      ? GestureDetector(
                                          onTap: () {
                                            getImage();
                                          },
                                          child: Material(
                                            elevation: 4,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              width: 150,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Icon(
                                                  Icons.camera_alt_outlined),
                                            ),
                                          ),
                                        )
                                      : Material(
                                          elevation: 4,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            width: 150,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              child: Image.file(
                                                selectedImage!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InputWidget(
                                    controller: userNameController,
                                    title: "Username",
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InputWidget(
                                    controller: userPasswordController,
                                    title: "Password",
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InputWidget(
                                    controller: confirmPasswordController,
                                    title: "Confirm Password",
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await register();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Register',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "I already have account ",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Route route = MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminLogin());
                                          Navigator.push(context, route);
                                        },
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.controller,
    required this.title,
  });
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 160, 160, 147)),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter $title';
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 160, 160, 147))),
        ),
      ),
    );
  }
}
