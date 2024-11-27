import "package:flutter/material.dart";

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF004840),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xfff35b32),
                          borderRadius: BorderRadius.circular(60)),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      )),
                  const SizedBox(
                    width: 125,
                  ),
                  const Text(
                    "Are",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: const Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      Text(
                        "Выберите подходящий глагол:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Option(title: "Parl"),
                      SizedBox(
                        height: 20,
                      ),
                      Option(title: "legg"),
                      SizedBox(
                        height: 20,
                      ),
                      Option(title: "dorm")
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Option extends StatefulWidget {
  final String title;
  const Option({super.key, required this.title});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF818181), width: 1.5),
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        widget.title,
        style: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
