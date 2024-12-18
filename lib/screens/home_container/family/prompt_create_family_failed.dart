import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/api_call_provider.dart';

class PromptCreateFamilyFailed extends StatefulWidget {
  const PromptCreateFamilyFailed({super.key});
  static const String route = '/promptCreateFamilyFailed';

  @override
  State<PromptCreateFamilyFailed> createState() =>
      _PromptCreateFamilyFailedState();
}

class _PromptCreateFamilyFailedState extends State<PromptCreateFamilyFailed> {
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Todo: call api after screen load
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
        backgroundColor: const Color(0xFFF6F7F9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Prompt Family Create Failed'),
          actions: [],
        ),
        body: getBody(context));
  }

  getBody(BuildContext context) {
    return Container();
  }
}
