import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_api_app/features/characters/bloc/character_bloc.dart';
import 'package:hp_api_app/features/characters/bloc/character_event.dart';

// Karakter arama çubuğu widget'ı
class CharacterSearchBar extends HookWidget {
  const CharacterSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = useTextEditingController();
    final timer = useState<Timer?>(null);

    // searchController.text değiştiğinde çalışacak effect
    useEffect(() {
      void listener() {
        // Önceki timer varsa iptal et
        if (timer.value?.isActive ?? false) {
          timer.value!.cancel();
        }
        // Yeni bir timer başlat
        timer.value = Timer(const Duration(milliseconds: 500), () {
          if (context.mounted) {
            final query = searchController.text;

            context.read<CharacterBloc>().add(FilterCharacters(query));
          }
        });
      }

      searchController.addListener(listener);

      return () {
        searchController.removeListener(listener);
        timer.value?.cancel();
      };
    }, [searchController]);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Karakter, ev veya aktör ara...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200], // Arka plan rengi
        ),
      ),
    );
  }
}
