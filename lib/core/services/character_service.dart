import 'package:dio/dio.dart';
import 'package:hp_api_app/core/constans/api_constans.dart';
import 'package:hp_api_app/core/models/character.dart';

class CharacterService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstans.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<List<CharacterModel>> fetchAllCharacter() async {
    try {
      ;
      final response = await _dio.get(ApiConstans.getAllCharacters);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        return data.map((item) => CharacterModel.fromJson(item)).toList();
      } else {
        throw Exception('Karakter alınamadı (Service): ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CharacterModel> fetchCharacterById(String id) async {
    try {
      final endpoint = ApiConstans.getCharacterById(id);

      final response = await _dio.get(endpoint);
      if (response.statusCode == 200) {
        List<dynamic> dataList = response.data;
        return CharacterModel.fromJson(dataList[0]);
      } else {
        throw Exception(
          'Karakter alınamadı (Service - ID: $id): ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
