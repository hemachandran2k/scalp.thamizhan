import 'package:flutter/material.dart';
import 'dart:async';

class CustomTickerTape extends StatefulWidget {
  const CustomTickerTape({super.key});

  @override
  State<CustomTickerTape> createState() => _CustomTickerTapeState();
}

class _CustomTickerTapeState extends State<CustomTickerTape> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  final List<Map<String, dynamic>> _tickerData = [
    {'name': 'EUR/USD', 'price': '1.0921', 'change': '+0.0012', 'up': true},
    {'name': 'USD/JPY', 'price': '156.42', 'change': '-0.32', 'up': false},
    {'name': 'GBP/USD', 'price': '1.2745', 'change': '-0.0025', 'up': false},
    {'name': 'USD/CHF', 'price': '0.9156', 'change': '+0.0018', 'up': true},
    {'name': 'AUD/USD', 'price': '0.6234', 'change': '+0.0045', 'up': true},
    {'name': 'USD/CAD', 'price': '1.4325', 'change': '-0.0015', 'up': false},
    {'name': 'NZD/USD', 'price': '0.5678', 'change': '+0.0032', 'up': true},
    {'name': 'XAG/USD', 'price': '28.45', 'change': '+0.35', 'up': true},
    {'name': 'XAU/USD', 'price': '2,345.10', 'change': '+12.50', 'up': true},
    {
      'name': 'NASDAQ100',
      'price': '21,234.50',
      'change': '+145.30',
      'up': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startScrolling();
  }

  void _startScrolling() {
    _timer = Timer.periodic(const Duration(milliseconds: 15), (timer) {
      if (_scrollController.hasClients) {
        try {
          final position = _scrollController.position;
          final maxScroll = position.maxScrollExtent;
          final currentScroll = position.pixels;

          // Only scroll if maxScrollExtent is valid
          if (maxScroll > 0) {
            if (currentScroll >= maxScroll) {
              _scrollController.jumpTo(0);
            } else {
              _scrollController.jumpTo(currentScroll + 2);
            }
          }
        } catch (e) {
          // Silently handle any scroll position errors during initialization
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Triple the items for seamless loop
    final allItems = [..._tickerData, ..._tickerData, ..._tickerData];

    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF0BE348).withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: ClipRect(
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allItems.length,
          itemBuilder: (context, index) {
            final item = allItems[index];
            return _buildTickerItem(item);
          },
        ),
      ),
    );
  }

  Widget _buildTickerItem(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Symbol Name
          Text(
            item['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'JetBrains Mono',
            ),
          ),
          const SizedBox(width: 12),

          // Price
          Text(
            item['price'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'JetBrains Mono',
            ),
          ),
          const SizedBox(width: 12),

          // Change with icon
          Row(
            children: [
              Icon(
                item['up'] ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color:
                    item['up']
                        ? const Color(0xFF0BE348)
                        : const Color(0xFFF44336),
                size: 18,
              ),
              Text(
                item['change'],
                style: TextStyle(
                  color:
                      item['up']
                          ? const Color(0xFF0BE348)
                          : const Color(0xFFF44336),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
