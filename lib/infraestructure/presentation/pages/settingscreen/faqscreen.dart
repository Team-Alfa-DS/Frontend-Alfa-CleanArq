import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/Course.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "We are here to help"),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Frequently Asked Questions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 50, // Ajusta según la altura deseada de las píldoras
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CategoryPills(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const FAQQuestion(
              title: "What does Yaga mean in slang?",
              answer:
                  "Yaga is a slang term often associated with a playful imitation of a Russian accent. It can also refer to 'Baba Yaga,' a figure in Slavic folklore."),
          const FAQQuestion(
              title: "What does Namaste mean?",
              answer:
                  "Namaste is a traditional Indian greeting or gesture of respect, made by bringing the palms together before the face or chest and bowing."),
          const FAQQuestion(
              title: "Can I do yoga if I'm not flexible?",
              answer:
                  "Complete Beginners should start here. This bundle will teach basic yoga poses to fill with energy and joy. Hope on your mat and start to build...."),
          const FAQQuestion(
              title: "What are the benefits of yoga?",
              answer:
                  "Yoga offers many benefits, including improved flexibility, increased muscle strength, better posture, and stress reduction."),
          const FAQQuestion(
              title: "What are the disadvantages of yoga?",
              answer:
                  "While beneficial, yoga can sometimes lead to injuries if not practiced correctly, and it may not provide enough cardiovascular benefit for heart health on its own."),
          const FAQQuestion(
              title: "What is the best time to do yoga?",
              answer:
                  "The best time for yoga is generally considered to be in the early morning or late evening, as these times help align with natural body rhythms."),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 50), // Adjusts horizontal margin
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF4F14A0),
                  Color(0xFF8066FF),
                ],
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                // Implement your action
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                'See all',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FAQQuestion extends StatefulWidget {
  final String title;
  final String answer;
  final bool expanded;

  const FAQQuestion({
    super.key,
    required this.title,
    this.answer = "",
    this.expanded = false,
  });

  @override
  State<FAQQuestion> createState() => _FAQQuestionState();
}

class _FAQQuestionState extends State<FAQQuestion> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.expanded;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
              fontFamily: 'PT Sans',
              color: Color(0xFF677294),
              fontSize: 16), // Ajuste de tamaño de fuente y color
          titleMedium:
              TextStyle(fontFamily: 'PT Sans', color: Color(0xFF222222)),
        ),
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: _isExpanded ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        initiallyExpanded: widget.expanded,
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0), // Aumenta el padding horizontal
            child: Text(widget.answer),
          ),
        ],
      ),
    );
  }
}

class CategoryPills extends StatefulWidget {
  const CategoryPills({super.key});

  @override
  _CategoryPillsState createState() => _CategoryPillsState();
}

class _CategoryPillsState extends State<CategoryPills> {
  int _selectedPill = -1; // -1 means no pill is selected

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Prenatal', 'Confidence', 'Amount', 'FAQ'];
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List<Widget>.generate(
        categories.length,
        (int index) {
          return ChoiceChip(
            label: Text(categories[index]),
            selected: _selectedPill == index,
            onSelected: (bool selected) {
              setState(() {
                _selectedPill = selected ? index : -1;
              });
            },
            backgroundColor: const Color(0xFFCDC3FF),
            selectedColor: Colors.deepPurple, // Not actually used
            labelStyle: TextStyle(
                color: _selectedPill == index
                    ? Colors.white
                    : const Color(0xFF7745BC)),
            padding: const EdgeInsets.all(10.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            pressElevation: 0,
            elevation: 0,
            shadowColor: Colors.transparent,
            showCheckmark: false,
          );
        },
      ),
    );
  }
}
