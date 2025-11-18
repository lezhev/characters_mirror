import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ClassStepShimmer extends StatelessWidget {
  const ClassStepShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = appWidth > 680
        ? 4
        : appWidth > 420
            ? 3
            : 2;

    return Scaffold(
      //TODO: when compete app bar, fix it
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: 12, // количество "скелетных" плиток
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: colorScheme.primary.withAlpha(80),
              highlightColor: colorScheme.primary.withAlpha(40),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(96),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withAlpha(20),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Круглая иконка
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Полоска текста
                    Container(
                      width: 64,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface.withAlpha(80),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(2, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Shimmer.fromColors(
                baseColor: colorScheme.primary.withAlpha(80),
                highlightColor: colorScheme.primary.withAlpha(40),
                child: Container(
                  height: 48,
                  width: 152,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
