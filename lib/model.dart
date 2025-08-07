class SkillsCategory {
  final String category;
  final String skill;
  final String? side;
  final String? imageUrl;

  SkillsCategory({
    required this.category,
    required this.skill,
    this.side,
    this.imageUrl,
  });
}

final List<String> categories = [
  'Mobile & Web',
  'Embedded systems',
  'Design',
  'Other',
];
final List<String> imagesUrl = [
  'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/dart/dart-original.svg', // 0 dart
  'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/flutter/flutter-original.svg', // 1 flutter
  'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/firebase/firebase-original.svg', // 2 firebase
  'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/django/django-plain.svg', // 3 django
  'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/git/git-original.svg', // 4 github
  'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/python/python-original.svg', // 5 python
  'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/fastapi/fastapi-original.svg', // 6 fastapi
  'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/azuresqldatabase/azuresqldatabase-original.svg', // 7 sql
  'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/djangorest/djangorest-original.svg', // 8 restapi
  'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/cplusplus/cplusplus-original.svg', // 9 c++
  'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/figma/figma-original.svg', // 10 figma
];

final List<SkillsCategory> _mySkills = [
  SkillsCategory(
    category: categories[0],
    skill: 'Dart',
    side: 'frontend',
    imageUrl: imagesUrl[0],
  ),
  SkillsCategory(
    category: categories[0],
    skill: 'Flutter',
    side: 'frontend',
    imageUrl: imagesUrl[1],
  ),
  SkillsCategory(
    category: categories[0],
    skill: 'Firebase',
    side: 'backend',
    imageUrl: imagesUrl[2],
  ),
  SkillsCategory(
    category: categories[0],
    skill: 'Python',
    side: 'backend',
    imageUrl: imagesUrl[5],
  ),
  SkillsCategory(
    category: categories[0],
    skill: 'Django',
    side: 'backend',
    imageUrl: imagesUrl[3],
  ),
  SkillsCategory(
    category: categories[0],
    skill: 'Fast APIs',
    side: 'backend',
    imageUrl: imagesUrl[6],
  ),
  SkillsCategory(
    category: categories[0],
    skill: 'REST APIs',
    side: 'backend',
    imageUrl: imagesUrl[8],
  ),
  SkillsCategory(
    category: categories[1],
    skill: 'C++',
    side: 'backend',
    imageUrl: imagesUrl[9],
  ),
  SkillsCategory(
    category: categories[2],
    skill: 'SQL Databases',
    side: 'other',
    imageUrl: imagesUrl[7],
  ),
  SkillsCategory(
    category: categories[2],
    skill: 'App Architecture',
    side: 'other',
    imageUrl: null,
  ),
  SkillsCategory(
    category: categories[2],
    skill: 'Git & GitHub',
    side: 'other',
    imageUrl: imagesUrl[4],
  ),
  SkillsCategory(
    category: categories[3],
    skill: 'Agile Methodologies',
    side: 'other',
    imageUrl: null,
  ),
  SkillsCategory(
    category: categories[2],
    skill: 'UI/UX Design Principles',
    side: 'design',
    imageUrl: imagesUrl[10],
  ),
  SkillsCategory(
    category: categories[3],
    skill: 'Bloc',
    side: 'frontend',
    imageUrl: null,
  ),
];

// Function to get skills by category
List<SkillsCategory> getSkillsByCategory(String category) {
  return _mySkills.where((skill) => skill.category == category).toList();
}

SkillsCategory getSkillDetails(String skill) {
  return _mySkills.firstWhere(
    (s) => s.skill.toLowerCase() == skill.toLowerCase(),
    orElse: () => SkillsCategory(
      category: 'unknown',
      skill: skill,
      side: 'unknown',
      imageUrl: 'unknown',
    ),
  );
}
