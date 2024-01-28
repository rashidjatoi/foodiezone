import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodiezone/constants/color_extension.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/services/database_services.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:foodiezone/utils/utils.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../widgets/round_icon_button.dart';

class ItemDetailsView extends StatefulWidget {
  final Map<String, dynamic> foodDetails;

  const ItemDetailsView({super.key, required this.foodDetails});

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  double price = 15;
  int qty = 1;
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          CachedNetworkImage(
            imageUrl: widget.foodDetails['foodImage'],
            fit: BoxFit.cover,
            width: media.width,
            height: media.width,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(
              IconlyBold.profile,
              color: Colors.white,
            ),
          ),
          Container(
            width: media.width,
            height: media.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: media.width - 60,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: TColor.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 35,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  widget.foodDetails['foodItemName'],
                                  style: TextStyle(
                                      color: TColor.primaryText,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IgnorePointer(
                                          ignoring: true,
                                          child: RatingBar.builder(
                                            initialRating: 4,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 20,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 1.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: appcolor,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        const Text(
                                          " 4 Star Ratings",
                                          style: TextStyle(
                                              color: appcolor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Rs: ${widget.foodDetails['foodPrice']}",
                                          style: const TextStyle(
                                              fontSize: 31,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        const Text(
                                          "/per Portion",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                      color: TColor.primaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                  widget.foodDetails['foodDescription'],
                                  style: TextStyle(
                                      color: TColor.secondaryText,
                                      fontSize: 12),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Divider(
                                    color:
                                        TColor.secondaryText.withOpacity(0.4),
                                    height: 1,
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  children: [
                                    Text(
                                      "Number of Portions",
                                      style: TextStyle(
                                          color: TColor.primaryText,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        qty = qty - 1;

                                        if (qty < 1) {
                                          qty = 1;
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: appcolor,
                                            borderRadius:
                                                BorderRadius.circular(12.5)),
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                              color: TColor.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: appcolor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.5)),
                                      child: Text(
                                        qty.toString(),
                                        style: TextStyle(
                                            color: TColor.primary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        qty = qty + 1;

                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: appcolor,
                                            borderRadius:
                                                BorderRadius.circular(12.5)),
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: TColor.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 220,
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Container(
                                      width: media.width * 0.25,
                                      height: 160,
                                      decoration: const BoxDecoration(
                                        color: appcolor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(35),
                                            bottomRight: Radius.circular(35)),
                                      ),
                                    ),
                                    Center(
                                      child: Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                  left: 10,
                                                  right: 20),
                                              width: media.width - 80,
                                              height: 120,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  35),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  35),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 12,
                                                        offset: Offset(0, 4))
                                                  ]),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Total Price",
                                                    style: TextStyle(
                                                        color:
                                                            TColor.primaryText,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    "Rs: ${(int.parse(widget.foodDetails['foodPrice']) * qty).toString()}",
                                                    style: TextStyle(
                                                        color:
                                                            TColor.primaryText,
                                                        fontSize: 21,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  SizedBox(
                                                    width: 130,
                                                    height: 25,
                                                    child: RoundIconButton(
                                                      title: "Add to Cart",
                                                      size: 15,
                                                      icon: IconlyLight.bag,
                                                      color: appcolor,
                                                      onPressed: () async {
                                                        int totalPrice =
                                                            int.parse(widget
                                                                        .foodDetails[
                                                                    'foodPrice']) *
                                                                qty;
                                                        final currentUserId =
                                                            firebaseAuth
                                                                .currentUser!
                                                                .uid
                                                                .toString();
                                                        Map<String, dynamic>
                                                            foodOrder = {
                                                          "foodPrice":
                                                              totalPrice
                                                                  .toString(),
                                                          "foodImage": widget
                                                                  .foodDetails[
                                                              'foodImage'],
                                                          "foodDescription": widget
                                                                  .foodDetails[
                                                              'foodDescription'],
                                                          "foodItemName": widget
                                                                  .foodDetails[
                                                              'foodItemName'],
                                                          "userId": widget
                                                                  .foodDetails[
                                                              'userId'],
                                                          "currentUserId":
                                                              currentUserId,
                                                        };

                                                        await orderDatabase
                                                            .push()
                                                            .set(foodOrder);

                                                        await foodProviderDatabase
                                                            .child(widget
                                                                    .foodDetails[
                                                                'userId'])
                                                            .child('order')
                                                            .push()
                                                            .set(
                                                              foodOrder,
                                                            )
                                                            .then(
                                                              (value) => Utils
                                                                  .showToast(
                                                                message:
                                                                    'Order Placed',
                                                                bgColor:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                            );
                                                        DatabaseServices
                                                                .saveFoodOrders(
                                                                    order:
                                                                        foodOrder)
                                                            .then(
                                                          (value) {
                                                            Get.back();
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
