import 'package:flutter/material.dart';

import '../models/pokemon_card.dart';
import '../screens/pokemon_screen.dart';
import '../widgets/check_box.dart';
import '../widgets/custom_image_network.dart';

class CardItem extends StatelessWidget {
  final PokemonCard pokemon;

  const CardItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridTile(
        header: CheckBox(pokemon: pokemon),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokemonScreen(cardId: pokemon.id),
              ),
            );
          },
          child: Hero(
            tag: pokemon.id,
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    CustomImageNetwork(
                      imageUrl: pokemon.imageLow,
                      height: 164.0,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '#${pokemon.localId}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      pokemon.name,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
