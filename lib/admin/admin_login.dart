import 'package:flutter/material.dart';
import 'package:questionapp/pages/home.dart';
import 'package:questionapp/services/datebase.dart';
import 'package:questionapp/admin/admin_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void goRegisterPage() {
    Route route =
        MaterialPageRoute(builder: (context) => const AdminRegister());
    Navigator.push(context, route);
  }

  Future setUserPref(username, userImageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    if (username != null) {
      prefs.setString("username", username);
      prefs.setString("userImageUrl", userImageUrl);
    }
  }

  void login() async {
    setState(() {
      isLoading = true;
    });

    try {
      Map<String, String> res = await DatabaseMethods().getExistingUser(
        usernameController.text,
        passwordController.text,
        context,
      );
      await setUserPref(res['username'], res['userImage']);
      Route route = MaterialPageRoute(builder: (context) => const Home());
      Navigator.pushReplacement(context, route);
      await Future.delayed(Duration(milliseconds: 1800));
    } catch (e) {
      // Handle any errors that occur during the database operation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sorry some error ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFededeb),
      body: isLoading
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              child: Stack(
                children: [
                  _buildBackground(),
                  _buildLoginForm(context),
                ],
              ),
            ),
    );
  }

  Widget _buildBackground() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
      padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(MediaQuery.of(context).size.width, 110),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 60),
      child: Form(
        child: Column(
          children: [
            const Text(
              "Login page",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            _buildInputField(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),
            const SizedBox(height: 20),
            _buildInputField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _buildLoginButton(),
            SizedBox(height: 10),
            _buildRegisterOption(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
  }) {
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle:
                const TextStyle(color: Color.fromARGB(255, 160, 160, 147)),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: () {
        login();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterOption(BuildContext context) {
    return Row(
      children: [
        const Text(
          "If you don't have an account ",
          style: TextStyle(color: Colors.white60),
        ),
        GestureDetector(
          onTap: () {
            goRegisterPage();
          },
          child: const Text(
            "Register",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
