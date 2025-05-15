import 'package:flutter/foundation.dart';

@immutable
class Wand {
  final String wood;
  final String core;
  final double? length;

  const Wand({required this.wood, required this.core, this.length});

  factory Wand.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const Wand(wood: '', core: '', length: null);
    }
    return Wand(
      wood: json['wood'] ?? '',
      core: json['core'] ?? '',
      length:
          (json['length'] is num) ? (json['length'] as num).toDouble() : null,
    );
  }
}

@immutable
class CharacterModel {
  final String id;
  final String name;
  final List<dynamic> alternateNames;
  final String house;
  final String actor;
  final String patronus;
  final Wand wand;
  final bool alive;
  final String image;

  const CharacterModel({
    required this.id,
    required this.name,
    required this.alternateNames,
    required this.house,
    required this.actor,
    required this.patronus,
    required this.wand,
    required this.alive,
    required this.image,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      alternateNames: json['alternate_names'],
      house: json['house'] ?? '',
      actor: json['actor'] ?? '',
      patronus: json['patronus'] ?? '',
      wand: Wand.fromJson(json['wand']),
      alive: json['alive'] ?? false,
      image: json['image'] ?? '',
    );
  }
}
