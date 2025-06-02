import 'package:cadastro_flutter/src/screens/errors/no_internet.dart';
import 'package:cadastro_flutter/src/screens/login/login.dart';
import 'package:cadastro_flutter/src/util/network.dart';
import 'package:flutter/material.dart';

class MyLoadEnter extends StatefulWidget {
  const MyLoadEnter({super.key});

  @override
  State<MyLoadEnter> createState() => _MyLoadEnterState();
}

class _MyLoadEnterState extends State<MyLoadEnter> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () async {
      bool hasNetwork = await NetworkUtil.hasNetwork();
      if (hasNetwork) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyLogin()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NoInternetScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50C9C3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(30),
            // margin: EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 10),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Tech Master',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Assuma o controle e cadastre-se e explore um pouco das funcionalidades.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 50),
                CircularProgressIndicator(),
                SizedBox(height: 50),
                Text(
                  'Comunicando-se com o servidor...',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
