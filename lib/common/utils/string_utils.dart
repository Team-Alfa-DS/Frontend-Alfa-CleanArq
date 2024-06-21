// lib/common/string_utils.dart
String getFirstTwoWords(String name) {
  final words = name.split(' ');
  if (words.length > 1) {
    return '${words[0]} ${words[1]}';
  }
  return name;
}
