import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final User? user = FirebaseAuth.instance.currentUser;
  bool _isSubmittingFeedback = false;

  Future<void> storeQuizResult(int score, int total, String level) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('quiz_scores').add({
      'userId': user.uid,
      'email': user.email,
      'score': score,
      'total': total,
      'level': level,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void _showCuteFeedbackMessage(String feedbackType) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    double opacity = 0.0;
    String currentMessage = '';
    Color messageColor = Colors.teal; // Default color

    // Determine the feedback-specific message and color
    switch (feedbackType) {
      case 'Satisfied':
        currentMessage = 'Thank you for your positive feedback! 🌟';
        messageColor = Colors.green.shade600;
        break;
      case 'Dissatisfied':
        currentMessage = 'We appreciate your honesty. We\'ll do better! 💪';
        messageColor = Colors.orange.shade600;
        break;
      case 'Average':
        currentMessage = 'Thanks for sharing! We value your input. ✨';
        messageColor = Colors.blue.shade600;
        break;
      default:
        currentMessage = 'Thank you for your feedback! 🙏';
        messageColor = Colors.teal.shade600;
    }

    final AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    final Animation<double> scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ),
    );

    final Animation<double> fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    overlayEntry = OverlayEntry(
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 500),
              onEnd: () {
                overlayEntry.remove();
                controller.dispose();
              },
              child: ScaleTransition(
                scale: scaleAnimation,
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            messageColor.withOpacity(0.9),
                            messageColor.withOpacity(0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 2,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              feedbackType == 'Satisfied'
                                  ? Icons.emoji_emotions
                                  : feedbackType == 'Dissatisfied'
                                  ? Icons.sentiment_dissatisfied
                                  : Icons.sentiment_neutral,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Text(
                              currentMessage,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 2,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    overlay.insert(overlayEntry);

    setState(() {
      opacity = 1.0;
    });
    controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          opacity = 0.0;
        });
      }
    });
  }

  void _showFeedbackDialog() {
    String _selectedFeedback = '';
    TextEditingController _commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter dialogSetState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              backgroundColor: Colors.white,
              title: Text(
                'Share Your Feedback',
                style: GoogleFonts.amiri(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Emoji Options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['Satisfied', 'Average', 'Dissatisfied'].map((type) {
                      IconData icon = type == 'Satisfied'
                          ? Icons.emoji_emotions
                          : type == 'Dissatisfied'
                          ? Icons.sentiment_dissatisfied
                          : Icons.sentiment_neutral;
                      Color color = type == 'Satisfied'
                          ? Colors.green
                          : type == 'Dissatisfied'
                          ? Colors.red
                          : Colors.orange;
                      return GestureDetector(
                        onTap: () => dialogSetState(() => _selectedFeedback = type),
                        child: Column(
                          children: [
                            Icon(
                              icon,
                              color: _selectedFeedback == type ? color : Colors.grey,
                              size: 30,
                            ),
                            Text(
                              type,
                              style: TextStyle(
                                color: _selectedFeedback == type ? color : Colors.grey,
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  // Optional Comment Box
                  TextField(
                    controller: _commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Write a comment (optional)',
                      hintStyle: GoogleFonts.poppins(fontSize: 14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: TextStyle(color: Colors.teal.shade600)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade600,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _isSubmittingFeedback
                      ? null
                      : () async {
                    if (_selectedFeedback.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a feedback type')),
                      );
                      return;
                    }
                    if (user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('You must be logged in')),
                      );
                      return;
                    }
                    setState(() => _isSubmittingFeedback = true);
                    try {
                      await FirebaseFirestore.instance.collection('feedback').add({
                        'userId': user!.uid,
                        'email': user!.email,
                        'feedbackType': _selectedFeedback,
                        'comment': _commentController.text.trim(),
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      if (!mounted) return;
                      Navigator.pop(context);
                      _showCuteFeedbackMessage(_selectedFeedback);
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to submit feedback.')),
                      );
                    } finally {
                      if (mounted) {
                        setState(() => _isSubmittingFeedback = false);
                      }
                    }
                  },
                  child: _isSubmittingFeedback
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _logout() async {
    // Keep your original implementation
    try {
      await FirebaseAuth.instance.signOut();
      AuthService.logout();
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[700],
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.feedback, color: Colors.white),
            onPressed: _showFeedbackDialog,
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          // Enhanced Profile Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.teal[700],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                // Profile Avatar
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      user?.email != null && user!.email!.isNotEmpty
                          ? user!.email![0].toUpperCase()
                          : 'U',
                      style: GoogleFonts.poppins(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[700],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // User Info
                Text(
                  user?.email ?? 'Guest User',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  'Quiz Enthusiast',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 16),
                // Stats Row
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('quiz_scores')
                      .where('userId', isEqualTo: user?.uid ?? '')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('Quizzes', '0'),
                          _buildStatItem('Avg Score', '0%'),
                          _buildStatItem('Level', 'Beginner'),
                        ],
                      );
                    }

                    final scores = snapshot.data!.docs;
                    final totalQuizzes = scores.length;
                    double totalPercentage = 0;

                    for (var doc in scores) {
                      final data = doc.data() as Map<String, dynamic>;
                      final score = (data['score'] ?? 0) as int;
                      final total = (data['total'] ?? 1) as int;
                      totalPercentage += (score / total) * 100;
                    }

                    final avgScore = (totalPercentage / totalQuizzes).round();
                    String level;
                    if (avgScore >= 80) {
                      level = 'Advanced';
                    } else if (avgScore >= 50) {
                      level = 'Intermediate';
                    } else {
                      level = 'Beginner';
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Quizzes', '$totalQuizzes'),
                        _buildStatItem('Avg Score', '$avgScore%'),
                        _buildStatItem('Level', level),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // Quiz Results Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quiz History',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.teal[800],
                        ),
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.filter_list, color: Colors.teal[600]),
                      //   // onPressed: () {
                      //   //   // Add filter functionality
                      //   // },
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: user != null
                          ? FirebaseFirestore.instance
                          .collection('quiz_scores')
                          .where('userId', isEqualTo: user!.uid)
                      // .orderBy('timestamp', descending: true)
                          .snapshots()
                          : null,
                      builder: (context, snapshot) {
                        // Loading state
                        if (user == null) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(),
                                const SizedBox(height: 20),
                                Text(
                                  'Please sign in to view your quiz history',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        // Error state
                        if (snapshot.hasError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 50,
                                  color: Colors.red[400],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Failed to load quiz results',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Please check your internet connection',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // Empty state
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.quiz_outlined,
                                  size: 60,
                                  color: Colors.teal.withOpacity(0.3),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'No quiz results yet!',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Complete quizzes to see your history here',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // Data loaded successfully
                        final scores = snapshot.data!.docs;

                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: scores.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final scoreData = scores[index].data() as Map<String, dynamic>;
                            final score = scoreData['score'] ?? 0;
                            final total = scoreData['total'] ?? 1;
                            final percentage = (score / total * 100).round();
                            final level = scoreData['level']?.toString() ?? 'General';
                            final timestamp = (scoreData['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now();
                            final dateStr = '${timestamp.day}/${timestamp.month}/${timestamp.year}';

                            return _buildQuizResultCard(
                              percentage: percentage,
                              level: level,
                              score: score,
                              total: total,
                              dateStr: dateStr,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildQuizResultCard({
    required int percentage,
    required String level,
    required int score,
    required int total,
    required String dateStr,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getScoreColor(percentage).withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              '$percentage%',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: _getScoreColor(percentage),
              ),
            ),
          ),
        ),
        title: Text(
          '${level[0].toUpperCase()}${level.substring(1)} Quiz',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '$score out of $total • $dateStr',
          style: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          _getScoreIcon(percentage),
          color: _getScoreColor(percentage),
        ),
      ),
    );
  }

  Color _getScoreColor(int percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 50) return Colors.orange;
    return Colors.red;
  }

  IconData _getScoreIcon(int percentage) {
    if (percentage >= 80) return Icons.emoji_events;
    if (percentage >= 50) return Icons.check_circle;
    return Icons.error_outline;
  }

  @override
  void dispose() {
    super.dispose();
  }
}