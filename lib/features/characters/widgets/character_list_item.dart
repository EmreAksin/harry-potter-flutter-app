import 'package:flutter/material.dart';
import 'package:hp_api_app/core/models/character.dart';

class CharacterListItem extends StatelessWidget {
  final CharacterModel character;
  final VoidCallback onTap;

  const CharacterListItem({
    super.key,
    required this.character,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        leading:
            character.image.isNotEmpty
                ? CircleAvatar(
                  backgroundImage: NetworkImage(character.image),
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child:
                      character.image.isEmpty
                          ? const Icon(Icons.person, size: 30)
                          : null,
                  onBackgroundImageError: (exception, stackTrace) {},
                )
                : CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, size: 30),
                ),
        onTap: onTap,
        title: Text(
          character.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.house_outlined, size: 16, color: Colors.teal[700]),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    character.house.isNotEmpty
                        ? character.house
                        : "Evi bilinmiyor",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 16,
                  color: Colors.blueGrey[700],
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    character.actor.isNotEmpty
                        ? character.actor
                        : "Aktör bilinmiyor",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
