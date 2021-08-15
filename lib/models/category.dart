import 'package:asmr/models/video.dart';

class Category {
  Category({
    this.name,
    this.imageUrl,
  });

  final String? name;
  final String? imageUrl;
  final List<Video?> listOfVideo = [];
}
