import 'package:flutter/material.dart';
import 'package:my_portfolio/models/Proffesions.dart';
import 'package:my_portfolio/models/Profile.dart';
import 'package:my_portfolio/models/Projects.dart';
import 'package:my_portfolio/models/Skills.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'models/education.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  late Profession dropdownvalue;
  GlobalKey aboutKey = GlobalKey();
  GlobalKey skillsKey = GlobalKey();
  GlobalKey languagesKey = GlobalKey();
  GlobalKey projectsKey = GlobalKey();
  GlobalKey educationKey = GlobalKey();
  GlobalKey experienceKey = GlobalKey();
  GlobalKey contactKey = GlobalKey();

  Color appBarBackgroundColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    dropdownvalue = getProfessions()[0];
    _scrollController.addListener(() {
      if (_scrollController.offset > 200) {
        setState(() {
          appBarBackgroundColor = Colors.black; // Change to black background
        });
      } else {
        setState(() {
          appBarBackgroundColor = Colors.transparent; // Change back to transparent background
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBodyBehindAppBar: true,
        key: _scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(dropdownvalue.backgroundImage), fit: BoxFit.cover),
          ),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: appBarBackgroundColor,
                pinned: true,
                title: const Text('Sahan Anjana', style: TextStyle(color: Colors.orangeAccent)),
                actions: [
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
                  buildAppBarButton("About", aboutKey),
                  buildAppBarButton("Languages", languagesKey),
                  buildAppBarButton("Skills", skillsKey),
                  buildAppBarButton("Experience", experienceKey),
                  buildAppBarButton("Education", educationKey),
                  buildAppBarButton("Projects", projectsKey),
                  buildAppBarButton("Contacts", contactKey),
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 110.0,
                        child: CircleAvatar(
                          radius: 100.0,
                          backgroundImage: AssetImage(getProfile().profile_image),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(getProfile().name, style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 10),
                      Text(dropdownvalue.title, style: const TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.white)),
                      const SizedBox(height: 40),
                      ElevatedButton(
                          onPressed: () {
                            Scrollable.ensureVisible(aboutKey.currentContext!);
                          },
                          child: const Text("Enter Portfolio"))
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  key: aboutKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('About', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                          Text(dropdownvalue.summery),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  key: languagesKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Languages',
                            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          Flex(direction: Axis.horizontal, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            Text('• Sinhala – Native'),
                            Text('• English - Professional'),
                            Text('• Tamil – Basic'),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  key: skillsKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  key: experienceKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  key: educationKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Education', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: getEducation().length,
                              itemBuilder: (context, index) => ListTile(
                                    leading: Image.asset(getEducation()[index].image),
                                    title: Text(getEducation()[index].title),
                                    subtitle: Text(getEducation()[index].subTitle),
                                    trailing: Text(getEducation()[index].duration ?? ""),
                                  )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  key: projectsKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Projects', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                          GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 8.0,
                              ),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: getProjects().length,
                              itemBuilder: (context, index) => buildProjectCard(getProjects()[index])),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  key: contactKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Contacts', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                          Flex(direction: Axis.horizontal, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            Text('Phone: ${getProfile().phone}'),
                            Text('Email: ${getProfile().email}'),
                          ]),
                          buildContactForm(),
                          buildFooter()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildProjectCard(Projects projects) {
    return Card(
        child: SizedBox(
            height: 200,
            width: 150,
            child: Column(children: [
              Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage(projects.image), fit: BoxFit.cover))),
              Flex(
                direction: Axis.horizontal,
                children: [Text(projects.title), Text(projects.subTitle)],
              )
            ])));
  }

  Widget buildAppBarButton(String text, GlobalKey key) {
    bool isButtonVisible = isKeyVisible(key);
    return ElevatedButton(
        onPressed: () {
          Scrollable.ensureVisible(key.currentContext!);
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(isButtonVisible ? Colors.yellow : Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        child: Text(text));
  }

  bool isKeyVisible(GlobalKey key) {
    if (key.currentContext != null) {
      final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;
      return position.dy > (-1 * screenHeight / 2) && position.dy < screenHeight / 2;
    }
    return false;
  }

  Widget buildContactForm() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController messageController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Send a Message', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Your Name'),
        ),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Your Email'),
        ),
        TextField(
          controller: phoneController,
          decoration: const InputDecoration(labelText: 'Your Phone (Optional)'),
        ),
        TextField(
          controller: messageController,
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'Your Message'),
        ),
        ElevatedButton(
          onPressed: () async {
            String emailBody =
                'Name: ${nameController.text}\nEmail: ${emailController.text}\nPhone: ${phoneController.text}\n\n${messageController.text}';
            String subject = 'New Message from ${nameController.text}';
            String url = 'mailto:${getProfile().email}?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(emailBody)}';

            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
              nameController.clear();
              emailController.clear();
              phoneController.clear();
              messageController.clear();
            } else {
              String message = "Error launching email client";
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
            }
          },
          child: const Text('Send Message'),
        ),
      ],
    );
  }

  Widget buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("Copyright © Sahan Anjana 2023"),
        SizedBox(
            width: 30,
            child: IconButton(
                onPressed: () => launchUrlString(getProfile().GitHub), icon: const Image(image: AssetImage("assets/logo/github-logo.png")))),
        SizedBox(
            width: 30,
            child: IconButton(
                onPressed: () => launchUrlString(getProfile().LinkedIn), icon: const Image(image: AssetImage("assets/logo/linkedin.png")))),
      ],
    );
  }
}
