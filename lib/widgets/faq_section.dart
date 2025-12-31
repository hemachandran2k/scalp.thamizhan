import 'package:flutter/material.dart';

// FAQ Section
class FAQSection extends StatefulWidget {
  const FAQSection({Key? key}) : super(key: key);

  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  int? _expandedIndex;

  final List<Map<String, String>> _faqs = [
    {
      'question': 'What language is the program in?',
      'answer':
      'The program is conducted in Tamil with comprehensive materials and video tutorials to ensure you understand every concept clearly.'
    },
    {
      'question': 'Will I get help for funded accounts?',
      'answer':
      'Yes, we offer assistance and guidance for funded accounts to help you succeed in your trading journey.'
    },
    {
      'question': 'Will I get support if I have doubt?',
      'answer':
      'Absolutely! We provide dedicated support to help you with any doubts or questions you may have throughout the program.'
    },
    {
      'question': 'Are the sessions live or recorded?',
      'answer':
      'We offer a combination of live interactive sessions and recorded content, allowing you to learn at your own pace while also engaging in real-time discussions.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(text: 'We know you have '),
                      TextSpan(text: '🤔', style: TextStyle(fontSize: 28)),
                      TextSpan(text: ' questions,\nand we come with answers.'),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: List.generate(_faqs.length, (index) {
                    return _buildFAQItem(
                      question: _faqs[index]['question']!,
                      answer: _faqs[index]['answer']!,
                      index: index,
                      isLast: index == _faqs.length - 1,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem({
    required String question,
    required String answer,
    required int index,
    required bool isLast,
  }) {
    final isExpanded = _expandedIndex == index;

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0c0a0a).withOpacity(0.97),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedIndex = isExpanded ? null : index;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.125 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 24,
                        color: isExpanded
                            ? Colors.white
                            : const Color(0xFF888888),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: isExpanded ? null : 0,
            child: isExpanded
                ? Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 22),
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFFaaaaaa),
                  height: 1.6,
                ),
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}