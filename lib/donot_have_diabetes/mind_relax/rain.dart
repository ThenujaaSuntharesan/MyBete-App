import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

Future<void> main() async {
  // Initialize audio background service for notifications
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.relaxapp.channel.audio',
    androidNotificationChannelName: 'Relax App Audio',
    androidNotificationOngoing: true,
  );
  runApp(const RainScreen());
}

class RainScreen extends StatelessWidget {
  const RainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const RainSoundsPage(),
    );
  }
}

class RainSound {
  final String title;
  final String imagePath;
  final String audioPath;

  RainSound({
    required this.title,
    required this.imagePath,
    required this.audioPath,
  });
}

class RainSoundsPage extends StatefulWidget {
  const RainSoundsPage({Key? key}) : super(key: key);

  @override
  State<RainSoundsPage> createState() => _RainSoundsPageState();
}

class _RainSoundsPageState extends State<RainSoundsPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentlyPlayingIndex = -1;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  
  final List<RainSound> _rainSounds = [
    RainSound(
      title: 'Light Rain',
      imagePath: 'lib/donot_have_diabetes/mind_relax/mind images/light rain.jpg',
      audioPath: 'lib/donot_have_diabetes/mind_relax/audio/rain/lluvia-relajante-rain-2-210937.mp3',
    ),
    RainSound(
      title: 'Rain on Umbrella',
      imagePath: 'lib/donot_have_diabetes/mind_relax/mind images/rain.png',
      audioPath: 'lib/donot_have_diabetes/mind_relax/audio/rain/rain-sounds-210646.mp3',
    ),
    RainSound(
      title: 'Heavy Rain',
      imagePath: 'lib/donot_have_diabetes/mind_relax/mind images/Heavy Rain.jpg',
      audioPath: 'lib/donot_have_diabetes/mind_relax/audio/rain/november-rain-259239.mp3',
    ),
    RainSound(
      title: 'Rain Storm',
      imagePath: 'lib/donot_have_diabetes/mind_relax/mind images/Rain Storm.jpg',
      audioPath: 'lib/donot_have_diabetes/mind_relax/audio/rain/rain-inside-a-car-113602.mp3',
    ),
    RainSound(
      title: 'Rain on Road',
      imagePath: 'lib/donot_have_diabetes/mind_relax/mind images/road rain.jpg',
      audioPath: 'lib/donot_have_diabetes/mind_relax/audio/rain/outdoor-rain-hujan-244619.mp3',
    ),
    RainSound(
      title: 'Rain Drops',
      imagePath: 'lib/donot_have_diabetes/mind_relax/mind images/Rain Drops.jpg',
      audioPath: 'lib/donot_have_diabetes/mind_relax/audio/rain/rain-sounds-the-sound-of-summer-rain-141793.mp3',
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((state) {
      if (state.playing != _isPlaying) {
        setState(() {
          _isPlaying = state.playing;
        });
      }
    });
    
    // Listen to duration changes
    _audioPlayer.durationStream.listen((newDuration) {
      if (newDuration != null) {
        setState(() {
          _duration = newDuration;
        });
      }
    });
    
    // Listen to position changes
    _audioPlayer.positionStream.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound(int index) async {
    if (_currentlyPlayingIndex == index && _isPlaying) {
      // If the same sound is already playing, pause it
      await _audioPlayer.pause();
    } else if (_currentlyPlayingIndex == index && !_isPlaying) {
      // If the same sound is paused, resume it
      await _audioPlayer.play();
    } else {
      // Play a new sound
      setState(() {
        _currentlyPlayingIndex = index;
      });
      
      try {
        await _audioPlayer.setAudioSource(
          AudioSource.uri(
            Uri.parse('asset:///${_rainSounds[index].audioPath}'),
            tag: MediaItem(
              id: index.toString(),
              title: _rainSounds[index].title,
              artUri: Uri.parse('asset:///${_rainSounds[index].imagePath}'),
            ),
          ),
        );
        await _audioPlayer.play();
      } catch (e) {
        debugPrint('Error loading audio source: $e');
      }
    }
  }

  Future<void> _playNext() async {
    if (_currentlyPlayingIndex < _rainSounds.length - 1) {
      await _playSound(_currentlyPlayingIndex + 1);
    }
  }

  Future<void> _playPrevious() async {
    if (_currentlyPlayingIndex > 0) {
      await _playSound(_currentlyPlayingIndex - 1);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                  const Expanded(
                    child: Text(
                      'Rain',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 24), // For balance
                ],
              ),
            ),
            
            // Sound grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: _rainSounds.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // Sound image
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            _rainSounds[index].imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Play button
                      GestureDetector(
                        onTap: () => _playSound(index),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF61C1C9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            _currentlyPlayingIndex == index && _isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            
            // Player controls
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF61C1C9),
              child: Column(
                children: [
                  // Progress bar and time
                  Row(
                    children: [
                      Text(
                        _formatDuration(_position),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: _position.inSeconds.toDouble(),
                          min: 0,
                          max: _duration.inSeconds.toDouble() > 0 
                              ? _duration.inSeconds.toDouble() 
                              : 1,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white.withOpacity(0.3),
                          onChanged: (value) {
                            _audioPlayer.seek(Duration(seconds: value.toInt()));
                          },
                        ),
                      ),
                      Text(
                        _formatDuration(_duration),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  // Control buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous, color: Colors.white, size: 32),
                        onPressed: _playPrevious,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: () {
                            if (_currentlyPlayingIndex >= 0) {
                              if (_isPlaying) {
                                _audioPlayer.pause();
                              } else {
                                _audioPlayer.play();
                              }
                            } else if (_rainSounds.isNotEmpty) {
                              _playSound(0);
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next, color: Colors.white, size: 32),
                        onPressed: _playNext,
                      ),
                      IconButton(
                        icon: const Icon(Icons.download, color: Colors.white, size: 28),
                        onPressed: () {
                          // Implement download functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Downloading sound...')),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}