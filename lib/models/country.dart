class Country {
  final int id;
  final String team;
  final String group;
  final String flagImage;
  final int voteCount;

  Country({
    required this.id,
    required this.team,
    required this.group,
    required this.flagImage,
    required this.voteCount,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      team: json['team'],
     group: json['group'],
      flagImage: json['flagImage'],
      voteCount: json['voteCount'],
    );
  }

  // named constructor
  Country.fromJson2(Map<String, dynamic> json)
      : id = json['id'],
        team = json['team'],
        group = json['group'],
        flagImage = json['flagImage'],
        voteCount = json['voteCount'];
}