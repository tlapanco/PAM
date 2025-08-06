import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                color: Colors.purple,
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: Text('Mi aplicación'),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Column(
                    children: [
                      Image.network(
                        width: 200,
                        'https://cdn4.iconfinder.com/data/icons/avatars-xmas-giveaway/128/batman_hero_avatar_comics-512.png',
                      ),
                      Text(
                        'Hola, soy Profesor..!',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w200,
                          fontFamily: 'serif',
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.facebook),
                          Icon(Icons.snapchat),
                          Icon(Icons.messenger),
                        ],
                      ),
                      FloatingActionButton(
                        elevation: 100,
                        onPressed: () {},
                        child: Icon(Icons.play_arrow),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
