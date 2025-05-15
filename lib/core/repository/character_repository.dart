

import 'package:hp_api_app/core/models/character.dart';
import 'package:hp_api_app/core/services/character_service.dart';

class CharacterRepository{
  final CharacterService _characterService;

  CharacterRepository(this._characterService);

  Future<List<CharacterModel>> getCharacter() async {
    return await _characterService.fetchAllCharacter();
 }

 Future<CharacterModel> getCharacterById(String id) async{
    return await _characterService.fetchCharacterById(id);
 }
}