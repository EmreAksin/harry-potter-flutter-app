import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_api_app/features/characters/widgets/character_detail_card.dart';
import '../bloc/character_bloc.dart';
import '../bloc/character_event.dart';
import '../bloc/character_state.dart';

class CharacterDetailScreen extends StatefulWidget {
  final String characterId;
  const CharacterDetailScreen({required this.characterId, super.key});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(FetchCharacterById(widget.characterId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Karakter Detayı')),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharacterDetailLoaded) {
            return CharacterDetailCard(character: state.characterModel);
          } else if (state is CharacterError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Karakter detayı yüklenirken bir hata oluştu:\n${state.message}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            );
          } else if (state is CharacterInitial) {
            return const Center(child: Text("Karakter detayı bekleniyor..."));
          }
          return const Center(child: Text("Bir şeyler ters gitti."));
        },
      ),
    );
  }
}
