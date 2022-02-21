import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';

class CodeViewScreen extends StatelessWidget {
  final String codeFilePath;
  const CodeViewScreen({Key? key, required this.codeFilePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code View'),
      ),
      body: WidgetWithCodeView(
        child: const SomeWidget(),
        sourceFilePath: codeFilePath,
        codeLinkPrefix: 'https://google.com?q=',
        iconBackgroundColor: Colors.white,
        iconForegroundColor: Colors.pink,
        labelBackgroundColor: Theme.of(context).canvasColor,
        labelTextStyle:
            TextStyle(color: Theme.of(context).textTheme.bodyText1?.color),
        showLabelText: true,
        syntaxHighlighterStyle:
            SyntaxHighlighterStyle.darkThemeStyle().copyWith(
          commentStyle: const TextStyle(color: Colors.yellow),
          keywordStyle: const TextStyle(color: Colors.lightGreen),
          classStyle: const TextStyle(color: Colors.amber),
          numberStyle: const TextStyle(color: Colors.orange),
        ),
      ),
    );
  }
}

class SomeWidget extends StatelessWidget {
  const SomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Center(
            child: Transform.rotate(
              angle: Random().nextDouble(),
              child: const Text(
                'Example',
                textScaleFactor: 2,
              ),
            ),
          ),
          Wrap(
            children: List.generate(
              100,
              (_) => SizedBox(
                width: MediaQuery.of(context).size.width * .25,
                height: MediaQuery.of(context).size.width * .25,
                child: Placeholder(
                  color: Colors.accents[Random().nextInt(
                    Colors.accents.length,
                  )],
                ),
              ),
            ),
          ),
        ],
      );
}
