class RecyclableItem {
  final String name;
  final String imagePath;
  final String type;
  final String? educationalFactKey;

  RecyclableItem({
    required this.name,
    required this.imagePath,
    required this.type,
    this.educationalFactKey,
  });
} 