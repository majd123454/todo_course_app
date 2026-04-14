import 'package:flutter/material.dart';

class Boarding extends StatefulWidget {
  Boarding({super.key});

  @override
  State<Boarding> createState() => _BoardingState();
}

class _BoardingState extends State<Boarding> {
  List<BoardingPage> boardingPages = [
    BoardingPage(
      imagePath: 'assets/images/book.png',
      title:
          "Plan your tasks to do, that way you’ll stay organized and you won’t skip any",
    ),
    BoardingPage(
      imagePath: 'assets/images/image_22.png',
      title:
          "Make a full schedule for the whole week and stay organized and productive all days",
    ),
    BoardingPage(
      imagePath: 'assets/images/image_33.png',
      title: "create a team task, invite people and manage your work together",
    ),
    BoardingPage(
      imagePath: 'assets/images/image_44.png',
      title: "You informations are secure with us",
    ),
  ];

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: Icon(Icons.arrow_forward, color: Colors.black),
        shape: CircleBorder(),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topEnd,
            end: AlignmentDirectional.bottomStart,
            colors: [Color(0xff1253AA), Color(0xff05243E)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: boardingPages.length,
                onPageChanged: (i) {
                  setState(() {
                    currentPageIndex = i;
                  });
                },
                itemBuilder: (context, i) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          boardingPages[i].imagePath,
                          height: 300,
                          width: 300,
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            boardingPages[i].title,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(boardingPages.length, (int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      height: 7,
                      width: index == currentPageIndex ? 36 : 18,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dotWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 7,
        width: 18,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class BoardingPage {
  final String imagePath;
  final String title;

  BoardingPage({required this.imagePath, required this.title});
}
