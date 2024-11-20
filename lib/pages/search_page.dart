import 'dart:async'; // Import Timer
import 'package:dicoding_submission/controllers/anime_controller.dart';
import 'package:dicoding_submission/models/anime_model.dart';
import 'package:dicoding_submission/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/themes.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<AnimeModel?> animeData;
  TextEditingController searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    animeData = AnimeController().getAllAnime();
  }

  void updateSearch(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        animeData = AnimeController().getAllAnime(search: query);
      });
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: animeData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: searchController,
                      onChanged: updateSearch,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                        hintText: 'Cari Anime ...',
                        hintStyle: tsTextRegularWhite,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: bgForm,
                      ),
                      style: tsTextMediumWhite,
                    ),
                  ),
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: Colors.grey[300]!,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              // Shimmer for Image (with size same as real image)
                              Container(
                                width: 150, // Adjust with desired image width
                                height: 200, // Adjust with desired image height
                                color: Colors.white,
                              ),
                              SizedBox(width: 20),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Shimmer for Title Text
                                    Container(
                                      height: 20,
                                      width: double.infinity,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    // Shimmer for Genre Text
                                    Container(
                                      height: 15,
                                      width: 200,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    // Shimmer for Status Text
                                    Container(
                                      height: 15,
                                      width: 150,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    // Shimmer for Type Text
                                    Container(
                                      height: 15,
                                      width: 120,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    // Shimmer for Episode Text
                                    Container(
                                      height: 15,
                                      width: 100,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    // Shimmer for Duration Text
                                    Container(
                                      height: 15,
                                      width: 140,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    // Shimmer for Studios Text
                                    Container(
                                      height: 15,
                                      width: 140,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    // Shimmer for Rating Text
                                    Container(
                                      height: 20,
                                      width: 80,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 5, // Show shimmer for 5 items
                        padding: const EdgeInsets.only(top: 20),
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError || !snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: searchController,
                      onChanged: updateSearch,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                        hintText: 'Cari Anime ...',
                        hintStyle: tsTextRegularWhite,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: bgForm,
                      ),
                      style: tsTextMediumWhite,
                    ),
                  ),
                  Center(
                    child: Text("Failed to load anime data", style: tsTextRegularWhite),
                  ),
                ],
              );
            } else {
              final animeList = snapshot.data?.data ?? [];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: searchController,
                      onChanged: updateSearch,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                        hintText: 'Cari Anime ...',
                        hintStyle: tsTextRegularWhite,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: bgForm,
                      ),
                      style: tsTextMediumWhite,
                    ),
                  ),
                  if (animeList.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          "Tidak ada anime ditemukan",
                          style: tsTextRegularWhite,
                        ),
                      ),
                    ),
                  if (animeList.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final anime = animeList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () async {
                                final result = await Navigator.pushNamed(
                                    context, Routes.detail, arguments: anime);

                                if (result != null && result is bool && result) {
                                  setState(() {
                                    animeData = AnimeController().getAllAnime(search: searchController.text);
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(anime.image!, width: 150, fit: BoxFit.cover),
                                  SizedBox(width: 20),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          anime.title!,
                                          style: tsTextSemiBoldWhite,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Text('Genres : ${anime.genre}', style: tsTextRegularWhite, maxLines: 1, overflow: TextOverflow.ellipsis),
                                        Text('Status : ${anime.status}', style: tsTextRegularWhite),
                                        Text('Type : ${anime.type}', style: tsTextRegularWhite),
                                        Text('Episode : ${anime.episodes}', style: tsTextRegularWhite),
                                        Text('Duration : ${anime.duration}', style: tsTextRegularWhite),
                                        Text('Studios : ${anime.studio}', style: tsTextRegularWhite),
                                        Text('Rating', style: tsTextRegularWhite),
                                        SizedBox(height: 10),
                                        Text(anime.rating!, style: tsTextSemiBoldWhite20),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: animeList.length,
                        padding: const EdgeInsets.only(top: 20),
                      ),
                    )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
