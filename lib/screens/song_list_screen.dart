import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Song? _currentSong;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Canciones'), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];

                  return ListTile(
                    title: Text(song.title),
                    subtitle: Text(song.artist),
                    onTap: () {
                      _isPlaying == true && _currentSong == song
                          ? _stopSong()
                          : _playSong(song);
                    },
                  );
                },
              ),
            ),
            if (_currentSong != null)
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Text(
                  '${_formattedSongDuration(_audioPlayer.bufferedPosition)} - ${_formattedSongDuration(_audioPlayer.duration!)}',
                ),
              ),
            Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed:
                        _isPlaying
                            ? null
                            : () {
                              if (_currentSong != null)
                                _playSong(_currentSong!);
                            },
                    child: Icon(Icons.play_arrow),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isPlaying ? _stopSong : null,
                    child: Icon(Icons.stop),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _playSong(Song song) async {
    try {
      await _audioPlayer.setAsset(song.path);
      _audioPlayer.play();
      setState(() {
        _isPlaying = true;
        _currentSong = song;
      });
    } catch (e) {
      print("error al reproducir la canción");
    }
  }

  void _stopSong() {
    _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
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
  Song({required this.title, required this.artist, required this.path});
}
