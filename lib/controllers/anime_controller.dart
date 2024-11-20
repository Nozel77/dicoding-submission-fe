
import 'package:dicoding_submission/models/banner_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/anime_model.dart';

class AnimeController {
  final String baseUrl = 'https://dicoding-backend.rplrus.com/api';

  //get
  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<AnimeModel?> getAllAnime({String? search}) async {
    final String url = '$baseUrl/anime' + (search != null && search.isNotEmpty ? '?search=$search' : '');
    final String? token = await getAuthToken();
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return AnimeModel.fromJson(jsonResponse);
      } else {
        print("Failed to fetch anime. Status Code : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error while fetching anime: $e");
      return null;
    }
  }

  Future<AnimeModel?> getOngoingAnime() async {
    final String url = '$baseUrl/anime/ongoing';
    final String? token = await getAuthToken();
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return AnimeModel.fromJson(jsonResponse);
      } else {
        print("Failed to fetch anime. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error while fetching anime: $e");
      return null;
    }
  }

  Future<AnimeModel?> getPopularAnime() async {
    final String url = '$baseUrl/anime/popular';
    final String? token = await getAuthToken();
    try {
      final response = await http.get(
          Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return AnimeModel.fromJson(jsonResponse);
      } else {
        print("Failed to fetch anime. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error while fetching anime: $e");
      return null;
    }
  }

  Future<AnimeModel?> getWatchlistAnime({String? search}) async {
    final String url = '$baseUrl/anime/watchlist' + (search != null && search.isNotEmpty ? '?search=$search' : '');
    try {
      final String? token = await getAuthToken();
      if (token == null) {
        debugPrint("Error: Auth token is missing");
        return null;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return AnimeModel.fromJson(jsonResponse);
      } else {
        debugPrint("Failed to fetch anime. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error while fetching anime: $e");
      return null;
    }
  }

  Future<BannerModel?> getBannerAnime() async {
    final String url = '$baseUrl/banner';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200){
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return BannerModel.fromJson(jsonResponse);
      } else {
        debugPrint("Failed to fetch anime. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error while fetching anime: $e");
      return null;
    }
  }

  //post
  Future<void> addWatchlistAnime(int animeId) async {
    final String url = '$baseUrl/anime/add-watchlist/$animeId';
    try {
      final String? token = await getAuthToken();
      if (token == null) {
        debugPrint("Error: Auth token is missing");
        return;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'anime_id': animeId,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("Anime successfully added to watchlist.");
      } else {
        debugPrint("Failed to add anime to watchlist. Status code: ${response.statusCode}");
        debugPrint("Response body: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error while adding anime to watchlist: $e");
    }
  }


}


