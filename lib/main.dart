import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Better Textfield',
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF838aeb), Color(0xFF7c77cd)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                'So nice to meet you! What do your friends call you?',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFeaecff),
                ),
              ),
              const Spacer(flex: 3),
              const TextField(),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: IconButton(
          icon: const Icon(Icons.check),
          color: const Color(0xFF838aeb),
          onPressed: () => log("Done!", name: "fab"),
        ),
      ),
    );
  }
}
