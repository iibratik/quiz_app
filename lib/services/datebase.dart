import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questionapp/pages/home.dart';
import 'package:questionapp/providers/provider.dart';

class DatabaseMethods {
  // LOGIN EXISTING USER
  Future<void> getExistingUser(
      String username, String password, BuildContext context) async {
    username = username.trim();
    password = password.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Please fill in both fields',
          style: TextStyle(fontSize: 18),
        ),
      ));
      return;
    }

    try {
      FirebaseFirestore.instance.collection("users_tb").get().then((snapshot) {
        bool isLoggedIn = false;
        for (var result in snapshot.docs) {
          final Map<String, String> userData =
              Map<String, String>.from(result.data());
          ;
          if (userData['username'] == username &&
              userData['password'] == password) {
            context.read<UserProvider>().loginUser(enterUser: userData);
            Route route = MaterialPageRoute(builder: (context) => const Home());
            Navigator.pushReplacement(context, route);
            isLoggedIn = true;
            break;
          }
        }
        if (!isLoggedIn) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Invalid username or password',
              style: TextStyle(fontSize: 18),
            ),
          ));
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
          style: TextStyle(fontSize: 18),
        ),
      ));
    }
  }

  // REGISTER NEW USER
  Future<void> setNewUser(File userImage, String userName, String password,
      String confirmPass, BuildContext context) async {
    try {
      // Firestore and Storage references
      final firestore = FirebaseFirestore.instance;
      final storage = FirebaseStorage.instance;

      // Input validation
      if (password != confirmPass) {
        throw Exception("Passwords do not match.");
      }
      if (userName.isEmpty) {
        throw Exception("Username cannot be empty.");
      }
      if (password.isEmpty) {
        throw Exception("Password cannot be empty.");
      }

      // Upload user profile image to Firebase Storage
      String fileName =
          'userProfileImages/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = storage.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(userImage);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Add user details to Firestore
      await firestore.collection('users_tb').add({
        'username': userName,
        'password': password, // Note: Password should ideally be hashed
        'profilePicture': imageUrl,
      });
      Map<String, String> user = {
        'username': userName.toString(),
        'profilePicture': imageUrl.toString()
      };
      context.read<UserProvider>().loginUser(enterUser: user);
      Route route = MaterialPageRoute(builder: (context) => const Home());
      Navigator.pushReplacement(context, route);
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Error: ${e.toString()}',
          style: const TextStyle(fontSize: 18),
        ),
      ));
    }
  }

  // ADD QUIZ
  Future addQuizCategory(
      Map<String, dynamic> userQuizCategory, categories) async {
    return await FirebaseFirestore.instance
        .collection(categories)
        .add(userQuizCategory);
  }

// GET QUIZ CATEGORY
  Future<Stream<QuerySnapshot>> getCategoryQuiz(String category) async {
    return FirebaseFirestore.instance.collection(category).snapshots();
  }
}
