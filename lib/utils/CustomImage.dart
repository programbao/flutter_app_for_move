import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final String errorImagePath;
  final BoxFit fit;

  const CustomImage({
    required this.url,
    this.width = 0.0,
    this.height = 0.0,
    this.errorImagePath = 'assets/img/loading-fail.png',
    this.fit = BoxFit.cover,
  });

  @override
  _CustomImageState createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  ImageProvider? _imageProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // 在构建阶段完成后执行
      _loadImage();
    });
    // _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final networkImage = NetworkImage(widget.url);
      final imageConfig = createLocalImageConfiguration(context);
      final imageStreamCompleter = networkImage.resolve(imageConfig);
      final listener = ImageStreamListener(
        (ImageInfo imageInfo, bool synchronousCall) {
          setState(() {
            _imageProvider = networkImage;
          });
        },
        onError: (dynamic error, StackTrace? stackTrace, {String? context}) {
          debugPrint('Failed to load image from URL: ${widget.url}');
          setState(() {
            _imageProvider = AssetImage(widget.errorImagePath);
          });
        },
      );

      imageStreamCompleter.addListener(listener);
    } catch (error) {
      debugPrint('Failed to load image from URL: ${widget.url}');
      setState(() {
        _imageProvider = AssetImage(widget.errorImagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('20394809234j $_imageProvider');
    return _imageProvider != null
        ? Image(
            image: _imageProvider!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          )
        : Image.asset(
            widget.errorImagePath,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          );
  }
}
