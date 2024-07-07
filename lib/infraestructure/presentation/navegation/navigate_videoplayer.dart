import 'package:alpha_gymnastic_center/aplication/use_cases/video_use_case/get_video_detailed_use_caser.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/video_use_case/save_video_porgress_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/video/video_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/videoplayer.dart';

void navigateToVideoPlayer(
    BuildContext context, String videoPath, String courseId, String lessonId) {
  final getVideoDetailsUseCase = GetIt.instance<GetVideoDetailsUseCase>();
  final saveVideoProgressUseCase = GetIt.instance<SaveVideoProgressUseCase>();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => VideoBloc(
          getVideoDetailsUseCase: getVideoDetailsUseCase,
          saveVideoProgressUseCase: saveVideoProgressUseCase,
        ),
        child: VideoPlayerScreen(
          videoPath: videoPath,
          courseId: courseId,
          lessonId: lessonId,
        ),
      ),
    ),
  );
}
