import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'model_state.dart';

class ModelCubit extends Cubit<ModelState> {
  ModelCubit() : super(ModelInitial());

  static ModelCubit get(context) => BlocProvider.of(context);
  final openAi = OpenAI.instance.build(
      token: "",
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 60)),
      enableLog: true);

  Future<String> getJSONFromPrompt() async {
    final request = CompleteText(maxTokens: 2500,

      prompt: '''
      you are an AI medical assistant give a report for the following case:
      my year old friend has a mild spiral fracture in his wrist. Give a proper report and recommendations about it, while not adding any recommendation or info that could hurt him.
''',
      model: Gpt3TurboInstruct(),
    );

    final response = await openAi.onCompletion(request: request);
    log("${response!.choices[0].text}");
    return response!.choices[0].text;
  }
}
