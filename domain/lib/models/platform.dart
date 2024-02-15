class Platform {
  Platform({
    required this.platform,
    required this.associated,
    this.icon,
  });

  final String platform;
  final String? icon;
  final bool associated;
}
