import 'package:flutter/material.dart';

class DestinationViewState {
  DestinationViewState({required this.destinationKey})
    : scrollController = ScrollController();

  final String destinationKey;
  final ScrollController scrollController;
  String activeViewState = 'default';

  void dispose() {
    scrollController.dispose();
  }
}
