import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_api_app/core/repository/character_repository.dart';
import 'package:hp_api_app/features/characters/bloc/character_bloc.dart';
import 'package:hp_api_app/features/characters/screens/character_list_screen.dart';

import 'core/services/character_service.dart';
import 'features/characters/bloc/character_event.dart';

void main() {
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider<CharacterBloc>(
              create: (context) => CharacterBloc(CharacterRepository(CharacterService()))..add(FetchCharacters()),

          ),
        ],
         child: MainApp() )
    );

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: CharacterListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
