import 'package:emojies_test/reaction_package/reaction_data.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'reaction_package/flutter_animated_reaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Animated Reaction'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey key = GlobalKey();
  ReactionAsset? selectedReaction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    key: key,
                    onPressed: () {
                      setState(() {
                        selectedReaction = null;
                      });
                    },
                    child: selectedReaction == null
                        ? const Text("Reaction")
                        : LottieBuilder.asset(
                            selectedReaction!.path,
                            width: 25,
                            height: 25,
                          ),
                    onLongPress: () {
                      AnimatedFlutterReaction().showOverlay(
                          context: context,
                          key: key,
                          reactions: reactions,
                          onReaction: (val) {
                            setState(() {
                              selectedReaction = val;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(val.name)));
                          });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

List<ReactionAsset> reactions = [
  ReactionAsset(
    name: "like",
    path: 'assets/reactions/like.json',
  ),
  ReactionAsset(
    name: "sad",
    path: 'assets/reactions/sad.json',
  ),
  ReactionAsset(
    name: "love",
    path: 'assets/reactions/love.json',
  ),
];
