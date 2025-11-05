import 'package:flutter/material.dart';
import '../models/pokemon_card.dart';
import '../utils.dart';

class PokemonScreen extends StatefulWidget {
  final String cardId;

  const PokemonScreen({super.key, required this.cardId});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  late Future<PokemonCard> _cardDetailFuture;

  @override
  void initState() {
    super.initState();
    _cardDetailFuture = fetchCardDetails(widget.cardId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonCard>(
      future: _cardDetailFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        if (snapshot.hasData) {
          final card = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(card.name),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Hero(
                      tag: card.id,
                      child: Image.network(card.imageHigh, height: 400),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Card Info'),
                  _buildInfoCard(card),
                  const SizedBox(height: 24),
                  if (card.attacks != null && card.attacks!.isNotEmpty)
                    _buildSectionTitle('Attacks'),
                  if (card.attacks != null)
                    ...card.attacks!.map((attack) => _buildAttackCard(attack)).toList(),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: Text('No data')),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildInfoCard(PokemonCard card) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoRow('HP', card.hp?.toString() ?? 'N/A'),
            _buildInfoRow('Types', card.types?.join(', ') ?? 'N/A'),
            _buildInfoRow('Rarity', card.rarity ?? 'N/A'),
            _buildInfoRow('Illustrator', card.illustrator ?? 'N/A'),
            _buildInfoRow('Retreat Cost', card.retreat?.toString() ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildAttackCard(Attack attack) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text('${attack.name} - ${attack.damage ?? ''}', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(attack.effect ?? 'No effect description.'),
        trailing: Text('Cost: ${attack.cost.join(', ')}'),
      ),
    );
  }
}