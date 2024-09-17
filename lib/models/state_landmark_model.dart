class StateLandmark {
  final String state;
  final List<String> landmarks;

  StateLandmark({required this.state, required this.landmarks});

  Map<String, dynamic> toMap() {
    return {
      'state': state,
      'landmarks': landmarks,
    };
  }

  factory StateLandmark.fromMap(Map<String, dynamic> map) {
    return StateLandmark(
      state: map['state'] ?? '',
      landmarks: List<String>.from(map['landmarks'] ?? []),
    );
  }
}
