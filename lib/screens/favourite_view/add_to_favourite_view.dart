import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/models/hostel_model.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:iconly/iconly.dart';

class AddToFavouriteView extends StatefulWidget {
  const AddToFavouriteView({super.key});

  @override
  State<AddToFavouriteView> createState() => _AddToFavouriteViewState();
}

class _AddToFavouriteViewState extends State<AddToFavouriteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: FirebaseAnimatedList(
            query: hostelDatabase,
            itemBuilder: (context, snapshot, animation, index) {
              if (snapshot.value != null) {
                final dataId = snapshot.child('dataId').value;
                final imageUrl = snapshot.child('imageUrl').value;

                HostelModel hostelModel = HostelModel(
                  hostelName: snapshot
                      .child('hostelData')
                      .child('hostelName')
                      .value
                      .toString(),
                  userId: snapshot
                      .child('hostelData')
                      .child('userId')
                      .value
                      .toString(),
                  hostelType: snapshot
                      .child('hostelData')
                      .child('hostelType')
                      .value
                      .toString(),
                  hostelLocation: snapshot
                      .child('hostelData')
                      .child('hostelLocation')
                      .value
                      .toString(),
                  description: snapshot
                      .child('hostelData')
                      .child('description')
                      .value
                      .toString(),
                  roomType: snapshot
                      .child('hostelData')
                      .child('roomType')
                      .value
                      .toString(),
                  noOfRoom: snapshot
                      .child('hostelData')
                      .child('noOfRoom')
                      .value
                      .toString(),
                  wifiAvailable: snapshot
                      .child('hostelData')
                      .child('wifiAvailable')
                      .value
                      .toString(),
                  bathroomAvailable: snapshot
                      .child('hostelData')
                      .child('bathroomAvailable')
                      .value
                      .toString(),
                  parkingvailable: snapshot
                      .child('hostelData')
                      .child('parkingvailable')
                      .value
                      .toString(),
                  foodServicesAvailable: snapshot
                      .child('hostelData')
                      .child('foodServicesAvailable')
                      .value
                      .toString(),
                  transportavailable: snapshot
                      .child('hostelData')
                      .child('transportavailable')
                      .value
                      .toString(),
                );

                // debugPrint(hostelData.toString());
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: imageUrl.toString(),
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(
                        IconlyBold.profile,
                        color: Colors.white,
                      ),
                    ),
                    Text(dataId.toString()),
                    Text(hostelModel.bathroomAvailable),
                    Text(hostelModel.description),
                    Text(hostelModel.foodServicesAvailable),
                    Text(hostelModel.hostelLocation),
                    Text(hostelModel.hostelName),
                    Text(hostelModel.hostelType),
                    Text(hostelModel.noOfRoom),
                    Text(hostelModel.parkingvailable),
                    Text(hostelModel.roomType),
                    Text(hostelModel.transportavailable),
                    Text(hostelModel.userId),
                    Text(hostelModel.wifiAvailable),
                  ],
                );
              } else {
                return const Text('No Data');
              }
            },
          ))
        ],
      ),
    );
  }
}
