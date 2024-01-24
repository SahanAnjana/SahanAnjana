class Skill {
  String title;
  String? level;

  Skill({required this.title, this.level});
}

List<Skill> getSoftSkills() {
  List<Skill> skills = [];
  Skill skillModel = Skill(title: "Problem-Solving");
  skills.add(skillModel);

  skillModel = Skill(title: "Teamwork");
  skills.add(skillModel);

  skillModel = Skill(title: "Continuous Learning");
  skills.add(skillModel);

  skillModel = Skill(title: "Communication");
  skills.add(skillModel);

  return skills;
}
