import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class BaseProductWidget extends StatelessWidget {
  final QuerySnapshot snapshot;

  BaseProductWidget(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return bodyBuilder(context);
  }

  Widget bodyBuilder(BuildContext context);
}
