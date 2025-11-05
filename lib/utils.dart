import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models/pokemon_card.dart';

Future<List<PokemonCard>> fetchPokemonData() async {
  final response = await http.Client()
      .get(Uri.parse('https://api.tcgdex.net/v2/en/sets/sv03.5'));

  // Parsing the JSON in the background using compute()
  // to avoid app freeze while processing
  // See https://docs.flutter.dev/cookbook/networking/background-parsing
  return compute(
    parsePokemonCards,
    response.body,
  );
}

List<PokemonCard> parsePokemonCards(String responseBody) {
  final parsed = jsonDecode(responseBody) as Map<String, dynamic>;

  return parsed['cards']
      .map<PokemonCard>((json) => PokemonCard.fromJson(json))
      .toList();
}

Future<PokemonCard> fetchCardDetails(String cardId) async {
  final response =
      await http.get(Uri.parse('https://api.tcgdex.net/v2/en/cards/$cardId'));

  if (response.statusCode == 200) {
    return PokemonCard.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load card details');
  }
}
