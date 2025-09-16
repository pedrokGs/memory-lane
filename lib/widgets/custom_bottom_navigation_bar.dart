import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(
        label: "Home",
        iconOutlined: "assets/icons/home-outlined.svg",
        iconFilled: "assets/icons/home-filled.svg",
      ),
      _NavItem(
        label: "Explore",
        iconOutlined: "assets/icons/search-outlined.svg",
        iconFilled: "assets/icons/search-filled.svg",
      ),
      _NavItem(
        label: "Settings",
        iconOutlined: "assets/icons/settings-outlined.svg",
        iconFilled: "assets/icons/settings-filled.svg",
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFFC9C9C9B3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onItemTapped(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.lightGreen.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  AnimatedScale(
                    scale: isSelected ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    child: SvgPicture.asset(
                      isSelected ? item.iconFilled : item.iconOutlined,
                      width: 26,
                      height: 26,
                      colorFilter: ColorFilter.mode(
                        isSelected ? Colors.blue : Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: isSelected
                        ? Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        item.label,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String iconOutlined;
  final String iconFilled;

  _NavItem({
    required this.label,
    required this.iconOutlined,
    required this.iconFilled,
  });
}
