import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

DateTime begin;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> with TickerProviderStateMixin {
  Animation animator;
  @override
  void initState() {
    super.initState();
    animator = Tween(begin: 0.0, end: 10.0).animate(AnimationController(duration: Duration(seconds: 10), vsync: this)..forward());
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Container(
        padding: EdgeInsets.only(top: 50),
        color: Colors.white,
        child: Column(
          children: [
            Image.network(
              'https://flutter.dev/assets/get-started/ios/starter-app-5e284e57b8dce587ea1dfdac7da616e6ec9dc263a409a9a8f99cf836340f47b8.png',
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  begin = DateTime.now();
                } else {
                  print(DateTime.now().difference(begin).inMilliseconds);
                }
                return progress == null
                    ? child
                    : CircularProgressIndicator(
                        value: progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes,
                      );
              },
            ),
            AnimatedBuilder(animation: animator, builder: (context, child) {
              return Text(animator.value.toString());
            })
          ],
        ),
      ),
      ),
    );
  }
}
