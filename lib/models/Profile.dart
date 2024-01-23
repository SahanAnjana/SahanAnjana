class Profile {
  String phone;
  String email;
  String LinkedIn;
  String GitHub;

  Profile({required this.phone, required this.email, required this.LinkedIn, required this.GitHub});
}

Profile getProfile() {
  Profile profile = Profile(
    phone: "0752871343",
    email: "bcsahananjana@gmail.com",
    LinkedIn: "www.linkedin.com/sahan-anjana000",
    GitHub: "www.github.com/SahanAnjana",
  );
  return profile;
}
