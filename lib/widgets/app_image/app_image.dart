import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants/app_api_url.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images_path.dart';
import '../../utils/app_all_log/error_log.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.color = AppColors.grey,
    this.fit = BoxFit.fill,
    this.height,
    this.path,
    this.url,
    this.width,
    this.filePath,
    this.iconColor,
  });

  final String? path;
  final String? filePath;
  final String? url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _buildImage(),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  Widget _buildImage() {
    if (filePath != null) {
      return Image.file(
        File(filePath!),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          errorLog("Error loading file image:", error);
          return _buildPlaceholder();
        },
      );
    }

    if (url != null) {
      if (url!.toLowerCase().contains("null")) {
        return _buildPlaceholder();
      }
      return NetworkImageWithRetry(
        imageUrl: url!,
        width: width,
        height: height,
        fit: fit,
      );
    }

    if (path != null) {
      return Image.asset(
        path!,
        width: width,
        height: height,
        fit: fit,
        color: iconColor,
        errorBuilder: (context, error, stackTrace) {
          errorLog("Error loading asset image:", error);
          return _buildPlaceholder();
        },
      );
    }

    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}

class NetworkImageWithRetry extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const NetworkImageWithRetry({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
  });

  @override
  State createState() => _NetworkImageWithRetryState();
}

class _NetworkImageWithRetryState extends State<NetworkImageWithRetry> {
  int _retryCount = 0;
  final int _maxRetries = 3;
  String? _image;

  @override
  void initState() {
    super.initState();
    _setImage();
  }

  void _setImage() {
    try {
      final uri = Uri.tryParse(widget.imageUrl);
      if (uri != null && (uri.isScheme('http') || uri.isScheme('https'))) {
        _image = widget.imageUrl;
      } else {
        _image = "${AppApiUrl.domain}${widget.imageUrl}";
      }
    } catch (e) {
      _image = widget.imageUrl;
      errorLog("Error setting image:", e);
    }
  }

  void _retry() {
    if (_retryCount < _maxRetries) {
      setState(() {
        _retryCount++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = CustomHttpClient();
    return FadeInImage(
      placeholder: const AssetImage(AppImagesPath.placeHolder),
      // placeholder: AssetImage(AssetsIconsPath.profile), // Replace with your placeholder image
      image: NetworkImage(_image ?? ""),
      height: widget.height,
      width: widget.width,
      fit: widget.fit,
      imageErrorBuilder: (context, error, stackTrace) {
        errorLog("Error loading network image:", stackTrace);
        return GestureDetector(
          onTap: _retry,
          child: Container(
            width: widget.width,
            height: widget.height,
            color: AppColors.grey,
            child: const Center(
              child: Icon(Icons.refresh, color: Colors.white),
            ),
          ),
        );
      },
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 300),
    );
  }
}

class CustomHttpClient extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
