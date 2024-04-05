class Stats {
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  Stats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  factory Stats.fromList(List<dynamic> jsonList) {
    var statsMap = {
      'hp': 0,
      'attack': 0,
      'defense': 0,
      'special-attack': 0,
      'special-defense': 0,
      'speed': 0,
    };

    for (var statInfo in jsonList) {
      String statName = statInfo['stat']['name'];
      int baseStat = statInfo['base_stat'];

      if (statsMap.containsKey(statName)) {
        statsMap[statName] = baseStat;
      }
    }

    return Stats(
      hp: statsMap['hp']!,
      attack: statsMap['attack']!,
      defense: statsMap['defense']!,
      specialAttack: statsMap['special-attack']!,
      specialDefense: statsMap['special-defense']!,
      speed: statsMap['speed']!,
    );
  }

  int get total =>
      hp + attack + defense + specialAttack + specialDefense + speed;

  Map<String, int> toMap() {
    return {
      'HP': hp,
      'ATK': attack,
      'DEF': defense,
      'SP.ATK': specialAttack,
      'SP.DEF': specialDefense,
      'SPD': speed,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return Stats(
      hp: map['hp'],
      attack: map['attack'],
      defense: map['defense'],
      specialAttack: map['special_attack'],
      specialDefense: map['special_defense'],
      speed: map['speed'],
    );
  }
}
