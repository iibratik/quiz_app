import 'package:flutter/material.dart';
import 'package:questionapp/admin/admin_login.dart';
import 'package:questionapp/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCabinet extends StatefulWidget {
  const UserCabinet({super.key});

  @override
  State<UserCabinet> createState() => _UserCabinetState();
}

class _UserCabinetState extends State<UserCabinet> {
  void clearPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Route route = MaterialPageRoute(builder: (context) => AdminLogin());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Container(
            margin: EdgeInsets.only(top: 50, left: 10),
            child: ElevatedButton.icon(
              onPressed: () {
                Route route = MaterialPageRoute(builder: (context) => Home());
                Navigator.push(context, route);
              },
              label: Text("back"),
              icon: Icon(Icons.arrow_back),
            ),
          ),
          Center(
            child: Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () => clearPref(),
                style: ButtonStyle(
                    elevation: WidgetStatePropertyAll(5),
                    backgroundColor: WidgetStateProperty.all(Colors.red)),
                child: Text(
                  style: TextStyle(color: Colors.white),
                  "Logout",
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
