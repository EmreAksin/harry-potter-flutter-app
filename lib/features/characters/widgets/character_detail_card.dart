import 'package:flutter/material.dart';
import 'package:hp_api_app/core/models/character.dart';

class CharacterDetailCard extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailCard({super.key, required this.character});

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: iconColor ?? theme.colorScheme.primary),
          const SizedBox(width: 12),
          Text(
            "$label: ",
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : "Bilinmiyor",
              style: theme.textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWandDetails(BuildContext context, Wand wand) {
    final theme = Theme.of(context);
    if (wand.wood.isEmpty && wand.core.isEmpty && wand.length == null) {
      return _buildInfoRow(
        context,
        icon: Icons.auto_fix_high,
        label: "Asa",
        value: "Bilgisi yok",
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_fix_high,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Text(
                "Asa Bilgileri:",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32, top: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (wand.wood.isNotEmpty)
                  Text(
                    " • Ağaç: ${wand.wood}",
                    style: theme.textTheme.titleSmall,
                  ),
                if (wand.core.isNotEmpty)
                  Text(
                    " • Öz: ${wand.core}",
                    style: theme.textTheme.titleSmall,
                  ),
                if (wand.length != null)
                  Text(
                    " • Uzunluk: ${wand.length} inç",
                    style: theme.textTheme.titleSmall,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child:
                    character.image.isNotEmpty
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            character.image,
                            height: screenSize.height * 0.35,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return SizedBox(
                                height: screenSize.height * 0.35,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: screenSize.height * 0.35,
                                width: screenSize.width * 0.6,
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.broken_image,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        )
                        : Container(
                          height: screenSize.height * 0.35,
                          width: screenSize.width * 0.6,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Icon(
                            Icons.person_off,
                            size: 80,
                            color: Colors.grey,
                          ),
                        ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  character.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              if (character.alternateNames.isNotEmpty)
                Center(
                  child: Text(
                    "(${character.alternateNames.join(", ")})",
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 12),
              Divider(color: Colors.grey[300]),
              const SizedBox(height: 12),
              _buildInfoRow(
                context,
                icon: Icons.house_outlined,
                label: "Ev",
                value: character.house,
              ),
              _buildInfoRow(
                context,
                icon: Icons.person_outline,
                label: "Aktör",
                value: character.actor,
              ),
              _buildInfoRow(
                context,
                icon: Icons.shield_outlined,
                label: "Patronus",
                value: character.patronus,
              ),
              _buildInfoRow(
                context,
                icon: character.alive ? Icons.favorite : Icons.heart_broken,
                label: "Durum",
                value: character.alive ? "Hayatta" : "Hayatta Değil",
                iconColor: character.alive ? Colors.green : Colors.red,
              ),
              _buildWandDetails(context, character.wand),
            ],
          ),
        ),
      ),
    );
  }
}
