class DoctorClass {
  final int id;
  final String name;
  final String picture;
  final String shortDetails;
  final String details;

  DoctorClass.formJson(Map<String , dynamic> jsonMap)
    : id = jsonMap['id'] ?? 0,
    name = jsonMap['name'] ?? null,
    picture = jsonMap['picture'] ?? null,
    shortDetails = jsonMap['shortDetails'] ?? null,
    details = jsonMap['details'] ?? null;
}