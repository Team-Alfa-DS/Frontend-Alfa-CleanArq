

class TagMapper {
  static List<String> fromJson(Map<String, String> json) {
    return (json['tagNames'] as List).map((tag) => tag.toString()).toList();
    // for (var tag in tagList) {
      
    // }
  }
}