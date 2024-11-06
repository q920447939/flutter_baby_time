import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'flick_not_full_screen_controls.dart';

class VideoPlay extends StatefulWidget {
  final String placeholderImageUrl;
  final String url;
  final bool autoPlay;
  final bool looping;
  final bool useCache;

  // 比例
  final double aspectRatio;

  VideoPlay({
    Key? key,
    required this.url,
    required this.placeholderImageUrl,
    this.autoPlay = true,
    this.looping = true,
    this.useCache = true,
    this.aspectRatio = 3 / 2,
  }) : super(key: key);

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late FlickManager flickManager;
  bool _showImage = true; // 控制是否显示图像

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController: widget.url.startsWith("asset")
          ? VideoPlayerController.asset(
              widget.url,
            )
          : VideoPlayerController.networkUrl(Uri.parse(widget.url),
              videoPlayerOptions: VideoPlayerOptions()),
      autoPlay: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoResume();
        }
      },
      child: _showImage
          ? Visibility(
              visible: _showImage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    widget.placeholderImageUrl,
                    fit: BoxFit.cover,
                    height: 200.h,
                    width: 400.w,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Colors.grey.withOpacity(0.15.r),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _showImage = !_showImage;
                          });
                          flickManager.flickControlManager!.play();
                        },
                        child: Stack(alignment: Alignment.center, children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white70,
                            ),
                          ),
                          Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                            size: 40.r,
                          )
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : FlickVideoPlayer(
              flickManager: flickManager,
              flickVideoWithControls: FlickVideoWithControls(
                closedCaptionTextStyle: TextStyle(fontSize: 8),
                controls: FlickNotFullScreenControls(),
              ),
              flickVideoWithControlsFullscreen: FlickVideoWithControls(
                controls: FlickLandscapeControls(),
              ),
            ),
    );
  }
}
