class ConfigurationClass {
  final int id;
  final String shortDetails;
  final String details;

  ConfigurationClass.formJson(Map<String,dynamic> jsonData) :
  id = jsonData['id'] ?? 0,
  shortDetails = jsonData['shortDetails'] ?? null,
  details = jsonData['details'] ?? null;
}