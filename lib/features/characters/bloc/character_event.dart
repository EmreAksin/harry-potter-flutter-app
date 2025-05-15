abstract class CharacterEvent {}

class FetchCharacters extends CharacterEvent {
  FetchCharacters();
}

class FetchCharacterById extends CharacterEvent {
  final String id;
  FetchCharacterById(this.id);
}

class FilterCharacters extends CharacterEvent {
  final String query;
  FilterCharacters(this.query);
}
