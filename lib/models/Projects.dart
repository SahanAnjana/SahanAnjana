class Projects {
  String title;
  String image;
  String subTitle;
  String? subject;

  Projects({required this.title, required this.subTitle, this.subject, required this.image});
}

List<Projects> getProjects() {
  List<Projects> projects = [];
  Projects projectModel = Projects(
    title: "UniEats",
    image: "assets/images/unieats.png",
    subTitle: "Client Android Mobile Application",
    subject: "Flutter",
  );
  projects.add(projectModel);

  projectModel = Projects(
    title: "UniEats Admin",
    image: "assets/images/unieats_admin.png",
    subTitle: "Seller Android Mobile Application",
    subject: "Flutter",
  );
  projects.add(projectModel);

  projectModel = Projects(
    title: "Smart Intruder System",
    image: "assets/images/flutter_logo.png",
    subTitle: "Android Mobile Application",
    subject: "Flutter",
  );
  projects.add(projectModel);

  projectModel = Projects(
    title: "Digital Vesak Thorana",
    image: "assets/images/html.png",
    subTitle: "Website",
    subject: "HTML/CSS/JS",
  );
  projects.add(projectModel);
  return projects;
}
