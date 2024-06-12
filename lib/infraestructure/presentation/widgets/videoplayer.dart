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
    super.key,
    required this.videoPath,
    required this.courseId,
    required this.lessonId,
  });

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

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
    final currentPosition = _controller.value.position.inSeconds;
    BlocProvider.of<VideoBloc>(context).add(SaveVideoProgressEvent(
      courseId: widget.courseId,
      lessonId: widget.lessonId,
      time: currentPosition,
    ));
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Video Player',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
          if (state is VideoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VideoLoaded) {
            _controller =
                VideoPlayerController.networkUrl(state.video.url as Uri);
            _initializeVideoPlayerFuture = _controller.initialize().then((_) {
              _controller.seekTo(Duration(seconds: state.currentTime));
              _controller.setLooping(true);
              _controller.play();
              setState(() {});
            });

            return FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          } else if (state is VideoError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
