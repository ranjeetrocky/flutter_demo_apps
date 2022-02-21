import 'package:flutter/material.dart';

Color _themeSeed = Colors.red;

class ColorThemingApp extends StatefulWidget {
  const ColorThemingApp({Key? key}) : super(key: key);

  @override
  State<ColorThemingApp> createState() => _ColorThemingAppState();
}

class _ColorThemingAppState extends State<ColorThemingApp> {
  @override
  Widget build(BuildContext context) {
    void _changeColor(Color newThemeseed) {
      setState(() {
        _themeSeed = newThemeseed;
        print('changing color ');
      });
    }

    return MaterialApp(
      home: HomeScreen(changeColorFunction: _changeColor),
      theme: ThemeData(
          colorSchemeSeed: _themeSeed,
          brightness: Brightness.light,
          textTheme: const TextTheme(
              headline5: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
      darkTheme: ThemeData(
          colorSchemeSeed: _themeSeed,
          brightness: Brightness.dark,
          textTheme: const TextTheme(
              headline5: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Function changeColorFunction;
  HomeScreen({Key? key, required this.changeColorFunction}) : super(key: key);

  final themeSeedColors = [
    Colors.purple,
    Colors.blue,
    Colors.blueAccent,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Color Theming App")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ColorTilesWithName(),
            ColorButtonPanel(
                themeSeedColors: themeSeedColors,
                changeColorFunction: changeColorFunction),
          ],
        ),
      ),
    );
  }
}

class ColorTilesWithName extends StatelessWidget {
  const ColorTilesWithName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
        child: ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ColorInfoTile(
          cardColor: colorScheme.primary,
          title: 'colorScheme.primary',
          textColor: colorScheme.background,
        ),
        ColorInfoTile(
          cardColor: colorScheme.inversePrimary,
          title: 'colorScheme.inversePrimary',
          textColor: colorScheme.inverseSurface,
        ),
        ColorInfoTile(
          cardColor: colorScheme.primaryContainer,
          title: 'colorScheme.primaryContainer',
          textColor: colorScheme.inverseSurface,
        ),
        ColorInfoTile(
          cardColor: colorScheme.secondary,
          title: 'colorScheme.secondary',
          textColor: colorScheme.secondaryContainer,
        ),
        ColorInfoTile(
          cardColor: colorScheme.secondaryContainer,
          title: 'colorScheme.secondaryContainer',
          textColor: colorScheme.secondary,
        ),
        ColorInfoTile(
          cardColor: colorScheme.tertiary,
          title: 'colorScheme.tertiary',
          textColor: colorScheme.tertiaryContainer,
        ),
        ColorInfoTile(
          cardColor: colorScheme.tertiaryContainer,
          title: 'colorScheme.tertiaryContainer',
          textColor: colorScheme.tertiary,
        ),
        ColorInfoTile(
          cardColor: colorScheme.background,
          title: 'colorScheme.background',
          textColor: colorScheme.primary,
        ),
        ColorInfoTile(
          cardColor: colorScheme.surface,
          title: 'colorScheme.surface',
          textColor: colorScheme.primary,
        ),
        ColorInfoTile(
          cardColor: colorScheme.surfaceVariant,
          title: 'colorScheme.surfaceVariant',
          textColor: colorScheme.primary,
        ),
        ColorInfoTile(
          cardColor: colorScheme.inverseSurface,
          title: 'colorScheme.inverseSurface',
          textColor: colorScheme.background,
        ),
        ColorInfoTile(
          cardColor: colorScheme.error,
          title: 'colorScheme.error',
          textColor: colorScheme.errorContainer,
        ),
        ColorInfoTile(
          cardColor: colorScheme.errorContainer,
          title: 'colorScheme.errorContainer',
          textColor: colorScheme.error,
        ),
        ColorInfoTile(
          cardColor: colorScheme.shadow,
          title: 'colorScheme.shadow',
          textColor: colorScheme.background,
        ),
        ColorInfoTile(
          cardColor: colorScheme.outline,
          title: 'colorScheme.outline',
          textColor: colorScheme.background,
        ),
      ],
    ));
  }
}

class ColorInfoTile extends StatelessWidget {
  const ColorInfoTile({
    Key? key,
    required this.title,
    required this.textColor,
    required this.cardColor,
  }) : super(key: key);

  final Color textColor, cardColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    final headLine5 = Theme.of(context).textTheme.headline5;
    return Card(
      color: cardColor,
      child: ListTile(
        title: Text(
          title,
          style: headLine5?.copyWith(color: textColor),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}

class ColorButtonPanel extends StatelessWidget {
  const ColorButtonPanel({
    Key? key,
    required this.themeSeedColors,
    required this.changeColorFunction,
  }) : super(key: key);

  final List<ColorSwatch<int>> themeSeedColors;
  final Function changeColorFunction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: themeSeedColors
              .map(
                (color) => ColorButton(
                  color: color,
                  onTap: () => changeColorFunction(color),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  const ColorButton({
    Key? key,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CircleAvatar(
        // backgroundColor: color.withAlpha(100),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          // splashColor: color,
          // overlayColor: MaterialStateProperty.all(color),
          // highlightColor: color,
          onTap: onTap,
          child: Expanded(
            child: Container(
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
