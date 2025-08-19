import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pam/screens/favorite_list_screen.dart';

class SongListScreen extends StatefulWidget {
  const SongListScreen({super.key});

  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  final List<Song> songs = [
    Song(
      title: 'Mr. brightside',
      artist: 'The killers',
      path: 'assets/songs/1.mp3',
    ),
    Song(
      title: 'How you remind me',
      artist: 'Nickelback',
      path: 'assets/songs/2.mp3',
    ),
  ];

  List<Song> favoriteSongs = [];

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Song? _currentSong;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canciones'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          FavoriteListScreen(favoriteSongs: favoriteSongs),
                ),
              );
            },
            icon: Icon(Icons.favorite, color: Colors.cyan),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];

                  return Card(
                    margin: EdgeInsetsGeometry.all(8),
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        song.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(song.artist),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => _handleFavorite(song),
                            icon: Icon(
                              (song.isFavorite)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.cyan,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (_isPlaying && _currentSong == song) {
                                _stopSong();
                              } else {
                                _playSong(song);
                              }
                            },
                            icon: Icon(
                              (_isPlaying && _currentSong == song)
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color:
                                  (_isPlaying && _currentSong == song)
                                      ? Colors.red
                                      : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_currentSong != null)
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, -2),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      StreamBuilder(
                        stream: _audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final duration =
                              _audioPlayer.duration ?? Duration.zero;
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_formattedSongDuration(duration)),
                                  SizedBox(width: 10),
                                  Text(_formattedSongDuration(position)),
                                ],
                              ),
                              Slider(
                                value: position.inSeconds.toDouble(),
                                max: duration.inSeconds.toDouble(),
                                min: 0,

                                activeColor: Colors.cyan,
                                onChanged: (value) {
                                  _audioPlayer.seek(
                                    Duration(seconds: value.toInt()),
                                  );
                                  //setState(() {});
                                },
                              ),
                            ],
                          );
                        },
                      ),

                      SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _stopSong,
                            icon: Icon(
                              Icons.stop,
                              color: Colors.cyan,
                              size: 50,
                            ),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              (_isPlaying)
                                  ? _pauseSong()
                                  : _playSong(_currentSong!);
                            },
                            icon: Icon(
                              (_isPlaying) ? Icons.pause : Icons.play_arrow,
                              color: Colors.cyan,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleFavorite(Song song) {
    setState(() {
      song.isFavorite = !song.isFavorite;
      if (song.isFavorite) {
        favoriteSongs.add(song);
      } else {
        favoriteSongs.remove(song);
      }
    });
  }

  void _playSong(Song song) async {
    try {
      if (_currentSong == song) {
        _audioPlayer.play();
      } else {
        await _audioPlayer.setAsset(song.path);
        _audioPlayer.play();
        setState(() {
          _currentSong = song;
        });
      }

      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      print("error al reproducir la canción");
    }
  }

  void _pauseSong() {
    _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _stopSong() async {
    await _audioPlayer.stop();
    await _audioPlayer.seek(Duration.zero);
    setState(() {
      _isPlaying = false;
      _currentSong = null;
    });
  }

  String _formattedSongDuration(Duration duration) {
    final mins = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

class Song {
  String title;
  String artist;
  String path;
  bool isFavorite = false;
  Song({required this.title, required this.artist, required this.path});
}
