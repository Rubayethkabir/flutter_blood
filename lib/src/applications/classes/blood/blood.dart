class Blood {
  final int id;
  final String mobile;
  final String name;
  final String picture;
  final String zone;
  final String bloodGroup;
  final String lastDate;
  final String diffDays;
  final String shortNote;

  Blood.formJson(Map<String , dynamic> jsonMap)
    : id = jsonMap['id'] ?? 0,
    mobile = jsonMap['mobile'] ?? '',
    name = jsonMap['name'] ?? '',
    picture = jsonMap['picture'] ?? '',
    zone = jsonMap['bloodZone'] ?? '',
    bloodGroup = jsonMap['blood'] ?? '',
    lastDate = jsonMap['lastDate'] ?? '',
    diffDays = jsonMap['diffDays'] ?? '',
    shortNote = jsonMap['shortNote'] ?? '';

}