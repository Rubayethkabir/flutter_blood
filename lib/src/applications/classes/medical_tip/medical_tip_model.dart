class MedicalTipModel {
  final int id;
  final String title;
  final String details;
  final String author;

  MedicalTipModel.formJson(Map<String ,dynamic> json) 
  : id = json['id'] ?? 0,
  title = json['title'] ?? null,
  details = json['details'] ?? null,
  author = json['author'] ?? null;
}