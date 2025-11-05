class Attack {
  final String name;
  final List<String> cost;
  final String? effect;
  final String? damage;

  Attack({required this.name, required this.cost, this.effect, this.damage});

  factory Attack.fromJson(Map<String, dynamic> json) {
    return Attack(
      name: json['name'] as String,
      cost: (json['cost'] as List).map((item) => item as String).toList(),
      effect: json['effect'] as String?,
      damage: json['damage']?.toString(),
    );
  }
}

class PokemonCard {
  final String id;
  final String image;
  final String localId;
  final String name;

  final int? hp;
  final List<String>? types;
  final int? retreat;
  final List<Attack>? attacks;
  final String? rarity;
  final String? illustrator;

  bool isChecked = false;

  PokemonCard({
    required this.id,
    required this.image,
    required this.localId,
    required this.name,
    this.hp,
    this.types,
    this.retreat,
    this.attacks,
    this.rarity,
    this.illustrator,
  });

  String get imageLow => '$image/low.png';
  String get imageHigh => '$image/high.png';

  void toggleIsChecked() {
    isChecked = !isChecked;
  }

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'] as String,
      image: json['image'] as String,
      localId: json['localId'] as String,
      name: json['name'] as String,
      hp: json['hp'] as int?,
      types: (json['types'] as List?)?.map((item) => item as String).toList(),
      retreat: json['retreat'] as int?,
      attacks: (json['attacks'] as List?)
          ?.map((item) => Attack.fromJson(item as Map<String, dynamic>))
          .toList(),
      rarity: json['rarity'] as String?,
      illustrator: json['illustrator'] as String?,
    );
  }
}