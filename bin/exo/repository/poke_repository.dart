import 'dart:convert';

import '../models/pokemon.dart';
import 'package:http/http.dart' as http;

class PokeRepository {
  const PokeRepository();

  Future<List<Pokemon>> fetchPokemons({int chunkSize = 50}) async {
    final response = await http.get(
        Uri.parse('https://pokebuildapi.fr/api/v1/pokemon/limit/$chunkSize'));
    if (response.statusCode == 200) {
      final jsonArray = jsonDecode(response.body) as List? ?? [];
      final pokemons = jsonArray
          .cast<Map<String, dynamic>>()
          .map((json) => Pokemon.fromJson(json))
          .toList();
      return pokemons;
    } else {
      throw Exception('Failed to fetch Pokemon');
    }
  }
}

const pokeRepository = PokeRepository();
