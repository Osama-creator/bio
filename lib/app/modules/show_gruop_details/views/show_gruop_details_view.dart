import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/show_gruop_details_controller.dart';

class ShowGruopDetailsView extends GetView<ShowGruopDetailsController> {
  const ShowGruopDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShowGruopDetailsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ShowGruopDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
