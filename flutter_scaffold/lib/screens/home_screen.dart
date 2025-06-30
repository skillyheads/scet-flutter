import 'package:flutter/material.dart';
import '../models/follower.dart';
import '../services/storage_service.dart';
import '../widgets/follower_card.dart';
import '../utils/responsive_utils.dart';
import '../themes/app_theme.dart';
import 'add_follower_screen.dart';
import 'edit_follower_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Follower> followers = [];
  List<Follower> filteredFollowers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadFollowers();
    searchController.addListener(_filterFollowers);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadFollowers() async {
    final loadedFollowers = await StorageService.loadFollowers();
    setState(() {
      followers = loadedFollowers;
      filteredFollowers = List.from(followers);
    });
  }

  Future<void> saveFollowers() async {
    await StorageService.saveFollowers(followers);
  }

  void _filterFollowers() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredFollowers = followers
          .where(
            (follower) => follower.mobileNumber.toLowerCase().contains(query),
          )
          .toList();
    });
  }

  void _addFollower(Follower newFollower) {
    setState(() {
      followers.add(newFollower);
      _filterFollowers();
    });
    saveFollowers();
  }

  void _updateFollower(Follower updatedFollower) {
    setState(() {
      final index = followers.indexWhere((f) => f.id == updatedFollower.id);
      if (index != -1) {
        followers[index] = updatedFollower;
        _filterFollowers();
      }
    });
    saveFollowers();
  }

  void _deleteFollower(String followerId) {
    setState(() {
      followers.removeWhere((f) => f.id == followerId);
      _filterFollowers();
    });
    saveFollowers();
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = ResponsiveUtils.isTablet(context);
    final cardPadding = ResponsiveUtils.getCardPadding(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Followers'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(isLargeScreen ? 70 : 60),
          child: Padding(
            padding: EdgeInsets.all(cardPadding),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by mobile number...',
                prefixIcon: Icon(Icons.search, color: AppTheme.primaryBlue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.primaryBlue.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.primaryBlue, width: 2),
                ),
                filled: true,
                fillColor: AppTheme.primaryBlue.shade50,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: isLargeScreen ? 16 : 12,
                ),
              ),
            ),
          ),
        ),
      ),
      body: filteredFollowers.isEmpty
          ? _buildEmptyState(context)
          : _buildFollowersList(context, cardPadding),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFollowerScreen()),
          );
          if (result != null) {
            _addFollower(result);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final isLargeScreen = ResponsiveUtils.isTablet(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: isLargeScreen ? 120 : 80,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16),
          Text(
            searchController.text.isEmpty
                ? 'No followers yet'
                : 'No followers found',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 18),
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (searchController.text.isEmpty)
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'Tap the + button to add your first follower',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: ResponsiveUtils.getFontSize(context, 14),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFollowersList(BuildContext context, double padding) {
    final crossAxisCount = ResponsiveUtils.getCrossAxisCount(context);

    if (crossAxisCount == 1) {
      return ListView.builder(
        padding: EdgeInsets.all(padding),
        itemCount: filteredFollowers.length,
        itemBuilder: (context, index) {
          return FollowerCard(
            follower: filteredFollowers[index],
            onTap: () => _navigateToEdit(filteredFollowers[index]),
          );
        },
      );
    } else {
      return GridView.builder(
        padding: EdgeInsets.all(padding),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 3.5,
        ),
        itemCount: filteredFollowers.length,
        itemBuilder: (context, index) {
          return FollowerCard(
            follower: filteredFollowers[index],
            onTap: () => _navigateToEdit(filteredFollowers[index]),
          );
        },
      );
    }
  }

  Future<void> _navigateToEdit(Follower follower) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFollowerScreen(follower: follower),
      ),
    );

    if (result != null) {
      if (result == 'deleted') {
        _deleteFollower(follower.id);
      } else {
        _updateFollower(result);
      }
    }
  }
}
