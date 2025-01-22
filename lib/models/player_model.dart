class PlayerModel {
  final String nickname;
  final String socketId;
  final double points;
  final String playerType;

  PlayerModel(
      {required this.nickname,
      required this.socketId,
      required this.points,
      required this.playerType});

  // Convert the PlayerModel instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketId': socketId,
      'points': points,
      'playerType': playerType,
    };
  }

  // Create a PlayerModel instance from a Map
  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      nickname: map['nickname'] as String,
      socketId: map['socketId'] as String,
      points: (map['points'] as num).toDouble(), // Ensure points is a double
      playerType: map['playerType'] as String,
    );
  }

  // Create a copy of PlayerModel with updated values
  PlayerModel copyWith({
    String? nickname,
    String? socketId,
    double? points,
    String? playerType,
  }) {
    return PlayerModel(
      nickname: nickname ?? this.nickname,
      socketId: socketId ?? this.socketId,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
    );
  }
}
