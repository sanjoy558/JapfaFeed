import 'package:flutter/material.dart';
import 'package:japfa_feed_application/utils/Constants.dart';

class EditPurchaseOrder extends StatefulWidget {
  const EditPurchaseOrder({Key? key}) : super(key: key);

  @override
  State<EditPurchaseOrder> createState() => _EditPurchaseOrderState();
}

class _EditPurchaseOrderState extends State<EditPurchaseOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: const Text(
        'Edit Purchase Order',
        style: TextStyle(
        fontFamily: 'Popins',
        fontWeight: FontWeight.w600,
        color: Colors.black),
    ),
    ),
    );
  }
}
