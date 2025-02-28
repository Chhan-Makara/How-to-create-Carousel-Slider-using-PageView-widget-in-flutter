import 'package:flutter/material.dart';
import 'dart:async'; // For Timer

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> lstImg = [
    "https://t3.ftcdn.net/jpg/10/02/58/80/360_F_1002588053_9cuc5jYMUKveBLi11s0tbQNF6jXrYmJf.jpg",
    "https://t3.ftcdn.net/jpg/11/80/94/60/360_F_1180946021_BNTvVZujsfcL1qI6LMGvHQKmcqt0hCU1.jpg",
    "https://t4.ftcdn.net/jpg/11/66/55/59/360_F_1166555937_jMwjtsND6bqeIZZ6zXqTVEedpjLylMXd.jpg",
  ];

  int activeIndex = 0; // Keeps track of the current page
  final PageController pageController =
      PageController(); // Controller for PageView
  late Timer timer; // Timer for auto-scrolling

  @override
  void initState() {
    super.initState();

    // Start the auto-scroll timer
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        if (activeIndex < lstImg.length - 1) {
          activeIndex++; // Move to next image
        } else {
          activeIndex = 0; // Reset to first image
        }
      });

      // Animate to the next page
      pageController.animateToPage(
        activeIndex,
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to prevent memory leaks
    pageController.dispose(); // Dispose of the page controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Carousel with PageView")),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.4,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  controller: pageController, // Use the pageController
                  onPageChanged: (index) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                  itemCount: lstImg.length,
                  itemBuilder: (context, index) {
                    final img = lstImg[index];
                    return Image.network(img, fit: BoxFit.cover);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    lstImg.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor:
                            activeIndex == index ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
