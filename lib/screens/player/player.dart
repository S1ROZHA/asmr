import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final String bannerUnitId = BannerAd.testAdUnitId;

class Player extends StatefulWidget {
  Player(this.url);

  final String url;

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late final _controller = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  BannerAd? _anchoredBanner;
  bool _loadingAnchoredBanner = false;

  @override
  void dispose() {
    super.dispose();
    _anchoredBanner?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loadingAnchoredBanner) {
      _loadingAnchoredBanner = true;
      _createAnchoredBanner(context);
    }
    return Column(
      children: [
        Expanded(
          child: YoutubePlayer(
            controller: _controller,
            bottomActions: [
              ProgressBar(isExpanded: true),
              CurrentPosition(),
              FullScreenButton(),
            ],
          ),
        ),
        if (_anchoredBanner != null)
          Container(
            color: Color.fromRGBO(90, 30, 163, 1.0),
            width: _anchoredBanner!.size.width.toDouble(),
            height: _anchoredBanner!.size.height.toDouble(),
            child: AdWidget(ad: _anchoredBanner!),
          ),
      ],
    );
  }

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: AdRequest(),
      adUnitId: bannerUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }
}
