import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulHookConsumerWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final String fruit = ref.watch(fruitProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My favorite fruit is $fruit'),
        ),
        body: Center(
          child: Column(children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Riverpod case'),
            ),
            FruitButton('Apples'),
            FruitButton('Oranges'),
            FruitButton('Bananas'),
          ]),
        ),
      ),
    );
  }
}

class FruitButton extends ConsumerWidget {
  final String fruit;
  const FruitButton(this.fruit, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          ref.read(fruitProvider.notifier).changeFruit(fruit);
        },
        child: Text(fruit),
      ),
    );
  }
}

final fruitProvider = StateNotifierProvider<Favorites, String>((ref) {
  return Favorites();
});

class Favorites extends StateNotifier<String> {
  Favorites() : super('unKnown');
  void changeFruit(String newFruit) {
    state = newFruit;
  }
}
