import 'package:flutter/material.dart';
import 'package:foodiezone/screens/admin/user/widgets/custom_table_widget.dart';

class FoodDriverUserOrderDetailsView extends StatefulWidget {
  final Map<String, dynamic> ordeDetails;
  const FoodDriverUserOrderDetailsView({super.key, required this.ordeDetails});

  @override
  State<FoodDriverUserOrderDetailsView> createState() =>
      _FoodDriverUserOrderDetailsViewState();
}

class _FoodDriverUserOrderDetailsViewState
    extends State<FoodDriverUserOrderDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Order Details'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Table(
            border: TableBorder.all(
              color: Colors.grey.shade300,
            ),
            children: [
              customTableWidget(
                headingText: "Client Name",
                dataText: widget.ordeDetails['usernmae'].toString(),
              ),
              customTableWidget(
                headingText: "Email",
                dataText: widget.ordeDetails['email'].toString(),
              ),
              customTableWidget(
                headingText: "Phone",
                dataText: widget.ordeDetails['phone'].toString(),
              ),
              customTableWidget(
                headingText: "Food Price",
                dataText: widget.ordeDetails['foodPrice'].toString(),
              ),
              customTableWidget(
                headingText: "Address",
                dataText: widget.ordeDetails['address'].toString(),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
