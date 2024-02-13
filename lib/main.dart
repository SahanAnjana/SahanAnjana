import 'package:flutter/material.dart';
import 'package:my_portfolio/models/Proffesions.dart';
import 'package:my_portfolio/models/Profile.dart';
import 'package:my_portfolio/models/Projects.dart';
import 'package:my_portfolio/models/Skills.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'home.dart';
import 'models/education.dart';

void main() {
  runApp(const MyApp());
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
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Colors.transparent, //<-- SEE HERE
          elevation: 0,
        ),
      ),
      home: const Home(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  Color appBarBackgroundColor = Colors.transparent; // Initial color
  Color selectedTabColor = Colors.black; // Initial color
  bool isButtonYellow = false;
  late List<GlobalKey> sectionKeys;
  @override
  void initState() {
    super.initState();
    dropdownvalue = getProfessions()[0];
    sectionKeys = [aboutKey, skillsKey, languagesKey, projectsKey, educationKey, experienceKey, contactKey];
    _scrollController.addListener(() {
      print(_scrollController.offset);
      updateAppBarButtons();
      if (_scrollController.offset >= 100) {
        setState(() {
          appBarBackgroundColor = Colors.black; // Change to black background
          selectedTabColor = Colors.yellow; // Change to yellow font color
        });
      } else {
        setState(() {
          appBarBackgroundColor = Colors.transparent; // Change back to transparent background
          selectedTabColor = Colors.black; // Change back to black font color
        });
      }
    });
  }

  void updateAppBarButtons() {
    for (int i = 0; i < sectionKeys.length; i++) {
      final RenderBox renderBox = sectionKeys[i].currentContext?.findRenderObject() as RenderBox;
      final screenHeight = MediaQuery.of(context).size.height;
      final double sectionTop = renderBox.localToGlobal(Offset.zero).dy;
      final double sectionBottom = sectionTop + renderBox.size.height;

      if (sectionTop <= screenHeight / 2 && sectionBottom >= screenHeight / 2) {
        break;
      }
    }
  }

  TextStyle tabStyle() {
    return TextStyle(color: isButtonYellow ? Colors.yellow : Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      appBar: buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(dropdownvalue.backgroundImage), fit: BoxFit.cover),
        ),
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(image: AssetImage(getProfile().profile_image), fit: BoxFit.cover),
                      //   ),
                      // ),
                      const SizedBox(height: 40),
                      Text(getProfile().name, style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white)),
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
                Container(
                  key: aboutKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('About', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                      Text(dropdownvalue.summery),
                    ],
                  ),
                ),
                Container(
                  key: languagesKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
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
                Container(
                  key: skillsKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
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
                Container(
                  key: experienceKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
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
                Container(
                  key: educationKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                Container(
                  key: projectsKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                Container(
                  key: contactKey,
                  constraints: BoxConstraints(minHeight: screenHeight, minWidth: screenWidth),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Contacts', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
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
                      buildContactForm()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Sahan Anjana - ', style: TextStyle(color: Colors.orangeAccent)),
          DropdownButton(
            value: dropdownvalue.title,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: getProfessions().map((Profession profession) {
              return DropdownMenuItem(
                value: profession.title,
                child: Text(profession.title, style: const TextStyle(color: Colors.yellow)),
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
        buildAppBarButton("About", aboutKey),
        buildAppBarButton("Skills", skillsKey),
        buildAppBarButton("Projects", projectsKey),
        buildAppBarButton("Education", educationKey),
        buildAppBarButton("Experience", experienceKey),
        buildAppBarButton("Contacts", contactKey),
      ],
      backgroundColor: appBarBackgroundColor,
    );
  }

  Widget buildAppBarButton(String text, GlobalKey key) {
    return ElevatedButton(
        onPressed: () {
          Scrollable.ensureVisible(key.currentContext!);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            dropdownvalue.title == text ? Colors.yellow : Colors.transparent,
          ),
        ),
        child: Text(text));
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
}
