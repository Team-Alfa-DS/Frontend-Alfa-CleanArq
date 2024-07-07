import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/video/video_bloc.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;
  final String lessonTitle;
  final String courseId;
  final String lessonId;

  const VideoPlayerScreen({
    super.key,
    required this.videoPath,
    required this.lessonTitle,
    required this.courseId,
    required this.lessonId,
  });

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isControllerInitialized = false;
  double _sliderValue = 0.0;
  bool _isDraggingSlider = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _initializeVideoController();
    BlocProvider.of<VideoBloc>(context).add(LoadVideoDetailEvent(
      courseId: widget.courseId,
      lessonId: widget.lessonId,
    ));
  }

  Future<void> _initializeVideoController() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
    _initializeVideoPlayerFuture = _controller.initialize();
    await _initializeVideoPlayerFuture;
    setState(() {
      _isControllerInitialized = true;
    });
    _controller.setLooping(true);
    _controller.play();

    _controller.addListener(() {
      if (_controller.value.isPlaying && !_isDraggingSlider) {
        setState(() {
          _sliderValue = _controller.value.position.inSeconds.toDouble();
        });
      }
    });
  }

  @override
  void dispose() {
    if (_isControllerInitialized) {
      final currentPosition = _controller.value.position.inSeconds;
      print("ping");
      print(currentPosition);
      BlocProvider.of<VideoBloc>(context).add(SaveVideoProgressEvent(
        courseId: widget.courseId,
        lessonId: widget.lessonId,
        time: currentPosition,
      ));
      _controller.dispose();
    }
    super.dispose();
  }

  void _closeVideoPlayer() {
    if (_isControllerInitialized) {
      final currentPosition = _controller.value.position.inSeconds;
      BlocProvider.of<VideoBloc>(context).add(SaveVideoProgressEvent(
        courseId: widget.courseId,
        lessonId: widget.lessonId,
        time: currentPosition,
      ));
      _controller.dispose();
    }
    Navigator.of(context).pop();
  }

  void _onSliderChanged(double value) {
    setState(() {
      _sliderValue = value;
    });
    if (_isControllerInitialized && !_isDraggingSlider) {
      _controller.seekTo(Duration(seconds: value.toInt()));
    }
  }

  void _onSliderChangeStart(double value) {
    setState(() {
      _isDraggingSlider = true;
    });
  }

  void _onSliderChangeEnd(double value) {
    setState(() {
      _isDraggingSlider = false;
      _controller.seekTo(Duration(seconds: value.toInt()));
    });
  }

  void _skipForward() {
    if (_isControllerInitialized) {
      final newPosition =
          _controller.value.position + const Duration(seconds: 5);
      _controller.seekTo(newPosition);
      _controller.play();
    }
  }

  void _skipBackward() {
    if (_isControllerInitialized) {
      final newPosition =
          _controller.value.position - const Duration(seconds: 5);
      _controller.seekTo(newPosition);
      _controller.play();
    }
  }

  void _toggleControlsVisibility() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          _showControls = true;
        }
        return Scaffold(
          appBar: (orientation == Orientation.portrait || _showControls)
              ? AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    widget.lessonTitle,
                    style: const TextStyle(color: Colors.white),
                  ),
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: _closeVideoPlayer,
                  ),
                )
              : null,
          body: GestureDetector(
            onTap: () {
              if (orientation == Orientation.landscape) {
                _toggleControlsVisibility();
              } else {
                setState(() {
                  _showControls = true;
                });
              }
            },
            child: _isControllerInitialized
                ? Container(
                    color: Colors.black,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                        if (_showControls)
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: _buildControls(),
                          ),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget _buildControls() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.fast_rewind, color: Colors.white),
                onPressed: _skipBackward,
              ),
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.fast_forward, color: Colors.white),
                onPressed: _skipForward,
              ),
            ],
          ),
          Slider(
            value: _sliderValue,
            min: 0.0,
            max: _controller.value.duration.inSeconds.toDouble(),
            onChanged: _onSliderChanged,
            onChangeStart: _onSliderChangeStart,
            onChangeEnd: _onSliderChangeEnd,
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
