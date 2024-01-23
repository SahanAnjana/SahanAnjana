class Education {
  String title;
  String subTitle;
  String? duration;

  Education({required this.title, required this.subTitle, this.duration});
}

List<Education> getEducation() {
  List<Education> education = [];
  Education educationModel = Education(
    title: "BSc. Information Technology",
    subTitle: "University of Jaffna, Sri Lanka",
    duration: "2020 to Present",
  );
  education.add(educationModel);

  educationModel = Education(
    title: "Bachelor\'s degree, Information Technology",
    subTitle: "University of Colombo School of Computing, Sri Lanka",
    duration: "2019 to Present",
  );
  education.add(educationModel);

  educationModel = Education(
    title: "Bandaranayake College ",
    subTitle: "Gampaha, Sri Lanka",
    duration: "2009 to 2017",
  );
  education.add(educationModel);
  return education;
}

List<Education> getWorkExperience() {
  List<Education> experience = [];
  Education experienceModel = Education(
    title: "Quality Assurance Technician",
    subTitle: "Global System Solutions International (Pvt) Ltd, Colombo",
    duration: "2018 to 2020",
  );
  experience.add(experienceModel);
  return experience;
}
