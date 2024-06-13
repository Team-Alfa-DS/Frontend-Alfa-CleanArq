import 'package:flutter_test/flutter_test.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/course/course_mapper.dart';

void main() {
  group('CourseMapper', () {
    test('fromJson should map json to Course', () {
      final json = {
        'id': '1',
        'title': 'Course 1',
        'description': 'This is the description of Course 1',
        'category': 'Category 1',
        'image': 'https://example.com/image1.jpg',
        'trainer': {
          'id': '1',
          'name': 'Trainer 1',
          'followers': 100,
          'userFollow': true,
          'location': 'Location 1',
        },
        'level': 0,
        'durationWeeks': 4,
        'durationMinutes': 60,
        'tags': ['tag1', 'tag2'],
        'date': '2022-01-01T00:00:00.000Z',
        'lessons': [
          {
            'id': '1',
            'title': 'Lesson 1',
            'content': 'This is the content of Lesson 1',
            'video': 'https://example.com/video1.mp4',
          },
        ],
      } as Map<String, dynamic>;

      final course = CourseMapper.fromJson(json);

      expect(course.title, 'Course 1');
      expect(course.description, 'This is the description of Course 1');
      expect(course.category, 'Category 1');
      expect(course.image, 'https://example.com/image1.jpg');
      expect(course.trainer.id, '1');
      expect(course.trainer.name, 'Trainer 1');
      expect(course.trainer.followers, 100);
      expect(course.trainer.userFollow, true);
      expect(course.trainer.location, 'Location 1');
      expect(course.level, 'beginner');
      expect(course.durationWeeks, 4);
      expect(course.durationMinutes, 60);
      expect(course.tags, ['tag1', 'tag2']);
      expect(course.date, DateTime.parse('2022-01-01T00:00:00.000Z'));
      expect(course.lessons.length, 1);
      expect(course.lessons[0].id, '1');
      expect(course.lessons[0].title, 'Lesson 1');
      expect(course.lessons[0].content, 'This is the content of Lesson 1');
      expect(course.lessons[0].video, 'https://example.com/video1.mp4');
    });

    test('toJson should map Course to json', () {
      final trainer = Trainer(
        id: '1',
        name: 'Trainer 1',
        followers: 100,
        userFollow: true,
        location: 'Location 1',
      );

      final course = Course(
        title: 'Course 1',
        description: 'This is the description of Course 1',
        category: 'Category 1',
        image: 'https://example.com/image1.jpg',
        trainer: trainer,
        level: 'begginer',
        durationWeeks: 4,
        durationMinutes: 60,
        tags: ['tag1', 'tag2'],
        date: DateTime.parse('2022-01-01T00:00:00.000Z'),
        lessons: [
          Lesson(
            id: '1',
            title: 'Lesson 1',
            content: 'This is the content of Lesson 1',
            video: 'https://example.com/video1.mp4',
          ),
          Lesson(
            id: '2',
            title: 'Lesson 2',
            content: 'This is the content of Lesson 2',
            video: 'https://example.com/video2.mp4',
          ),
          Lesson(
            id: '3',
            title: 'Lesson 3',
            content: 'This is the content of Lesson 3',
            video: 'https://example.com/video3.mp4',
          ),
        ],
      );

      final json = CourseMapper.toJson(course);

      expect(json['id'], '1');
      expect(json['title'], 'Curso 1');
      expect(json['description'], 'Descripcion 1');
      expect(json['category'], 'Category 1');
      expect(json['image'], 'https://example.com/image1.jpg');
      expect(json['trainer']['id'], '1');
      expect(json['trainer']['name'], 'Trainer 1');
      expect(json['trainer']['followers'], 100);
      expect(json['trainer']['userFollow'], true);
      expect(json['trainer']['location'], 'Location 1');
      expect(json['level'], 0); // Para CourseLevel.beginner
      expect(json['durationWeeks'], 4);
      expect(json['durationMinutes'], 60);
      expect(json['tags'], ['tag1', 'tag2']);
      expect(json['date'], '2022-01-01T00:00:00.000Z');
      expect(json['lessons'].length, 3);
      expect(json['lessons'][0]['id'], '1');
      expect(json['lessons'][0]['title'], 'Lesson 1');
      expect(json['lessons'][0]['content'], 'This is the content of Lesson 1');
      expect(json['lessons'][0]['video'], 'https://example.com/video1.mp4');
    });
  });
}
