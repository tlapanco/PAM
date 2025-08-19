import 'package:flutter/material.dart';
import 'package:pam/screens/song_list_screen.dart';

class FavoriteListScreen extends StatefulWidget {
  final List<Song> favoriteSongs;

  const FavoriteListScreen({super.key, required this.favoriteSongs});

  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis canciones favoritas')),
      body: SafeArea(
        child: Center(
          child:
              widget.favoriteSongs.isEmpty
                  ? Text('No hay canciones favoritas')
                  : ListView.builder(
                    itemCount: widget.favoriteSongs.length,
                    itemBuilder: (context, index) {
                      final Song song = widget.favoriteSongs[index];
                      return Card(
                        margin: EdgeInsets.all(8),
                        elevation: 4,
                        color: Colors.white,

                        shadowColor: Colors.cyan,
                        child: ListTile(
                          title: Text(song.title),
                          subtitle: Text(song.artist),
                        ),
                      );
                    },
                  ),
        ),
      ),
    );
  }
}
