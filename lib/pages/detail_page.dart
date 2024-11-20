import 'package:flutter/material.dart';
import '../controllers/anime_controller.dart';
import '../models/anime_model.dart';
import '../utils/themes.dart';

class DetailPage extends StatefulWidget {
  final Anime anime;
  final bool isLiked;
  const DetailPage({super.key, required this.anime, required this.isLiked});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isBookmarked = false;
  final AnimeController animeController = AnimeController();

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.anime.isLiked ?? false;
  }

  Future<void> _handleAddToWatchlist() async {
    await animeController.addWatchlistAnime(widget.anime.id!);
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Container(
          width: double.infinity,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: bgButton,
                ),
              ),
              Spacer(flex: 10),
              IconButton(
                onPressed: _handleAddToWatchlist,
                icon: Icon(
                  isBookmarked ? Icons.bookmark_add : Icons.bookmark_add,
                  color: isBookmarked ? bgButton : primaryText,
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: primaryText),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.anime.image!,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 20),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(widget.anime.title!, style: tsTextSemiBoldWhite),
                          SizedBox(height: 5),
                          Text('Genres : ${widget.anime.genre}', style: tsTextRegularWhite),
                          Text('Status : ${widget.anime.status}', style: tsTextRegularWhite),
                          Text('Type : ${widget.anime.type}', style: tsTextRegularWhite),
                          Text('Episode : ${widget.anime.episodes}', style: tsTextRegularWhite),
                          Text('Duration : ${widget.anime.duration}', style: tsTextRegularWhite),
                          Text('Studios : ${widget.anime.studio}', style: tsTextRegularWhite),
                          Text('Rating', style: tsTextRegularWhite),
                          SizedBox(height: 10),
                          Text(
                            widget.anime.rating!,
                            style: tsTextSemiBoldWhite20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text('Synopsis', style: tsBoldWhite),
              SizedBox(height: 10),
              Text(
                widget.anime.synopsis!,
                style: tsTextRegularWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
