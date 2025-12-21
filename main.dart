import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Content Performance Report',
      theme: ThemeData(
        primaryColor: Color(0xFF3498DB),
        scaffoldBackgroundColor: Color(0xFFF7F9FC),
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
          bodyMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF2C3E50),
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xFF2C3E50),
          ),
        ),
      ),
      home: ContentPerformanceReport(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContentPerformanceReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F9FC),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 1000, // Increased width for better layout
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header Section
                  _buildHeaderSection(),
                  SizedBox(height: 24),

                  // Middle Section - Three Columns
                  _buildMiddleSection(),
                  SizedBox(height: 24),

                  // Footer Section
                  _buildFooterSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xFFE8F4F8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3498DB).withOpacity(0.1),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3498DB),
                      Color(0xFF2ECC71),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.analytics,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Content Performance Report',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Period: August 2029',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2C3E50).withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          _buildStatsBox(),
        ],
      ),
    );
  }

  Widget _buildStatsBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFF0F7FF),
            Color(0xFFE8F5E9),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF3498DB).withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('Total Reach', '950,920', Icons.people, Color(0xFF3498DB)),
          _buildVerticalDivider(),
          _buildStatItem('Engagement', '42.3%', Icons.trending_up, Color(0xFF2ECC71)),
          _buildVerticalDivider(),
          _buildStatItem('Website Traffic', '54,000', Icons.link, Color(0xFF9B59B6)),
          _buildVerticalDivider(),
          _buildStatItem('Avg. Session', '4:32m', Icons.timer, Color(0xFFF39C12)),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.grey.shade300,
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 18,
                color: color,
              ),
            ),
            SizedBox(width: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF2C3E50).withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildMiddleSection() {
    return Column(
      children: [
        // First Row - Two Charts
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildChartCard(
                'Social Media Engagement',
                _buildLineChart(),
                Icons.show_chart,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: _buildChartCard(
                'Performance by Type',
                _buildPieChart(),
                Icons.pie_chart,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        // Second Row - Two Charts
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildChartCard(
                'Quarterly Sessions',
                _buildQuarterLineChart(),
                Icons.calendar_today,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: _buildChartCard(
                'Follower Growth',
                _buildBarChart(),
                Icons.bar_chart,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterSection() {
    return _buildChartCard(
      'Peak Engagement Times',
      _buildDonutChart(),
      Icons.access_time,
    );
  }

  Widget _buildChartCard(String title, Widget chart, IconData icon) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, // Changed to solid white
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3498DB).withOpacity(0.1),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3498DB),
                      Color(0xFF2ECC71),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          chart,
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    return Container(
      height: 200, // Changed from 220 to 200 to match pie chart height
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12), // Reduced padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSeriesLegend('Instagram', Color(0xFF3498DB)),
                _buildSeriesLegend('Facebook', Color(0xFF2ECC71)),
                _buildSeriesLegend('Twitter', Color(0xFF9B59B6)),
                _buildSeriesLegend('LinkedIn', Color(0xFFF39C12)),
              ],
            ),
          ),
          Expanded(
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.white,
                    tooltipBorder: BorderSide(color: Color(0xFF3498DB), width: 1),
                    tooltipRoundedRadius: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        'Week ${group.x + 1}\n${rod.toY.toInt()}k engagement',
                        TextStyle(
                          color: Color(0xFF3498DB),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                alignment: BarChartAlignment.spaceAround,
                minY: 0,
                maxY: 50,
                groupsSpace: 20,
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: EdgeInsets.only(top: 6), // Reduced padding
                          child: Text(
                            'Week ${value.toInt() + 1}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF2C3E50).withOpacity(0.7),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}k',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF2C3E50).withOpacity(0.7),
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Color(0xFF3498DB).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 10,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Color(0xFF3498DB).withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 10,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3498DB),
                            Color(0xFF2ECC71),
                          ],
                        ),
                        width: 24,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 25,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3498DB),
                            Color(0xFF2ECC71),
                          ],
                        ),
                        width: 24,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 15,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3498DB),
                            Color(0xFF2ECC71),
                          ],
                        ),
                        width: 24,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 35,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3498DB),
                            Color(0xFF2ECC71),
                          ],
                        ),
                        width: 24,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        toY: 20,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3498DB),
                            Color(0xFF2ECC71),
                          ],
                        ),
                        width: 24,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeriesLegend(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 4,
          color: color,
        ),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF2C3E50).withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildPieChart() {
    return Container(
      height: 200, // Same height as line chart
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 50,
                sections: [
                  PieChartSectionData(
                    value: 64.9,
                    color: Color(0xFF3498DB),
                    radius: 55,
                    title: '64.9%',
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: 21.2,
                    color: Color(0xFF2ECC71),
                    radius: 55,
                    title: '21.2%',
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: 7.9,
                    color: Color(0xFF9B59B6),
                    radius: 55,
                    title: '7.9%',
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: 6.0,
                    color: Color(0xFFF39C12),
                    radius: 55,
                    title: '6.0%',
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem('Video', Color(0xFF3498DB)),
                SizedBox(height: 8),
                _buildLegendItem('Picture', Color(0xFF2ECC71)),
                SizedBox(height: 8),
                _buildLegendItem('Text', Color(0xFF9B59B6)),
                SizedBox(height: 8),
                _buildLegendItem('Link', Color(0xFFF39C12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color,
                color.withOpacity(0.8),
              ],
            ),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF2C3E50),
          ),
        ),
      ],
    );
  }

  Widget _buildQuarterLineChart() {
    return Container(
      height: 180, // Changed from 220 to 180 to match follower growth chart height
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12), // Reduced padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSeriesLegend('Series 1', Color(0xFF3498DB)),
                _buildSeriesLegend('Series 2', Color(0xFF2ECC71)),
                _buildSeriesLegend('Series 3', Color(0xFF9B59B6)),
                _buildSeriesLegend('Series 4', Color(0xFFF39C12)),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background for chart area
                borderRadius: BorderRadius.circular(8),
              ),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 4,
                  minY: 0,
                  maxY: 50,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 10,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Color(0xFF3498DB).withOpacity(0.1),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Color(0xFF3498DB).withOpacity(0.05),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          List<String> months = ['Q1', 'Q2', 'Q3', 'Q4', 'Q5'];
                          return Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              months[value.toInt()],
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF2C3E50).withOpacity(0.7),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                fontSize: 10, // Smaller font size
                                color: Color(0xFF2C3E50).withOpacity(0.7),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Color(0xFF3498DB).withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 15),
                        FlSpot(1, 30),
                        FlSpot(2, 20),
                        FlSpot(3, 40),
                        FlSpot(4, 25),
                      ],
                      isCurved: false,
                      color: Color(0xFF3498DB),
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Color(0xFF3498DB),
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: false,
                      ),
                    ),
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 10),
                        FlSpot(1, 25),
                        FlSpot(2, 35),
                        FlSpot(3, 20),
                        FlSpot(4, 45),
                      ],
                      isCurved: false,
                      color: Color(0xFF2ECC71),
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Color(0xFF2ECC71),
                          );
                        },
                      ),
                    ),
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 20),
                        FlSpot(1, 15),
                        FlSpot(2, 25),
                        FlSpot(3, 35),
                        FlSpot(4, 30),
                      ],
                      isCurved: false,
                      color: Color(0xFF9B59B6),
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Color(0xFF9B59B6),
                          );
                        },
                      ),
                    ),
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 5),
                        FlSpot(1, 20),
                        FlSpot(2, 10),
                        FlSpot(3, 30),
                        FlSpot(4, 15),
                      ],
                      isCurved: false,
                      color: Color(0xFFF39C12),
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Color(0xFFF39C12),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      height: 180,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.white,
              tooltipBorder: BorderSide(color: Color(0xFF3498DB), width: 1),
              tooltipRoundedRadius: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String platform;
                Color color;
                switch (group.x) {
                  case 0:
                    platform = 'Photo';
                    color = Color(0xFF3498DB);
                    break;
                  case 1:
                    platform = 'Video';
                    color = Color(0xFF2ECC71);
                    break;
                  case 2:
                    platform = 'Text';
                    color = Color(0xFF9B59B6);
                    break;
                  case 3:
                    platform = 'Link';
                    color = Color(0xFFF39C12);
                    break;
                  default:
                    platform = 'Unknown';
                    color = Colors.grey;
                }
                return BarTooltipItem(
                  '$platform\n${rod.toY.toInt()} followers',
                  TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: '\nGrowth: ${(rod.toY / 5000 * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: Color(0xFF2C3E50).withOpacity(0.7),
                        fontSize: 10,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          alignment: BarChartAlignment.spaceAround,
          minY: 0,
          maxY: 6000,
          groupsSpace: 20,
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  List<String> titles = ['Photo', 'Video', 'Text', 'Link'];
                  return Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      titles[value.toInt()],
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF2C3E50).withOpacity(0.7),
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 2000,
                getTitlesWidget: (value, meta) {
                  if (value == 0) return SizedBox();
                  return Text(
                    '${(value / 1000).toStringAsFixed(0)}k',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF2C3E50).withOpacity(0.7),
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 2000,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Color(0xFF3498DB).withOpacity(0.1),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Color(0xFF3498DB).withOpacity(0.2),
              width: 1,
            ),
          ),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 5000,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3498DB),
                      Color(0xFF2ECC71),
                    ],
                  ),
                  width: 24,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: 2000,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3498DB),
                      Color(0xFF2ECC71),
                    ],
                  ),
                  width: 24,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  toY: 1000,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3498DB),
                      Color(0xFF2ECC71),
                    ],
                  ),
                  width: 24,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(
                  toY: 500,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3498DB),
                      Color(0xFF2ECC71),
                    ],
                  ),
                  width: 24,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonutChart() {
    return Container(
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTimeSegment('Morning', 8, Color(0xFF3498DB)),
          _buildTimeSegment('Afternoon', 26, Color(0xFF2ECC71)),
          _buildTimeSegment('Evening', 34, Color(0xFF9B59B6)),
          _buildTimeSegment('Night', 32, Color(0xFF34495E)),
        ],
      ),
    );
  }

  Widget _buildTimeSegment(String time, int percentage, Color color) {
    final size = 70.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: 6,
                backgroundColor: Color(0xFFE8F4F8),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$percentage%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2C3E50).withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}