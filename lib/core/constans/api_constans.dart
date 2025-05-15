class ApiConstans {
  static const String baseUrl = "https://hp-api.onrender.com";
  static const String getAllCharacters = "/api/characters";
  static String getCharacterById(String id) {
    return "/api/character/$id";
  }
}
