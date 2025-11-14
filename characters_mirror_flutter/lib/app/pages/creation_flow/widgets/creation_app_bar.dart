import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_progression.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';

class CreationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onNext;

  const CreationAppBar(
      {super.key, required this.title, this.onBack, this.onNext});

  @override
  Size get preferredSize => const Size.fromHeight(220);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 1.0,
            ),
          ),
        ),
        child: PageSizeLimiter(
          child: Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      if (onBack != null)
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: onBack,
                        ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (onNext != null)
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: onNext,
                        ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 1000
                        ? 1000
                        : MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: CreationProgression(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
