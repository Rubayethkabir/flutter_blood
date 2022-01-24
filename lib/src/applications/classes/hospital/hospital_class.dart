class HospitalClass {
  final int id;
  final String name;
  final String place;
  final String picture;
  final String details;

  HospitalClass.formJson(Map<String , dynamic> jsonMap)
    : id = jsonMap['id'] ?? 0,
    place = jsonMap['place'] ?? 0,
    name = jsonMap['name'] ?? null,
    picture = jsonMap['picture'] ?? null,
    details = jsonMap['details'] ?? null;

}