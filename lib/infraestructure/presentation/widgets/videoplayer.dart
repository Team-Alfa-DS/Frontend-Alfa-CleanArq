import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/video/video_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/video/video_event.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/video/video_state.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;
  final String courseId;
  final String lessonId;

  const VideoPlayerScreen({
    Key? key,
    required this.videoPath,
    required this.courseId,
    required this.lessonId,
  }) : super(key: key);

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
    BlocProvider.of<VideoBloc>(context).add(LoadVideoDetailEvent(
      courseId: widget.courseId,
      lessonId: widget.lessonId,
      videoUrl: widget.videoPath,
    ));
  }

  @override
  void dispose() {
    if (_isControllerInitialized) {
      final currentPosition = _controller.value.position.inSeconds;
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
      final newPosition = _controller.value.position + Duration(seconds: 5);
      _controller.seekTo(newPosition);
      _controller.play(); // Asegurar que el video se reproduzca después del salto
    }
  }

  void _skipBackward() {
    if (_isControllerInitialized) {
      final newPosition = _controller.value.position - Duration(seconds: 5);
      _controller.seekTo(newPosition);
      _controller.play(); // Asegurar que el video se reproduzca después del salto
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
          _showControls = true; // Asegurar que los controles estén visibles en vertical automáticamente
        }
        return Scaffold(
          appBar: (orientation == Orientation.portrait || _showControls)
              ? AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              'Video Player',
              style: TextStyle(color: Colors.white),
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
                  _showControls = true; // Asegurar que los controles estén visibles en vertical
                });
              }
            },
            child: BlocBuilder<VideoBloc, VideoState>(
              builder: (context, state) {
                if (state is VideoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is VideoLoaded) {
                  if (!_isControllerInitialized) {
                    _controller = VideoPlayerController.network(state.video.url);
                    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
                      _controller.seekTo(Duration(seconds: state.currentTime));
                      _controller.setLooping(true);
                      _controller.play();
                      setState(() {
                        _isControllerInitialized = true;
                      });

                      // Actualizar el estado del slider mientras el video está reproduciéndose
                      _controller.addListener(() {
                        if (_controller.value.isPlaying && !_isDraggingSlider) {
                          setState(() {
                            _sliderValue = _controller.value.position.inSeconds.toDouble();
                          });
                        }
                      });
                    });
                  }

                  return Container(
                    color: Colors.black, // Establecer el fondo negro
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
                  );
                } else if (state is VideoError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
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
                icon: Icon(Icons.fast_rewind, color: Colors.white),
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
                icon: Icon(Icons.fast_forward, color: Colors.white),
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
