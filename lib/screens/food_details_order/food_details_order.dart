import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/services/database_services.dart';
import 'package:foodiezone/services/services_constants.dart';
import 'package:foodiezone/utils/utils.dart';
import 'package:foodiezone/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class FoodDetailsOrderView extends StatefulWidget {
  final Map<String, dynamic> foodDetails;
  const FoodDetailsOrderView({super.key, required this.foodDetails});

  @override
  State<FoodDetailsOrderView> createState() => _FoodDetailsOrderViewState();
}

class _FoodDetailsOrderViewState extends State<FoodDetailsOrderView> {
  int itemCount = 1; // Initial item count

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodDetails['foodItemName']),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.foodDetails['foodImage'],
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 300,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(
                    IconlyBold.profile,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      'Item Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "DMSans Bold",
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.foodDetails['foodItemName'],
                      style: const TextStyle(
                        fontSize: 16,
                        // fontFamily: "DMSans Medium",
                      ),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "DMSans Bold",
                          ),
                        ),
                        Text(
                          widget.foodDetails['foodDescription'],
                          style: const TextStyle(
                            fontSize: 16,
                            // fontFamily: "DMSans Medium",
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "DMSans Bold",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${widget.foodDetails['foodPrice']}",
                              style: const TextStyle(
                                fontSize: 18,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  child: IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      if (itemCount > 1) {
                                        setState(() {
                                          itemCount--;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  itemCount.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 5),
                                CircleAvatar(
                                  child: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        itemCount++;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          CustomButton(
            btnText: "Place Order",
            btnRadius: 30,
            ontap: () async {
              int intValue = int.parse(widget.foodDetails['foodPrice']);
              int totalPrice = intValue * itemCount;
              Map<String, dynamic> foodOrder = {
                "foodPrice": totalPrice.toString(),
                "foodImage": widget.foodDetails['foodImage'],
                "foodDescription": widget.foodDetails['foodDescription'],
                "foodItemName": widget.foodDetails['foodItemName'],
                "userId": widget.foodDetails['userId'],
              };

              await foodProviderDatabase
                  .child(widget.foodDetails['userId'])
                  .push()
                  .set({
                "order": foodOrder,
              }).then(
                (value) => Utils.showToast(
                  message: 'Order Placed',
                  bgColor: Colors.red,
                  textColor: Colors.white,
                ),
              );
              DatabaseServices.saveFoodOrders(order: foodOrder).then(
                (value) {
                  Get.back();
                },
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
