import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/counter_demo.dart';


final nameProvider = Provider<String>(
  (ref){
    return "Shiran kumarasingha";
  }
);


// ---

final newCounterProvider = StateNotifierProvider<CounterDemo,int>(
  (ref) => CounterDemo()
);

// create the provider

final counterProvider = StateProvider<int>(         
  (ref) => 0
);

void main() {
  runApp(const ProviderScope(child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MySecondHomePage(),
    );
  }
}

// first way -------------------------------------------------- 

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {

    final name = ref.watch(nameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('River PodProvider'),
      ),

      body:  Center(child: Text(name)),
    );
  }
}

// second home Class ------------------------------------------

class SecondHomeClass extends StatelessWidget {
  const SecondHomeClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riverpod Provider"),
      ),
      body: Consumer(
        builder: (context, ref,child) {

          final name = ref.watch(nameProvider);

          return Center(child: Text(name));
        }
      ),
    );
  }
}


// --

class Main extends ConsumerStatefulWidget {
  const Main({super.key});

  @override
  _MainState createState() => _MainState();
}

class _MainState extends ConsumerState<Main> {

  
  @override
  Widget build(BuildContext context) {

    final name = ref.watch(nameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('River PodProvider'),
      ),

      body:  Center(child: Text(name)),
    );
  }
}


// state provider


class MySecondHomePage extends ConsumerWidget {
  const MySecondHomePage({super.key});
 
  @override
  Widget build(BuildContext context , WidgetRef ref) {

    final count = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('State Provider'),
        actions: [
          IconButton(onPressed: () {

          //  ref.refresh(counterProvider);   

            ref.invalidate(counterProvider);

          }, icon: Icon(Icons.refresh))
        ],
      ),

      body:  Center(
        child: Text(count.toString(),style: TextStyle(fontSize: 23),),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // firST WAY ------
          //ref.read(counterProvider.notifier).state++;

          // SECOND WAY ----

            ref.read(counterProvider.notifier).update((state) => state + 1);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


// state Notifiy provider ---

class MyThirdHomePage extends ConsumerWidget {
  const MyThirdHomePage({super.key});
 
  @override
  Widget build(BuildContext context , WidgetRef ref) {

    final counter = ref.watch(newCounterProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('State Provider'),
        actions: [
          IconButton(onPressed: () {


          }, icon: Icon(Icons.refresh))
        ],
      ),

      body:  Center(
        child: Text('$counter',style: TextStyle(fontSize: 23),),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(newCounterProvider.notifier).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}





