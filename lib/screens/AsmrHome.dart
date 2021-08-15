import 'package:asmr/models/video.dart';
import 'package:asmr/providers/video_provider.dart';
import 'package:asmr/widgets/video_card.dart';
import 'package:flutter/material.dart';

class AsmrHome extends StatefulWidget {
  @override
  _AsmrHomeState createState() => _AsmrHomeState();
}

class _AsmrHomeState extends State<AsmrHome> {
  final _videoProvider = VideoProvider();

  List<Video> videos = [];

  Future _loadData() async {
    videos.addAll(await _videoProvider.getVideos(0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'ASMR Ear Eating & Licking',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(19, 18, 24, 1.0)),
      backgroundColor: Color.fromRGBO(19, 18, 24, 1.0),
      body: FutureBuilder<List<Video>>(
        future: _videoProvider.getVideos(0),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) =>
                    VideoCard(snapshot.data![index]));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
