import 'package:flutter/material.dart';

class IconButtons extends StatefulWidget {
  const IconButtons({Key? key}) : super(key: key);

  @override
  _IconButtonsState createState() => _IconButtonsState();
}

class _IconButtonsState extends State<IconButtons>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool showAdditionalButtons = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (showAdditionalButtons)
          AnimatedOpacity(
            opacity: showAdditionalButtons ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    print('Additional Button Clicked');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 214, 90),
                    padding: EdgeInsets.all(3.0),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.favorite,
                      color: Color.fromARGB(255, 10, 10, 10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            setState(() {
              showAdditionalButtons = !showAdditionalButtons;
              if (showAdditionalButtons) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
            });
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: const Color.fromARGB(255, 255, 214, 90),
            fixedSize: const Size(60.0, 60.0),
            padding: EdgeInsets.zero,
          ),
          child: showAdditionalButtons != true
              ? const Icon(
                  Icons.add,
                  color: Color.fromARGB(255, 10, 10, 10),
                  size: 30,
                )
              : const Icon(
                  Icons.remove,
                  color: Color.fromARGB(255, 10, 10, 10),
                  size: 30,
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
