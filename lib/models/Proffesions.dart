class Profession {
  String title;
  String summery;

  Profession({required this.title, required this.summery});
}

List<Profession> getProfessions() {
  List<Profession> profession = [];
  Profession professionModel = Profession(
      title: "Mobile Developer",
      summery:
          "As an undergraduate student with a passion for Mobile app development, I offer a solid foundation in computer science, innovative problem-solving, and a commitment to staying up to date on industry trends. I look forward to contributing my skills and creativity as a Mobile developer.");
  profession.add(professionModel);

  return profession;
}
