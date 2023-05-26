import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 30;

  int init_sec = 5;
  int init_min = 1;
  int init_hour = 0;
  int _counter_sec = 5;
  int _counter_min = 1;
  int _counter_hour = 0;
  //int initial = 20;
  bool isStarted = false;
  late Timer timer;
  final player = AudioPlayer();


  void playAudio()
  {

    player.play();
  }

  void stopAudio()
  {
    player.stop();
  }

  @override
  void initState()
  {

    player.setAsset('assets/HeatleyBros.mp3');
    Timer.periodic(const Duration(seconds: 1),(timer)
    {
      // if(timer.isActive)
      //   ElevatedButton(onPressed: reset, child: Text('Reset'),)

      setState(()  {

        if(isStarted == false) {

          timer.cancel();
        }
        else{
          if(_counter_sec>0) {
            _counter_sec--;
          }

          else if(_counter_hour == 0 && _counter_min == 0 && _counter_sec == 0){
            timer.cancel();

            playAudio();
            isStarted = false;
          }

          else if(_counter_sec<=0)
            {
              _counter_sec = 59;
              _counter_min--;
              if(_counter_min<=0 && _counter_hour !=0) {

                  _counter_hour --;

                _counter_min = 59;
              }
            }

          // if(_counter >0) {
          //   _counter--;
          // }

        }

      });
      print(timer.tick);


    });

    super.initState();
  }

void reset()
  {
    setState(() {
      isStarted = false;
      //_counter = 30;
      _counter_hour = init_hour;
      _counter_min = init_min;
      _counter_sec = init_sec;
      stopAudio();
    });
  }

// @override
//   void pause()
//   {
//     int a = _counter;
//     setState(() {
//       isStarted = false;
//     });
//     _counter = a;
//   }
//

  void pause()
  {
    int a = _counter_sec;
    int b = _counter_min;
    setState(() {
      isStarted = false;
     });
    _counter_sec = a;
    _counter_min = b;
  }

void start()
{
  setState(() {
    isStarted = true;
  });
  initState();
}

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  double remainingDuration()
  {
    int totalInit = init_hour*3600 + init_min*60 + init_sec;
    int totalR = _counter_hour*3600 + _counter_min*60 + _counter_sec;

    double remaining =  1/totalInit * totalR;
    print(remaining);
    return remaining;

  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
              //  Container(
            //
               //   padding: EdgeInsets.symmetric(vertical: 200),

                  //  children: [

    //'00:00:00',
                SizedBox(
                        height: 300,
                        width: 300,
                        child: CircularProgressIndicator(
                          value: remainingDuration(),
                          strokeWidth: 15,
                        )
  ),
                          Text(
                            // _counter.toString(),
                            _counter_hour.toString().padLeft(2, '0')+":"+_counter_min.toString().padLeft(2, '0')+ ':' + _counter_sec.toString().padLeft(2, '0'),
                            style: GoogleFonts.lato(fontSize: 50),

                      ),

              ],
            ),

            const Padding(
                padding: EdgeInsets.all(15)),

            Column(
              children: <Widget>[

                Row(

                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ElevatedButton(onPressed: reset,child: const Text('Reset')),
                    //
                    // if(isStarted == true)
                    //   ElevatedButton(onPressed:pause, child: const Text('Pause')),
                    // if(isStarted == false)
                    //   ElevatedButton(onPressed: start, child: const Text('Start')),

                    const Spacer(flex: 1),

                    IconButton(onPressed: reset, icon: const Icon(Icons.restart_alt),iconSize: 35.0,color: Colors.deepPurple),

                    const Spacer(),
                   if(isStarted == true)

                        IconButton(onPressed: pause, icon: const Icon(Icons.pause),iconSize: 50.0,color: Colors.deepPurple),

                    if(isStarted == false)

                        IconButton(onPressed: start, icon: const Icon(Icons.play_arrow),iconSize: 60.0,color: Colors.deepPurple),
                    const Spacer(flex: 3),





                    
                    
                  ],
                ),

              ],
            ),

          ],
        ) ,




             //   ],

          //  ),



      ),


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
