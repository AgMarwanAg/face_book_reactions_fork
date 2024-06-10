class ReactionData {
  static List<ReactionAsset> facebookReactionIcon = [
    ReactionAsset(
      name: "like",
      path: 'assets/reactions/like.json',
    ),
    ReactionAsset(
      name: "sad",
      path: 'assets/reactions/sad.json',
    ),
    ReactionAsset(
      name: "love",
      path: 'assets/reactions/love.json',
    ),
  ];
}

class ReactionAsset {
  String name;
  String path;
  ReactionAsset({required this.name, required this.path});
}
