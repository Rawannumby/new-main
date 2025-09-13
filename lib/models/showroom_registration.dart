class ShowroomRegistration {
  final String name;
  final String businessDetails;
  final String artistStory;

  ShowroomRegistration({
    required this.name,
    required this.businessDetails,
    required this.artistStory,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'businessDetails': businessDetails,
    'artistStory': artistStory,
  };
}
