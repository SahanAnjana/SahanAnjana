class Profession {
  String title;
  String backgroundImage;
  String summery;

  Profession({required this.title, required this.backgroundImage, required this.summery});
}

List<Profession> getProfessions() {
  List<Profession> profession = [];
  Profession professionModel = Profession(
      title: "Mobile Developer",
      backgroundImage: "assets/flutter1.jpg",
      summery:
          "As an undergraduate student with a passion for Mobile app development, I offer a solid foundation in computer science, innovative problem-solving, and a commitment to staying up to date on industry trends. I look forward to contributing my skills and creativity as a Mobile developer.");
  profession.add(professionModel);

  professionModel = Profession(
      title: "AI/ML Engineer",
      backgroundImage: "assets/ml.png",
      summery:
          "As an undergraduate student deeply passionate about AI engineering, I possess a robust background in computer science, adept problem-solving abilities, and a dedicated commitment to staying abreast of cutting-edge industry trends. I eagerly anticipate leveraging my skills and creative mindset to make significant contributions as an AI Engineer intern.");
  profession.add(professionModel);

  return profession;
}
