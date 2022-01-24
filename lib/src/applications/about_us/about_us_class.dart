class AboutUsClass {
  final int id;
  final String name;
  final String picture;
  final String role;
  final String designation;

  AboutUsClass.formJson(Map<String , dynamic> jsonMap)
    : id = jsonMap['id'] ?? 0,
    name = jsonMap['name'] ?? null,
    picture = jsonMap['picture'] ?? null,
    role = jsonMap['role'] ?? null,
    designation = jsonMap['designation'] ?? null;
}