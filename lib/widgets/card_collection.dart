import 'package:flutter/material.dart';

import '../models/pokemon_card.dart';
import 'card_item.dart';

class CardCollection extends StatelessWidget {
  final List<PokemonCard> pokemonCards;

  const CardCollection({
    super.key,
    required this.pokemonCards,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.5,
        crossAxisCount: 2,
      ),
      itemCount: pokemonCards.length,
      itemBuilder: (context, index) {
        return CardItem(pokemon: pokemonCards[index]);
      },
    );
  }
}
