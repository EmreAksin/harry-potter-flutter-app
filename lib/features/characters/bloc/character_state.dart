
import 'package:hp_api_app/core/models/character.dart';

abstract class CharacterState{}

class CharacterInitial extends CharacterState{}

class CharacterLoading extends CharacterState{}

class CharacterLoaded extends CharacterState{
  final List<CharacterModel> characters;
  CharacterLoaded(this.characters);
}

class CharacterDetailLoaded extends CharacterState{
  final CharacterModel characterModel;
  CharacterDetailLoaded(this.characterModel);
}

class CharacterError extends CharacterState{
  final String message;
  CharacterError(this.message);
}