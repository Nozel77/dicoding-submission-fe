import 'package:dicoding_submission/controllers/anime_controller.dart';
import 'package:dicoding_submission/controllers/auth_controller.dart';
import 'package:dicoding_submission/models/banner_model.dart';
import 'package:dicoding_submission/models/user_model.dart';
import 'package:dicoding_submission/routes/routes.dart';
import 'package:dicoding_submission/utils/themes.dart';
import 'package:dicoding_submission/widgets/common_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<BannerModel?> bannerData;
  Future<UserModel?>? userData;

  @override
  void initState() {
    super.initState();
    userData = AuthController().me();
    bannerData = AnimeController().getBannerAnime();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<UserModel?>(
                      future: userData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: orientation == Orientation.portrait ? 60 : 40,
                              height: orientation == Orientation.portrait ? 60 : 40,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error loading user data');
                        } else if (!snapshot.hasData) {
                          return Text('No user data');
                        } else {
                          return Row(
                            children: [
                              CircleAvatar(
                                radius: orientation == Orientation.portrait ? 30 : 20,
                                backgroundImage: snapshot.data?.avatar != null
                                    ? NetworkImage(snapshot.data!.avatar)
                                    : AssetImage('assets/images/profile.png') as ImageProvider,
                              ),
                              SizedBox(width: orientation == Orientation.portrait ? 25 : 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[400]!,
                                    highlightColor: Colors.grey[300]!,
                                    child: Text('Selamat Datang', style: tsTextMediumGrey),
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[400]!,
                                    highlightColor: Colors.grey[300]!,
                                    child: Text(
                                      snapshot.data!.name,
                                      style: tsTextSemiBoldWhite,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.notification);
                                },
                                icon: Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                  size: orientation == Orientation.portrait ? 24 : 20,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    SizedBox(height: orientation == Orientation.portrait ? 30 : 20),
                    FutureBuilder<BannerModel?>(
                      future: bannerData,
                      builder: (context, snapshot) {
                        final banners = snapshot.data?.data ?? [];
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 200,
                              color: Colors.grey,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error loading banners"));
                        } else if (banners.isEmpty) {
                          return Center(child: Text("No banners available"));
                        } else {
                          return FlutterCarousel(
                            options: FlutterCarouselOptions(
                              height: orientation == Orientation.portrait ? 200 : 150,
                              autoPlay: true,
                              showIndicator: true,
                              viewportFraction: 1,
                              enableInfiniteScroll: true,
                              slideIndicator: CircularSlideIndicator(
                                slideIndicatorOptions: SlideIndicatorOptions(
                                  alignment: Alignment.bottomCenter,
                                  padding: EdgeInsets.only(top: 10.0),
                                  indicatorRadius: 4.0,
                                  itemSpacing: 15.0,
                                  currentIndicatorColor: bgButton,
                                ),
                              ),
                            ),
                            items: banners.map((banner) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Image.network(
                                      banner.image!,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                    SizedBox(height: orientation == Orientation.portrait ? 25 : 15),
                    CommonList(
                      textName: 'Ongoing Anime',
                      keyEndpoint: 'ongoing',
                      isPortrait: orientation == Orientation.portrait,
                    ),
                    SizedBox(height: orientation == Orientation.portrait ? 30 : 20),
                    CommonList(
                      textName: 'Popular Anime',
                      keyEndpoint: 'popular',
                      isPortrait: orientation == Orientation.portrait,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
