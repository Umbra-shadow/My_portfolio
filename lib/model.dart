class SkillsCategory {
  final String category;
  final String skill;

  SkillsCategory({required this.category, required this.skill});
}

// Full skills list
final List<SkillsCategory> _mySkills = [
  SkillsCategory(category: 'Mobile', skill: 'Dart'),
  SkillsCategory(category: 'Mobile', skill: 'Flutter'),
  SkillsCategory(category: 'Mobile', skill: 'Firebase'),
  SkillsCategory(category: 'Embedded systems', skill: 'C++'),
  SkillsCategory(category: 'Mobile & Web', skill: 'REST APIs'),
  SkillsCategory(category: 'Mobile & Web', skill: 'Agile Methodologies'),
  SkillsCategory(category: 'Design', skill: 'UI/UX Design Principles'),
  SkillsCategory(
    category: 'Development',
    skill: 'State Management (Bloc, Provider)',
  ),
];

// Function to get skills by category
List<SkillsCategory> getSkillsByCategory(String category) {
  return _mySkills.where((skill) => skill.category == category).toList();
}
