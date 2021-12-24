import 'dart:developer';

import 'package:better_textfield/widgets/b_text_field.dart' as btf;
import 'package:better_textfield/widgets/b_text_selection_controls.dart';
import 'package:better_textfield/widgets/magnifier.dart';
import 'package:better_textfield/widgets/magnifier_painter.dart';
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
        textTheme: GoogleFonts.robotoMonoTextTheme(),
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey stickyKey = GlobalKey();
  late TextEditingController _textController;
  Offset pos = Offset.zero;
  double height = 0;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textController.addListener(() {
      log('Text changed: ${_textController.selection.baseOffset}');
      final keyContext = stickyKey.currentContext;
      if (keyContext != null) {
        // widget is visible
        final box = keyContext.findRenderObject() as RenderBox;
        setState(() {
          pos = box.localToGlobal(Offset(
              0 - 110 / 2 + (_textController.selection.baseOffset * 9.7),
              0 - box.size.height));
          height = box.size.height;
        });
        log(pos.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Magnifier(
      enabled: true,
      painter: const MagnifierPainter(strokeWidth: 0.5, color: Colors.black12),
      scale: 2,
      magnifierPosition: pos,
      height: height,
      size: const Size(110, 50),
      child: Scaffold(
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
                // DecoratedBox(
                //   decoration: BoxDecoration(color: Colors.red.withOpacity(0.5)),
                //   child: TextField(
                //     controller: _textController,
                //   ),
                // ),
                // const SizedBox(height: 32),
                // DecoratedBox(
                //   decoration: BoxDecoration(color: Colors.red.withOpacity(0.5)),
                //   child: BetterTextfield(controller: _textController),
                // ),
                // const SizedBox(height: 32),
                // This is the main better_textfield
                // So to approach this problem, I had two possible solutions in mind:
                // 1. Use a TextField from Flutter and update it with cursor fixes and other fixes
                // 2. Create a new Textfield from scratch and use it as a replacement for the old one
                // I chose the second one because it's easier to implement and I don't want to have to deal with the TextField from Flutter
                // which does contains a lot of other bugs and complex documentation.
                // At least this is what I thought when I was writing the above comments.
                // Well it turns out the first approach may seem complicated but it does have a clear path to work on.
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8)),
                  child: btf.TextField(
                    key: stickyKey,
                    selectionControls: BetterTextSelectionControls(),
                    controller: _textController,
                  ),
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
      ),
    );
  }
}
