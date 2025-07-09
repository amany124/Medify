import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../presentation/cubit/notification_cubit.dart';
import '../widgets/appointment_notification_tile.dart';
import '../widgets/section_title.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getUpcomingAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFF),
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff1B5A8C),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(Icons.arrow_back_ios),
        //   color: const Color(0xff1B5A8C),
        // ),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff2260FF),
                strokeWidth: 3,
              ),
            );
          }

          if (state is NotificationError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Color(0xFFE74C3C),
                  ),
                  const Gap(16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5A6C7D),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<NotificationCubit>()
                          .getUpcomingAppointments();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2260FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is NotificationLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                // Refresh the notifications
                print('Refreshing notifications...');
                context.read<NotificationCubit>().getUpcomingAppointments();
              },
              child: _buildNotificationsList(state.groupedAppointments),
            );
          }

          return const Center(
            child: Text('No notifications available'),
          );
        },
      ),
    );
  }

  Widget _buildNotificationsList(
      Map<String, List<dynamic>> groupedAppointments) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          // Today Section
          if (groupedAppointments['Today']?.isNotEmpty ?? false) ...[
            _buildSectionHeader('Today'),
            const Gap(15),
            ...groupedAppointments['Today']!.map(
              (appointment) => AppointmentNotificationTile(
                appointment: appointment,
                timeAgo: _getTimeAgo(appointment.createdAt),
              ),
            ),
            const Gap(20),
          ],

          // Tomorrow Section
          if (groupedAppointments['Tomorrow']?.isNotEmpty ?? false) ...[
            _buildSectionHeader('Tomorrow'),
            const Gap(15),
            ...groupedAppointments['Tomorrow']!.map(
              (appointment) => AppointmentNotificationTile(
                appointment: appointment,
                timeAgo: _getTimeAgo(appointment.createdAt),
              ),
            ),
            const Gap(20),
          ],

          // Yesterday Section
          if (groupedAppointments['Yesterday']?.isNotEmpty ?? false) ...[
            _buildSectionHeader('Yesterday'),
            const Gap(15),
            ...groupedAppointments['Yesterday']!.map(
              (appointment) => AppointmentNotificationTile(
                appointment: appointment,
                timeAgo: _getTimeAgo(appointment.createdAt),
              ),
            ),
            const Gap(20),
          ],

          // Other appointments
          if (groupedAppointments['Other']?.isNotEmpty ?? false) ...[
            _buildSectionHeader('Earlier'),
            const Gap(15),
            ...groupedAppointments['Other']!.map(
              (appointment) => AppointmentNotificationTile(
                appointment: appointment,
                timeAgo: _getTimeAgo(appointment.createdAt),
              ),
            ),
            const Gap(20),
          ],

          // Activity Section
          _buildSectionHeader('Activity'),
          const Gap(15),
          // TODO: Activity items will be added here later
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE8F1FF),
                width: 1,
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.history,
                  color: Color(0xFF7F8C8D),
                  size: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Activity notifications will appear here',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7F8C8D),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),

          // If no appointments, show placeholder
          if (_hasNoAppointments(groupedAppointments)) ...[
            const Gap(50),
            const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.notifications_none_outlined,
                    size: 80,
                    color: Color(0xFFBDC3C7),
                  ),
                  Gap(20),
                  Text(
                    'No appointment notifications',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF7F8C8D),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(8),
                  Text(
                    'You\'ll see your upcoming appointments here',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFBDC3C7),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SectionTitle(title: title),
        if (title == 'Today')
          GestureDetector(
            onTap: () {
              // Mark all as read functionality can be added here
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xff2260FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Mark all',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff2260FF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }

  bool _hasNoAppointments(Map<String, List<dynamic>> groupedAppointments) {
    return groupedAppointments.values.every((list) => list.isEmpty);
  }
}
