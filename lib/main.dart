import 'dart:developer';

import 'package:better_textfield/widgets/better_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Basic App for Textfield demonstration
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
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
//  with TextSelectionDelegate {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController _textController = TextEditingController();

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
              // Reference Textfield
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.5)),
                child: TextField(
                  controller: _textController,
                ),
              ),
              const SizedBox(height: 32),
              // This is the main better_textfield
              // So to approach this problem, I had two possible solutions in mind:
              // 1. Use a TextField from Flutter and update it with cursor fixes and other fixes
              // 2. Create a new Textfield from scratch and use it as a replacement for the old one
              // I chose the second one because it's easier to implement and I don't want to have to deal with the TextField from Flutter
              // which does contains a lot of other bugs and complex documentation.
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.5)),
                child: BetterTextfield(controller: _textController),
              ),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16, right: 16),
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
