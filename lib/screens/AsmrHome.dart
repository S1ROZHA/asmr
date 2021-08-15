import 'package:asmr/models/video.dart';
import 'package:asmr/providers/video_provider.dart';
import 'package:asmr/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const int maxFailedLoadAttempts = 4;
final String interstitialUnitId = InterstitialAd.testAdUnitId;

class AsmrHome extends StatefulWidget {
  @override
  _AsmrHomeState createState() => _AsmrHomeState();
}

class _AsmrHomeState extends State<AsmrHome> {
  final _videoProvider = VideoProvider();

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  List<Video> videos = [];

  Future _loadData() async {
    videos.addAll(await _videoProvider.getVideos(0));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
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
                itemBuilder: (context, index) => VideoCard(
                      snapshot.data![index],
                      _showInterstitialAd,
                    ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: interstitialUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
