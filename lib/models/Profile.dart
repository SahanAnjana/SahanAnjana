class Profile {
  String profile_image;
  String phone;
  String email;
  String LinkedIn;
  String GitHub;

  Profile({required this.profile_image, required this.phone, required this.email, required this.LinkedIn, required this.GitHub});
}

Profile getProfile() {
  Profile profile = Profile(
    profile_image: "assets/Dp3.jpeg",
    phone: "0752871343",
    email: "bcsahananjana@gmail.com",
    LinkedIn: "https://www.linkedin.com/in/sahan-anjana-000/",
    GitHub: "https://www.github.com/SahanAnjana",
  );
  return profile;
}
