import 'package:asmr/models/video.dart';
import 'package:asmr/screens/player/player.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  VideoCard(
    this.video,
    this.onOpenVideo,
  );

  final Video video;
  VoidCallback onOpenVideo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onOpenVideo();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Player(video.videoUrl ?? ''),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              elevation: 0.0,
              child: Image.network(
                video.previewUrl ?? '',
                fit: BoxFit.fill,
                height: 202,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(video.avatarUrl ?? ''),
                radius: 20,
              ),
              title: Text(
                video.name ?? '',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                video.authorName ?? '',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
