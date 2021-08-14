import 'package:asmr/models/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoProvider {
  final videos = FirebaseFirestore.instance.collection('videos');

  Future<List<Video>> getVideos(int start) async {
    final listOfVideos = <Video>[];
    final QuerySnapshot categorySnapshot = await videos.get();
    for (final doc in categorySnapshot.docs) {
      final video = Video(
        name: doc.get('name'),
        authorName: doc.get('authorName'),
        avatarUrl: doc.get('avatarUrl'),
        previewUrl: doc.get('previewUrl'),
        videoUrl: doc.get('videoUrl'),
      );

      listOfVideos.add(video);
    }
    return listOfVideos;
  }
}
