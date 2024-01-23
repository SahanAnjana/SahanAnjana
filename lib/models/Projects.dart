class Projects {
  String title;
  String subTitle;
  String? subject;

  Projects({required this.title, required this.subTitle, this.subject});
}

List<Projects> getProjects() {
  List<Projects> projects = [];
  Projects projectModel = Projects(
    title: "UniEats",
    subTitle: "Client Android Mobile Application",
    subject: "Flutter",
  );
  projects.add(projectModel);

  projectModel = Projects(
    title: "UniEats Admin",
    subTitle: "Seller Android Mobile Application",
    subject: "Flutter",
  );
  projects.add(projectModel);

  projectModel = Projects(
    title: "Smart Intruder System",
    subTitle: "Android Mobile Application",
    subject: "Flutter",
  );
  projects.add(projectModel);

  projectModel = Projects(
    title: "Digital Vesak Thorana",
    subTitle: "Website",
    subject: "HTML/CSS/JS",
  );
  projects.add(projectModel);
  return projects;
}
