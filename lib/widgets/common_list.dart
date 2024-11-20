import 'package:flutter/material.dart';
import 'package:dicoding_submission/utils/themes.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/anime_controller.dart';
import '../models/anime_model.dart';
import '../routes/routes.dart';

class CommonList extends StatefulWidget {
  const CommonList({
    super.key,
    required this.textName,
    required this.keyEndpoint,
    required this.isPortrait,
  });

  final String textName;
  final String keyEndpoint;
  final isPortrait;

  @override
  CommonListState createState() => CommonListState();
}

class CommonListState extends State<CommonList> {
  late Future<AnimeModel?> animeData;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    if (widget.keyEndpoint == 'ongoing') {
      animeData = AnimeController().getOngoingAnime();
    } else {
      animeData = AnimeController().getPopularAnime();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textName,
          style: tsBoldWhite,
        ),
        SizedBox(height: 20),
        Container(
          height: 250,
          child: FutureBuilder<AnimeModel?>(
            future: animeData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: Colors.grey[300]!,
                      child: Card(
                        color: primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white,
                              width: 150,
                              height: 200,
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 150),
                                child: Container(
                                  height: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError || !snapshot.hasData) {
                return Center(child: Text("Failed to load anime data"));
              } else {
                final animeList = snapshot.data?.data ?? [];
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: animeList.length,
                  itemBuilder: (context, index) {
                    final anime = animeList[index];
                    return GestureDetector(
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          Routes.detail,
                          arguments: anime,
                        );
                        if (result != null && result == true) {
                          setState(() {
                            loadData();
                          });
                        }
                      },
                      child: Card(
                        color: primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              anime.image ?? 'https://via.placeholder.com/150',
                              fit: BoxFit.cover,
                              width: 150,
                              height: 200,
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 150),
                                child: Text(
                                  anime.title ?? 'No title',
                                  style: tsTextSemiBoldWhite,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
