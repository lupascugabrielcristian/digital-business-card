import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        // the application has a purple toolbar. Then, without quitting the app,
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
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final sources = const [
    QRCodeSource(
      url: 'https://www.linkedin.com/in/mdespina',
      qrImagePath: 'assets/linkedin-qr.png',
      assetPath: 'assets/linkedin.png',
    ),
    QRCodeSource(
      url: 'https://www.linkedin.com/company/lead4growthconsulting',
      qrImagePath: 'assets/web-qr.png',
      assetPath: 'assets/web.svg',
    ),
    QRCodeSource(
      url: 'https://www.instagram.com/binaryfusion.ro',
      qrImagePath: 'assets/insta-qr.png',
      assetPath: 'assets/insta.svg',
    ),
    QRCodeSource(
      url: 'https://www.facebook.com/profile.php?id=61578027117472',
      qrImagePath: 'assets/facebook-qr.png',
      assetPath: 'assets/facebook.png',
    ),
  ];

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
  late QRCodeSource selectedSource = widget.sources[0];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 73, 72, 72),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/forest.png'),
            fit: BoxFit.cover
            // gradient: LinearGradient(
            //   colors: [
            //     Color.fromRGBO(0, 13, 34, 1),
            //     Color.fromRGBO(54, 68, 91, 1)
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight),
            // border: Border.all(
            //   color: Colors.transparent,
            ),
            // borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              spacing: 30,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                // NUMELE SI DATELE DE CONTACT
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mihaela Despina', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),),
                        Text('Email: contact@lead4g.com', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),),
                        Text('Tel: 0123 032 023', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),),
                        Text('Web: lead4growth.com', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),),
                      ],
                    )
                  ],
                ),

                // QR CODE
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onHorizontalDragEnd: (dragDetails) {
                      if (dragDetails.primaryVelocity != null && dragDetails.primaryVelocity! < 0) {
                        // Swiped Left
                        setState(() {
                          int currentIndex = widget.sources.indexOf(selectedSource);
                          int nextIndex = (currentIndex + 1) % widget.sources.length;
                          selectedSource = widget.sources[nextIndex];
                        });
                      } else if (dragDetails.primaryVelocity != null && dragDetails.primaryVelocity! > 0) {
                        // Swiped Right
                        setState(() {
                          int currentIndex = widget.sources.indexOf(selectedSource);
                          int previousIndex = (currentIndex - 1 + widget.sources.length) % widget.sources.length;
                          selectedSource = widget.sources[previousIndex];
                        });
                      }
                    },
                    child: PrettyQrView(
                      qrImage: QrImage(QrCode.fromData(data: selectedSource.url, errorCorrectLevel: QrErrorCorrectLevel.H),),
                      decoration: PrettyQrDecoration(
                        background: Colors.transparent,
                        shape: const PrettyQrSmoothSymbol(
                          color: Colors.white,
                        ),
                        quietZone: const PrettyQrQuietZone.modules(0),
                        image: PrettyQrDecorationImage(
                            image: AssetImage(selectedSource.qrImagePath),
                            position: PrettyQrDecorationImagePosition.embedded,
                            scale: 0.3,
                        ),
                        // image: AssetImage('assets/logo.png'),
                        // imageSize: Size(40, 40),
                      ),
                    ),
                  ),
                ),

                // SOCIAL MEDIA ICONS
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: widget.sources.map((x) => _getSocialIcon(x)).toList(),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSocialIcon(QRCodeSource source) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSource = source;
        });
      },
      child: source.assetPath.endsWith('.svg')
        ? AspectRatio(aspectRatio: 1, child: SvgPicture.asset(source.assetPath, width: 40, height: 40,))
        : AspectRatio(aspectRatio: 1, child: Image.asset(source.assetPath, width: 40, height: 40,)),
    );
  }
}

class QRCodeSource {
  final String url;
  final String qrImagePath;
  final String assetPath;

  const QRCodeSource({required this.url, required this.qrImagePath, required this.assetPath});
}
