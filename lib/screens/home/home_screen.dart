import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/models/hostel_model.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:get/get.dart';
// import 'package:hostelbazaar/constants/images.dart';
// import 'package:hostelbazaar/views/home/widgets/product_list_widget.dart';
import 'package:iconly/iconly.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> cityNames = [
      "Hyderabad",
      "Jamshoro",
      "Nawabshah",
      "Karachi",
      "Tando Allahyar",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FoodieZone.",
          style: TextStyle(fontFamily: "DMsans-Medium"),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyLight.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeaderWidget(),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Suitable Food Palces",
                    style: TextStyle(
                      fontFamily: "Roboto Bold",
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CustomSuitableWidget(),
                  const SizedBox(height: 25),
                  const Text(
                    "Popular Food Places",
                    style: TextStyle(
                      fontFamily: "Roboto Bold",
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CustomSuitableWidget(),
                  const SizedBox(height: 25),
                  const Text(
                    "Locations",
                    style: TextStyle(
                      fontFamily: "DMsans-Medium",
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cityNames.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 30,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(cityNames[index]),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                          child: FirebaseAnimatedList(
                            scrollDirection: Axis.horizontal,
                            query: hostelDatabase,
                            itemBuilder: (context, snapshot, animation, index) {
                              if (snapshot.value != null) {
                                final imageUrl =
                                    snapshot.child('imageUrl').value;

                                final dataId = snapshot.child('dataId').value;

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
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CupertinoButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {
                                        // Get.to(() => HostelDataView(
                                        //       hostelModel: hostelModel,
                                        //       imageUrl: imageUrl.toString(),
                                        //       dataId: dataId.toString(),
                                        //     ));
                                      },
                                      child: Container(
                                        height: 220,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      // image: DecorationImage(
                                                      // image:
                                                      //     CachedNetworkImageProvider(
                                                      //   imageUrl.toString(),
                                                      //   errorListener: () =>
                                                      //       const Icon(
                                                      //     IconlyBold.profile,
                                                      //     color: Colors.white,
                                                      //   ),
                                                      // ),
                                                      //   fit: BoxFit.cover,
                                                      // ),
                                                      ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: IconButton(
                                                          onPressed: null,
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                              Colors.white,
                                                            ),
                                                          ),
                                                          icon: const Icon(
                                                            Icons
                                                                .favorite_outline,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              hostelModel.hostelName,
                                              style: const TextStyle(
                                                fontFamily: "DMsans-Medium",
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              "\$${hostelModel.noOfRoom}",
                                              style: const TextStyle(
                                                fontFamily: "DMsans-Medium",
                                                fontSize: 16,
                                                color: Color(0xff059669),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const Text('No Data');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Suitable Widget
class CustomSuitableWidget extends StatelessWidget {
  const CustomSuitableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return CupertinoButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    height: 220,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/borgor.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: IconButton(
                                      onPressed: null,
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.favorite_outline,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Crunchy Burger",
                          style: TextStyle(
                            fontFamily: "DMsans-Medium",
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          "\$10",
                          style: TextStyle(
                            fontFamily: "DMsans-Medium",
                            fontSize: 16,
                            color: Color(0xff059669),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Header Widget
class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Search Food in any \nlocation",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "DMsans-Bold",
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          // const SizedBox(height: 5),
          CupertinoButton(
            onPressed: () {},
            child: Container(
              width: 140,
              height: 50,
              // padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  "Food Everywhere",
                  style: TextStyle(
                    fontFamily: "DMsans-Medium",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
