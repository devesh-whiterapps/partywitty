import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuSection extends StatefulWidget {
  const MenuSection({super.key});

  @override
  State<MenuSection> createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {
  String selectedMenuType = 'Food Menu';
  String selectedCategory = 'All';
  Map<String, bool> expandedSections = {
    'Veg Starters': true,
    'Veg Main course': false,
    'Desert': false,
    'Alcohol': false,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pass Menu Menu',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 10),
            _buildVegNonVegToggle(),
          ],
        ),
        const SizedBox(height: 15),

        // Menu Type Tabs (Food Menu / Bar Menu)
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F1F6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              _buildMenuTab('Food Menu', selectedMenuType == 'Food Menu'),
              _buildMenuTab('Bar Menu', selectedMenuType == 'Bar Menu'),
            ],
          ),
        ),
        const SizedBox(height: 15),

        // Category Tabs
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F1F6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryTab('All'),
                _buildCategoryTab('Starters'),
                _buildCategoryTab('Soups'),
                _buildCategoryTab('Indian Mains'),
                _buildCategoryTab('Dessert'),
                _buildCategoryTab('Beverage'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Menu Content
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              _buildExpandableSection('Veg Starters', '(Select Any 3)'),
              const SizedBox(height: 10),
              _buildExpandableSection('Veg Main course', '(Select Any 3)'),
              const SizedBox(height: 10),
              _buildExpandableSection('Desert', '(Select Any 3)'),
              const SizedBox(height: 10),
              _buildExpandableSection('Alcohol', '(Select Any 2)'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVegNonVegToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFF3CBD53),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF3CBD53), width: 2),
            ),
            child: const Center(
              child: CircleAvatar(
                radius: 3,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'Veg',
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTab(String title, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedMenuType = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF7464E4) : const Color(0xFFD4C6E1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String category) {
    final isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7464E4) : const Color(0xFFD4C6E1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          category,
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableSection(String title, String subtitle) {
    final isExpanded = expandedSections[title] ?? false;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          // Header
          GestureDetector(
            onTap: () {
              setState(() {
                expandedSections[title] = !isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      subtitle,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF7464E4),
                      ),
                    ),
                  ],
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.black54,
                ),
              ],
            ),
          ),

          // Content
          if (isExpanded) ...[
            const SizedBox(height: 10),
            ...List.generate(
              4,
                  (index) => _buildMenuItem(
                'Corn Chaat',
                'Lorem Ipsum is simply dummy',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuItem(String name, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: const DecorationImage(
                image: NetworkImage('https://picsum.photos/60/60'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF3CBD53), width: 2),
                      ),
                      child: const Center(
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: Color(0xFF3CBD53),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      name,
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'View More',
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Checkbox
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF7464E4), width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}