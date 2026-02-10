import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: StepIndicatorScreen()),
  );
}

class StepIndicatorScreen extends StatefulWidget {
  @override
  _StepIndicatorScreenState createState() => _StepIndicatorScreenState();
}

class _StepIndicatorScreenState extends State<StepIndicatorScreen> {
  // পেজ কন্ট্রোলার যা স্লাইড হ্যান্ডেল করবে
  final PageController _pageController = PageController();

  // বর্তমান পেজ ইনডেক্স
  int _currentPage = 0;

  // মোট পেজ সংখ্যা
  final int _totalPages = 5;

  // স্যাম্পল ইমেজ লিস্ট (আপনার পছন্দমতো ইমেজ ইউআরএল দিতে পারেন)
  final List<String> images = [
    'https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=1000&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?q=80&w=1000&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=1000&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?q=80&w=1000&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=1000&auto=format&fit=crop',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ১. ব্যাকগ্রাউন্ড ইমেজ স্লাইডার (PageView)
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _totalPages,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(images[index]),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Step ${index + 1}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),

          // ২. ইন্ডিকেটর বার (Top Section)
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Row(
              children: List.generate(_totalPages, (index) {
                return Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    height: 5,
                    decoration: BoxDecoration(
                      // লজিক পরিবর্তন: শুধুমাত্র বর্তমান ইনডেক্সটি লাল হবে
                      color: index == _currentPage
                          ? Colors.red
                          : Colors.grey.withAlpha(150),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),
            ),
          ),

          // ৩. নেক্সট এবং ব্যাক বাটন
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                if (_currentPage != 0)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                    ),
                    child: Text("Back", style: TextStyle(color: Colors.white)),
                  )
                else
                  SizedBox(width: 80),

                // Next Button
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _totalPages - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // শেষ পেজে যা হবে (যেমন: হোম পেজে যাওয়া)
                      print("Finished!");
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    _currentPage == _totalPages - 1 ? "Finish" : "Next",
                    style: TextStyle(color: Colors.white),
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
