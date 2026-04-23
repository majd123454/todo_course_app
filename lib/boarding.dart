import 'package:course_level_one/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isOpen = false;

void setIsOpen() async {
  SharedPreferences sh = await SharedPreferences.getInstance();
  await sh.setBool("boardingComplete", isOpen);
}

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
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          if (currentPageIndex == boardingPages.length - 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            isOpen = true;
            setIsOpen();
          } else {
            pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        shape: CircleBorder(),
        child: Icon(
          currentPageIndex == boardingPages.length - 1
              ? Icons.check
              : Icons.arrow_forward,
          color: Colors.black,
        ),
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
                controller: pageController,
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
