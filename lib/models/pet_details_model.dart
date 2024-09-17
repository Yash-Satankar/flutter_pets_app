class PetDetails {
  final String petName;
  final String petCategory;
  final String petAge;
  final String petDescription;
  final String petColor;
  final String? petImage;

  PetDetails({
    required this.petName,
    required this.petCategory,
    required this.petAge,
    required this.petDescription,
    required this.petColor,
    this.petImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'petName': petName,
      'petCategory': petCategory,
      'petAge': petAge,
      'petDescription': petDescription,
      'petColor': petColor,
      'petImage': petImage,
    };
  }

  factory PetDetails.fromMap(Map<String, dynamic> map) {
    return PetDetails(
      petName: map['petName'] ?? '',
      petCategory: map['petCategory'] ?? '',
      petAge: map['petAge'] ?? '',
      petDescription: map['petDescription'] ?? '',
      petColor: map['petColor'] ?? '',
      petImage: map['petImage'],
    );
  }
}
