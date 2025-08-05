import 'dart:math';

import 'model.dart';

class PoemRepository {
  final Random _random = Random();

  // Adjust how many images you have per mood
  final Map<String, int> moodImageCount = {
    'Melancholy': 10,
    'Hopeful': 10,
    'Inspired': 10,
    'Lonely': 10,
    // Add more moods and their image count
  };

  String _getRandomImagePath(String mood) {
    final count = moodImageCount[mood] ?? 1;
    final index =
        _random.nextInt(count) + 1; // +1 to match filenames like image1.jpg
    return 'images/${mood.toLowerCase()}/image$index.jpg'; // Make sure folder and filenames match
  }

  Future<List<Poem>> fetchPoems() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _poems.map((poem) {
      return poem.copyWith(imageAsset: _getRandomImagePath(poem.mood));
    }).toList();
  }

  final List<Poem> _poems = [
    Poem(
      title: 'Cursed flower 📓🗝',
      imageAsset: '',
      content:
          '''Cursed , unlucky,worthless, lost, unworthy… these are part of the thoughts that me a cursed flower has… 
So hard to contain, so hard to water, so heavy to lift … am I just destined to be like this? In the dark? 

Judged for things that I can’t control, pointed at for being different, hahaha … is this what people call desperation? Despair?  Unable to take away the only thing that still allow me to go through this… 

Pathetic, yes I’m that … weak it seems I’ve always been… so please keep on nourishing these feelings in me … maybe time will come for them to finally take the commands and guide me the cursed flower …

Do I scare you? I’m poison after all… I’m a cursed flower… , you water me less or much I die , you water me enough I get more poisonous… hahaha I can’t wait for these feelings to change me into the deadly flower I’m maybe supposed to be….

So keep on throwing acid on me… even by ignoring my state, the need of a door out … darker I’ll be and deadly you shall face …. 
''',
      musicUrl: 'https://open.spotify.com/track/xyz',
      authorEmail: 'poet@example.com',
      mood: 'Melancholy',
      authorName: 'Umbra',
    ),
    Poem(
      title: 'Morning Hope',
      imageAsset: '',
      content:
          'The sun rises, painting the sky with promise, a new day, a new chance to begin again.',
      musicUrl: 'https://open.spotify.com/track/abc',
      authorEmail: 'dreamer@example.com',
      authorName: 'Dreamer',
      mood: 'Hopeful',
    ),
    Poem(
      title: 'City of Dreams',
      imageAsset: '',
      content:
          'Neon lights hum a lullaby of ambition, where every street corner holds a story untold.',
      musicUrl: 'https://open.spotify.com/track/def',
      authorEmail: 'observer@example.com',
      authorName: 'Observer',
      mood: 'Inspired',
    ),
    Poem(
      title: 'Solitude\'s Embrace',
      imageAsset: '',
      content:
          'In solitude\'s embrace, the mind is free to wander, to explore the vast landscapes of the heart without interruption.',
      musicUrl: 'https://open.spotify.com/track/ghi',
      authorEmail: 'thinker@example.com',
      authorName: 'Thinker',
      mood: 'Lonely',
    ),
  ];
}
