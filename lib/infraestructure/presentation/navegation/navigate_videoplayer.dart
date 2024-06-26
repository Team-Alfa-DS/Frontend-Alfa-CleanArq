import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/video/video_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/serviceAplication/progress/progress_service.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/videoplayer.dart';

void navigateToVideoPlayer(BuildContext context, String videoPath, String courseId, String lessonId) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => VideoBloc(context.read<ProgressService>()),
        child: VideoPlayerScreen(
          videoPath: videoPath,
          courseId: courseId,
          lessonId: lessonId,
        ),
      ),
    ),
  );
}
