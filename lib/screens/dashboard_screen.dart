import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../providers/auth_provider.dart';
import '../providers/list_provider.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/donut_chart.dart';
import '../widgets/stat_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_bottom_nav.dart';
import 'calling_queue_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final listProvider = Provider.of<ListProvider>(context, listen: false);
      final userId = auth.currentUser?.id ?? '68626f9497757cb741f449b0';
      listProvider.fetchLists(userId);
    });
  }

  void _openCallingQueue() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CallingQueueScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context);
    final details = listProvider.listDetails;
    final listName = listProvider.selectedList?.name ?? 'Test List';

    final pending = details?.pending ?? 27;
    final called = details?.called ?? 23;
    final rescheduled = details?.rescheduled ?? 11;
    final totalCalls = details?.totalCalls ?? 50;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary, size: 26),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.replay_rounded, color: AppColors.textPrimary, size: 22),
            onPressed: () {
              if (listProvider.selectedList != null) {
                listProvider.fetchListDetails(listProvider.selectedList!.id);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary, size: 22),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: listProvider.isLoading && details == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: [
                    // Top List Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listName,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '$totalCalls',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' CALLS',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textSecondary,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'S',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Donut Chart
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          DonutChart(
                            pending: pending,
                            called: called,
                            rescheduled: rescheduled,
                            size: 200,
                            strokeWidth: 34,
                          ),
                          // Subtle inner circle
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.9),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 3 Metric Cards Side-by-Side
                    Row(
                      children: [
                        StatCard(
                          title: 'Pending',
                          count: pending,
                          accentColor: AppColors.pending,
                          onTap: _openCallingQueue,
                        ),
                        const SizedBox(width: 8),
                        StatCard(
                          title: 'Done',
                          count: called,
                          accentColor: AppColors.called,
                          onTap: _openCallingQueue,
                        ),
                        const SizedBox(width: 8),
                        StatCard(
                          title: 'Schedule',
                          count: rescheduled,
                          accentColor: AppColors.rescheduled,
                          onTap: _openCallingQueue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Start Calling Now Button
                    CustomButton(
                      text: 'Start Calling Now',
                      onPressed: _openCallingQueue,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _navIndex,
        onTap: (index) {
          setState(() => _navIndex = index);
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
          } else if (index == 2) {
            _openCallingQueue();
          }
        },
        onCenterTap: _openCallingQueue,
      ),
    );
  }
}
