class Party {
  Party({
    required this.name,
    required this.date,
    required this.description,
    this.picture,
  });

  final String? name;
  final String? date;
  final String? description;
  final String? picture;
}
