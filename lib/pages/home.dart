import "package:flutter/material.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFDFDF),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              Stack(children: [
                Container(
                  height: 220,
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 50,
                  ),
                  decoration: const BoxDecoration(
                      color: Color(0xFF2a2b31),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          "assets/img/user_profile.jpg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Akrom Ibragimov",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(top: 120, left: 20, right: 20),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          child: Image.asset('assets/img/main_banner.jpg')),
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Изучай итальянские глаголы",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ]),
              const SizedBox(
                height: 30,
              ),
              const Category(
                  title: "По спряжению",
                  cards: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryCard(
                        title: "Are",
                      ),
                      CategoryCard(
                        title: "Ere",
                      ),
                      CategoryCard(
                        title: "Ire",
                      ),
                    ],
                  )),
              const Category(
                title: "Правильные/Неправильные",
                cards: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CategoryCard(
                      title: "Правильные",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CategoryCard(
                      title: "Неравильные",
                    ),
                  ],
                ),
              ),
              const Category(
                title: "Переходные/Непереходные",
                cards: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CategoryCard(
                      title: "Переходные",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CategoryCard(
                      title: "Непереходные",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Category extends StatefulWidget {
  final String title; // Поле для заголовка
  final Widget cards;

  const Category({
    super.key,
    required this.title,
    required this.cards,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              textAlign: TextAlign.left,
              widget.title,
              style: const TextStyle(
                  color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: widget.cards,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class CategoryCard extends StatefulWidget {
  final String title;
  const CategoryCard({super.key, required this.title});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
