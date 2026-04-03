import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF162A1E), // Dark green base
      highlightColor: const Color(0xFF1F4129), // Lighter green highlight
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
    );
  }
}

class SurahListSkeleton extends StatelessWidget {
  const SurahListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: SkeletonLoader(
            width: 408.w,
            height: 82.h,
            borderRadius: 24,
          ),
        );
      },
    );
  }
}

class BookmarkSkeleton extends StatelessWidget {
  const BookmarkSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(20.w),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: SkeletonLoader(
            width: double.infinity,
            height: 220.h,
            borderRadius: 25,
          ),
        );
      },
    );
  }
}

class HighlightSkeleton extends StatelessWidget {
  const HighlightSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SkeletonLoader(width: 48.w, height: 48.w, borderRadius: 24),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLoader(width: 150.w, height: 18.h),
                        SizedBox(height: 8.h),
                        SkeletonLoader(width: 100.w, height: 12.h),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              SkeletonLoader(width: double.infinity, height: 120.h, borderRadius: 25),
            ],
          ),
        );
      },
    );
  }
}
