// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import '../../theme_singleton.dart';

class CustomEntryField extends StatefulWidget {
  const CustomEntryField({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomEntryField> createState() => _CustomEntryFieldState();
}

class _CustomEntryFieldState extends State<CustomEntryField> {
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Filters",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildFilterOption(Icons.list, 'All', 'All Animations'),
          _buildFilterOption(Icons.tv, 'TV', 'TV Shows'),
          _buildFilterOption(Icons.movie, 'Movie', 'Movies'),
          _buildFilterOption(Icons.upcoming, 'Upcoming', 'Upcoming'),
        ],
      ),
    );
  }

  Widget _buildFilterOption(IconData icon, String filter, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        setState(() {
          // selectedFilter = filter;
        });
        //context.read<AnimeCubit>().loadAnimeList(filter: selectedFilter);
        Navigator.pop(context);
      },
    );
  }
}
