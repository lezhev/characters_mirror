import 'dart:typed_data';

import 'package:characters_mirror_flutter/features/character_portrait/application/character_portrait_controller.dart';
import 'package:characters_mirror_flutter/features/character_portrait/application/character_portrait_image_processor.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CharacterPortraitEditor extends ConsumerStatefulWidget {
  const CharacterPortraitEditor({
    required this.characterId,
    this.onUploaded,
    super.key,
  });

  final int characterId;
  final VoidCallback? onUploaded;

  @override
  ConsumerState<CharacterPortraitEditor> createState() =>
      _CharacterPortraitEditorState();
}

class _CharacterPortraitEditorState
    extends ConsumerState<CharacterPortraitEditor> {
  final _picker = ImagePicker();
  final _cropController = CropController();

  Uint8List? _image;
  bool _isCropping = false;
  bool _isProcessing = false;

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) {
      return;
    }

    final bytes = await image.readAsBytes();

    if (!mounted) {
      return;
    }

    setState(() {
      _image = bytes;
    });
  }

  void _crop() {
    if (_image == null || _isCropping || _isProcessing) {
      return;
    }

    setState(() {
      _isCropping = true;
    });

    _cropController.crop();
  }

  Future<void> _handleCropped(CropResult result) async {
    switch (result) {
      case CropSuccess(:final croppedImage):
        setState(() {
          _isCropping = false;
          _isProcessing = true;
        });

        try {
          final processed = await processCharacterPortrait(
            croppedImage,
          );

          if (!mounted) {
            return;
          }

          await ref
              .read(
                characterPortraitControllerProvider(
                  widget.characterId,
                ).notifier,
              )
              .upload(processed);

          if (!mounted) {
            return;
          }

          widget.onUploaded?.call();
        } catch (error) {
          if (!mounted) {
            return;
          }

          _showError(
            'Не удалось загрузить портрет: $error',
          );
        } finally {
          if (mounted) {
            setState(() {
              _isProcessing = false;
            });
          }
        }

      case CropFailure(:final cause):
        setState(() {
          _isCropping = false;
        });

        _showError(
          'Не удалось обрезать изображение: $cause',
        );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final image = _image;
    final portrait = ref.watch(
      characterPortraitControllerProvider(
        widget.characterId,
      ),
    );

    final isBusy = _isCropping || _isProcessing || portrait.isLoading;

    if (image == null) {
      return Center(
        child: FilledButton.icon(
          onPressed: isBusy ? null : _pickImage,
          icon: const Icon(Icons.image_outlined),
          label: const Text('Выбрать изображение'),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Crop(
            image: image,
            controller: _cropController,
            onCropped: _handleCropped,
            aspectRatio: 1,
            interactive: true,
            fixCropRect: true,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: isBusy ? null : _pickImage,
              child: const Text('Другое изображение'),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: isBusy ? null : _crop,
              child: isBusy
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Готово'),
            ),
          ],
        ),
      ],
    );
  }
}
