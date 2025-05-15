import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_api_app/core/repository/character_repository.dart';
import 'package:hp_api_app/features/characters/bloc/character_event.dart';
import 'package:hp_api_app/features/characters/bloc/character_state.dart';
import 'dart:async';
import 'package:hp_api_app/core/models/character.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository _characterRepository;
  List<CharacterModel> _fullCharacterList = [];

  CharacterBloc(this._characterRepository) : super(CharacterInitial()) {
    on<FetchCharacters>((event, emit) async {
      emit(CharacterLoading());
      try {
        final Future<List<CharacterModel>> fetchOperation =
            _characterRepository.getCharacter();
        final characters = await fetchOperation.timeout(
          const Duration(seconds: 10),
        );
        _fullCharacterList = characters;
        emit(CharacterLoaded(_fullCharacterList));
      } on TimeoutException catch (e) {
        emit(CharacterError('Karakter listesi alınamadı, zaman aşımı (BLoC).'));
      } catch (e) {
        emit(CharacterError(e.toString()));
      }
    });

    on<FilterCharacters>((event, emit) {
      final query = event.query.toLowerCase();
      if (query.isEmpty) {
        emit(CharacterLoaded(_fullCharacterList));
      } else {
        final filteredList =
            _fullCharacterList.where((character) {
              return character.name.toLowerCase().contains(query) ||
                  character.house.toLowerCase().contains(query) ||
                  character.actor.toLowerCase().contains(query);
            }).toList();
        emit(CharacterLoaded(filteredList));
      }
    });

    on<FetchCharacterById>((event, emit) async {
      emit(CharacterLoading());
      try {
        final characterModel = await _characterRepository.getCharacterById(
          event.id,
        );
        emit(CharacterDetailLoaded(characterModel));
      } catch (e) {
        emit(CharacterError(e.toString()));
      }
    });
  }
}
