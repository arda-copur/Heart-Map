import 'package:flutter/material.dart';
import 'package:heartmap/core/base/base_view.dart';
import 'package:heartmap/core/base/base_view_model.dart';

abstract class BaseViewState<T extends BaseViewModel, W extends BaseView<T>>
    extends State<W> {
  T get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
