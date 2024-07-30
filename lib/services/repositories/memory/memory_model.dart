class MemoryModel {
  String? userId;
  String? title;
  DateTime? date;
  String? location;
  String? story;
  List<String>? photoUrls;

  MemoryModel({
    required this.userId,
    required this.date,
    required this.location,
    required this.story,
    required this.title,
    this.photoUrls,
  });

  // Convert a MemoryModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'date': date?.toIso8601String(),
      'location': location,
      'story': story,
      'photoUrls': photoUrls,
    };
  }

  // Create a MemoryModel instance from a JSON map
factory MemoryModel.fromJson(Map<String, dynamic> json) {
  return MemoryModel(
    userId: json['userId'],
    title: json['title'],
    date: DateTime.parse(json['date']),
    location: json['location'],
    story: json['story'],
    photoUrls: (json['photoUrls'] as List<dynamic>?)?.map((url) => url as String).toList(),
  );
}

}

class MemoryList {
  List<MemoryModel>? memories;

  MemoryList({this.memories});

  // Convert a MemoryList instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'memories': memories?.map((memory) => memory.toJson()).toList(),
    };
  }

  // Create a MemoryList instance from a JSON map
  factory MemoryList.fromJson(Map<String, dynamic> json) {
    return MemoryList(
      memories: (json['memories'] as List<dynamic>?)
          ?.map((memoryJson) => MemoryModel.fromJson(memoryJson as Map<String, dynamic>))
          .toList(),
    );
  }
}

