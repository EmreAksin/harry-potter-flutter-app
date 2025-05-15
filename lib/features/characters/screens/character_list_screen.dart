import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_api_app/features/characters/bloc/character_bloc.dart';
import 'package:hp_api_app/features/characters/bloc/character_event.dart';
import 'package:hp_api_app/features/characters/bloc/character_state.dart';
import 'package:hp_api_app/features/characters/screens/character_detail_screen.dart';
import 'package:hp_api_app/features/characters/widgets/character_search_bar.dart';
import 'package:hp_api_app/features/characters/widgets/character_list_item.dart';

// Karakter listesini gösteren ana ekran
class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  // CharacterBloc örneğini saklamak için bir değişken
  late CharacterBloc _characterBloc;

  @override
  void initState() {
    super.initState();
    _characterBloc = context.read<CharacterBloc>();
    _characterBloc.add(FetchCharacters());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Karakterler")),
      body: Column(
        children: [
          const CharacterSearchBar(),
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                if (state is CharacterLoaded) {
                  if (state.characters.isEmpty) {
                    return const Center(
                      child: Text("Karakter bulunamadı veya arama sonucu boş."),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: state.characters.length,
                    itemBuilder: (context, index) {
                      final character = state.characters[index];
                      return CharacterListItem(
                        character: character,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => CharacterDetailScreen(
                                    characterId: character.id,
                                  ),
                            ),
                          );
                          if (mounted) {
                            _characterBloc.add(FetchCharacters());
                          }
                        },
                      );
                    },
                  );
                } else if (state is CharacterError) {
                  return Center(child: Text('Hata: ${state.message}'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
