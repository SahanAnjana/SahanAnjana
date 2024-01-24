import 'package:flutter/material.dart';
import 'package:my_portfolio/models/Proffesions.dart';
import 'package:my_portfolio/models/Profile.dart';
import 'package:my_portfolio/models/Projects.dart';
import 'package:my_portfolio/models/Skills.dart';
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
  final ScrollController _scrollController = ScrollController();
  late Profession dropdownvalue;
  GlobalKey aboutKey = GlobalKey();
  GlobalKey skillsKey = GlobalKey();
  GlobalKey projectsKey = GlobalKey();
  GlobalKey educationKey = GlobalKey();
  GlobalKey experienceKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    dropdownvalue = getProfessions()[0];
  }

  void _scrollToSection(double offset) {
    _scrollController.animateTo(offset, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sahan Anjana - '),
            DropdownButton(
              value: dropdownvalue.title,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: getProfessions().map((Profession profession) {
                return DropdownMenuItem(
                  value: profession.title,
                  child: Text(profession.title),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = getProfessions().firstWhere((profession) => profession.title == newValue);
                });
              },
            ),
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Scrollable.ensureVisible(aboutKey.currentContext!);
              },
              child: const Text("About")),
          ElevatedButton(
              onPressed: () {
                Scrollable.ensureVisible(skillsKey.currentContext!);
              },
              child: const Text("Skills")),
          ElevatedButton(
              onPressed: () {
                Scrollable.ensureVisible(projectsKey.currentContext!);
              },
              child: const Text("Projects")),
          ElevatedButton(
              onPressed: () {
                Scrollable.ensureVisible(educationKey.currentContext!);
              },
              child: const Text("Education")),
          ElevatedButton(
              onPressed: () {
                Scrollable.ensureVisible(experienceKey.currentContext!);
              },
              child: const Text("Experience")),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage(getProfile().profile_image),
                ),
              ),
              const SizedBox(height: 16.0),
              Flex(direction: Axis.horizontal, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Text('Phone: ${getProfile().phone}'),
                Text('Email: ${getProfile().email}'),
                InkWell(
                  child: Text('LinkedIn: ${getProfile().LinkedIn}'),
                  onTap: () => launchUrlString(getProfile().LinkedIn),
                ),
                InkWell(
                  child: Text('GitHub: ${getProfile().GitHub}'),
                  onTap: () => launchUrlString(getProfile().GitHub),
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
              Container(
                key: skillsKey,
                child: Column(
                  children: [
                    const Text('Soft Skills', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: getSoftSkills().length,
                        itemBuilder: (context, index) => Chip(label: Text(getSoftSkills()[index].title))),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                key: aboutKey,
                child: Column(
                  children: [
                    const Text('About', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                    Text(dropdownvalue.summery),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                key: experienceKey,
                child: Column(
                  children: [
                    const Text('Experience', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: getWorkExperience().length,
                        itemBuilder: (context, index) => ListTile(
                              title: Text(getWorkExperience()[index].title),
                              subtitle: Text(getWorkExperience()[index].subTitle),
                              trailing: Text(getWorkExperience()[index].duration ?? ""),
                            )),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                key: educationKey,
                child: Column(
                  children: [
                    const Text('Education', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: getEducation().length,
                        itemBuilder: (context, index) => ListTile(
                              title: Text(getEducation()[index].title),
                              subtitle: Text(getEducation()[index].subTitle),
                              trailing: Text(getEducation()[index].duration ?? ""),
                            )),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                key: projectsKey,
                child: Column(
                  children: [
                    const Text('Projects', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: getProjects().length,
                        itemBuilder: (context, index) => ListTile(
                              title: Text(getProjects()[index].title),
                              subtitle: Text(getProjects()[index].subTitle),
                              trailing: Text(getProjects()[index].subject ?? ""),
                            )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
