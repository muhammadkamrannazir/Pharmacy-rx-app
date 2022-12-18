import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_rx/views/pages/bottom_screens/medicine.dart';
import 'package:pharmacy_rx/views/pages/bottom_screens/profile.dart';
import 'package:pharmacy_rx/views/pages/home.dart';

class BottomApp extends StatefulWidget {
  @override
  State createState() => _State();
}

class _State extends State<BottomApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (_) => HelloConvexAppBar(),
        "/bar": (BuildContext context) => Home(),
        "/custom": (BuildContext context) => const MedicineDetail(),
        "/fab": (BuildContext context) => const ProfilePage(),
      },
    );
  }
}

class HelloConvexAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello ConvexAppBar')),
      body: Center(
        child: TextButton(
          child: const Text('Click to show full example'),
          onPressed: () => Navigator.of(context).pushNamed('/bar'),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        height: 63,
        style: TabStyle.react,
        curveSize: 0,
        items: const [
          TabItem(
            icon: Icons.home,
            title: 'Home',
          ),
          TabItem(
            icon: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.yellow,
              child: Center(
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
          TabItem(
            icon: Icons.assessment,
            title: 'Home',
          ),
        ],
        initialActiveIndex: 1,
        onTap: (int i) => ('click index=$i'),
      ),
    );
  }
}
