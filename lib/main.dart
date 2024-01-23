import 'package:flutter/material.dart';
import 'package:my_portfolio/models/Proffesions.dart';
import 'package:my_portfolio/models/Profile.dart';
import 'package:my_portfolio/models/Projects.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'models/education.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sahan Anjana - Mobile Developer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String profile_image = 'https://www.instagram.com/p/CRu4Q_-AwvL/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA==';
  List<Profession> profession = [];
  List<Education> education = [];
  List<Education> workExperience = [];
  List<Projects> projects = [];
  late Profile profile;

  late Profession dropdownvalue;

  @override
  void initState() {
    super.initState();
    profession = getProfessions();
    education = getEducation();
    workExperience = getWorkExperience();
    projects = getProjects();
    profile = getProfile();
    dropdownvalue = profession[0];
  }

  @override
  Widget build(BuildContext context) {
    print(education);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sahan Anjana - '),
            DropdownButton(
              value: dropdownvalue.title,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: profession.map((Profession profession) {
                return DropdownMenuItem(
                  value: profession.title,
                  child: Text(profession.title),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = profession.firstWhere((profession) => profession.title == newValue);
                });
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(profile_image),
                ),
              ),
              const SizedBox(height: 16.0),
              Flex(direction: Axis.horizontal, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text('Phone: ${profile.phone}'),
                Text('Email: ${profile.email}'),
                InkWell(
                  child: Text('LinkedIn: ${profile.LinkedIn}'),
                  onTap: () => launchUrlString(profile.LinkedIn),
                ),
                InkWell(
                  child: Text('GitHub: ${profile.GitHub}'),
                  onTap: () => launchUrlString(profile.GitHub),
                ),
              ]),
              const SizedBox(height: 16.0),
              const Text(
                'Languages',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const Flex(direction: Axis.horizontal, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text('• Sinhala – Native'),
                Text('• English - Professional'),
                Text('• Tamil – Basic'),
              ]),
              const SizedBox(height: 16.0),
              const Text(
                'Soft Skills',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const Flex(direction: Axis.horizontal, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Chip(label: Text('• Problem-Solving')),
                Chip(label: Text('• Teamwork')),
                Chip(label: Text('• Continuous Learning')),
                Chip(label: Text('• Communication'))
              ]),
              const SizedBox(height: 16.0),
              const Text(
                'Summary',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Text(dropdownvalue.summery),
              const SizedBox(height: 16.0),
              const Text(
                'Experience',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: workExperience.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(workExperience[index].title),
                        subtitle: Text(workExperience[index].subTitle),
                        trailing: Text(workExperience[index].duration ?? ""),
                      )),
              const SizedBox(height: 16.0),
              const Text(
                'Education',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: education.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(education[index].title),
                        subtitle: Text(education[index].subTitle),
                        trailing: Text(education[index].duration ?? ""),
                      )),
              const SizedBox(height: 16.0),
              const Text(
                'Projects',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: projects.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(projects[index].title),
                        subtitle: Text(projects[index].subTitle),
                        trailing: Text(projects[index].subject ?? ""),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
