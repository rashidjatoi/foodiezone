import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconly/iconly.dart';

class FoodProviderDetailsToClientView extends StatefulWidget {
  final Map<String, dynamic> userData;

  const FoodProviderDetailsToClientView({super.key, required this.userData});

  @override
  State<FoodProviderDetailsToClientView> createState() =>
      _FoodProviderDetailsToClientViewState();
}

class _FoodProviderDetailsToClientViewState
    extends State<FoodProviderDetailsToClientView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userData['username']),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Card(
            child: SizedBox(
              height: 140,
              child: Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.userData['userImage'],
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(), // Placeholder while loading
                      errorWidget: (context, url, error) => const Icon(
                          IconlyBold.profile,
                          color: Colors.white), // Error widget
                    ),
                  ),
                  const SizedBox(width: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.userData['username'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: "DMSans Bold",
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.userData['address']),
                          Text(widget.userData['phone']),
                        ],
                      ),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 4,
                        ),
                        onRatingUpdate: (rating) {
                          debugPrint(rating.toString());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
