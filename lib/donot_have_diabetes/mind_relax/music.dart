import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const music());
}

class music extends StatelessWidget {
  const music({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Relax Your Mind',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      ),
      home: const RelaxApp(),
    );
  }
}

class RelaxApp extends StatefulWidget {
  const RelaxApp({Key? key}) : super(key: key);

  @override
  State<RelaxApp> createState() => _RelaxAppState();
}

class _RelaxAppState extends State<RelaxApp> {
  final AudioPlayer audioPlayer = AudioPlayer();
  String? currentlyPlaying;
  bool isPlaying = false;
  int selectedIndex = 0;
  
  final List<SoundCategory> categories = [
    SoundCategory(
      name: 'Rain',
      image: 'assets/images/rain.jpg',
      audioPath: 'assets/audio/rain.mp3',
    ),
    SoundCategory(
      name: 'Forest',
      image: 'assets/images/forest.jpg',
      audioPath: 'assets/audio/forest.mp3',
    ),
    SoundCategory(
      name: 'Night',
      image: 'assets/images/night.jpg',
      audioPath: 'assets/audio/night.mp3',
    ),
    SoundCategory(
      name: 'Ambient',
      image: 'assets/images/ambient.jpg',
      audioPath: 'assets/audio/ambient.mp3',
    ),
    SoundCategory(
      name: 'Jazz',
      image: 'assets/images/jazz.jpg',
      audioPath: 'assets/audio/jazz.mp3',
    ),
  ];

  final List<RecentPlay> recentPlays = [
    RecentPlay(
      image: 'assets/images/rain_large.jpg',
      audioPath: 'assets/audio/rain.mp3',
    ),
    RecentPlay(
      image: 'assets/images/forest_large.jpg',
      audioPath: 'assets/audio/forest.mp3',
    ),
  ];

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playSound(String audioPath) async {
    if (isPlaying && currentlyPlaying == audioPath) {
      await audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(audioPath));
      setState(() {
        isPlaying = true;
        currentlyPlaying = audioPath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Search Bar
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8DEF8).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(Icons.search, color: Color(0xFF49454F)),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Relax Your Mind Title
                const Text(
                  'Relax Your Mind',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF050505),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Categories
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          playSound(categories[index].audioPath);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(categories[index].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                categories[index].name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Recent Plays
                const Text(
                  'Recent Plays',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF050505),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Recent Plays Cards
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recentPlays.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          playSound(recentPlays[index].audioPath);
                        },
                        child: Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(recentPlays[index].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF61C1C9).withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    currentlyPlaying == recentPlays[index].audioPath && isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Favorites
                const Text(
                  'Favorite',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF050505),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Favorite Cards
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.headphones),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

class SoundCategory {
  final String name;
  final String image;
  final String audioPath;

  SoundCategory({
    required this.name,
    required this.image,
    required this.audioPath,
  });
}

class RecentPlay {
  final String image;
  final String audioPath;

  RecentPlay({
    required this.image,
    required this.audioPath,
  });
}