import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: Center(child: ProfileCard()),
    );
  }
}

class ProfileCard extends StatelessWidget {
  ProfileCard({super.key});

  final String profileName = 'Profesor';

  final String cardProfilePhoto =
      'https://cdn4.iconfinder.com/data/icons/avatars-xmas-giveaway/128/batman_hero_avatar_comics-512.png';
  final TextStyle textCardStyle = TextStyle(
    fontFamily: 'monospace',
    fontSize: 30,
    fontWeight: FontWeight.w200,
    color: Colors.white,
  );

  final cardDecoration = BoxDecoration(
    gradient: RadialGradient(
      colors: [Colors.cyan, Colors.black, Colors.blue],
      radius: 2,
      center: Alignment.bottomCenter,
      focal: AlignmentGeometry.directional(0, 1.2),
      focalRadius: 0.1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
    ],
    borderRadius: BorderRadius.circular(20),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 300,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      decoration: cardDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(cardProfilePhoto, width: 150),
          Spacer(),
          Text(
            'Hola soy $profileName',
            textAlign: TextAlign.center,
            style: textCardStyle,
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: Text('Ver canciones')),
        ],
      ),
    );
  }
}

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      title: Text('Mi aplicación'),
      centerTitle: true,
      backgroundColor: const Color(0xFF00D9FF),
      leading: Padding(
        padding: EdgeInsetsGeometry.only(left: 10),
        child: CircleAvatar(
          radius: 10,
          backgroundImage: AssetImage('assets/img/rem.jpg'),
          child: Container(
            alignment: AlignmentGeometry.directional(1.2, 1),
            child: Icon(Icons.circle, color: Colors.green),
          ),
        ),
      ),
      actions: [Icon(Icons.music_note, size: 30)],
      actionsPadding: EdgeInsetsDirectional.only(end: 20),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
