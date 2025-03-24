import 'package:flutter/material.dart';
import 'package:heartmap/core/base/base_view_model.dart';
import 'package:heartmap/core/base/base_view_state.dart';

abstract class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final T viewModel;

  const BaseView({Key? key, required this.viewModel}) : super(key: key);

  @override
  BaseViewState<T, BaseView<T>> createState();
}
