import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class ShareEventModal extends StatelessWidget {
  final String eventUrl;

  const ShareEventModal({
    super.key,
    this.eventUrl = 'https://app.eraser.io/workspace/bK7c...',
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(4),
        topRight: Radius.circular(4),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.75),
                borderRadius: BorderRadius.zero, // Sharp rectangle
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(top: 10, bottom: 15),
                      decoration: BoxDecoration(
                        color: Color(0xff4F4F4F),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Share the Event',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff070707),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        // Social media buttons - Row 1
                        Row(
                          children: [
                            Expanded(
                              child: _buildSocialButtonWithAsset(
                                context,
                                'Facebook',
                                'assets/icons/Facebook.png',
                                () => _shareToFacebook(context),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildSocialButtonWithAsset(
                                context,
                                'WhatsApp',
                                'assets/icons/whatsaap.png',
                                () => _shareToWhatsApp(context),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildSocialButtonWithAsset(
                                context,
                                'Twitter',
                                'assets/icons/twitter.png',
                                () => _shareToTwitter(context),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Social media buttons - Row 2
                        Row(
                          children: [
                            Expanded(
                              child: _buildSocialButtonWithAsset(
                                context,
                                'Instagram',
                                'assets/icons/insta.png',
                                () => _shareToInstagram(context),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: SizedBox()), // Empty space
                            const SizedBox(width: 8),
                            Expanded(child: SizedBox()), // Empty space
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Link with copy button - sharp rectangle with white 70%
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF).withOpacity(0.7),
                            borderRadius: BorderRadius.zero, // Sharp rectangle
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  eventUrl,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff4F4F4F),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () => _copyLink(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(
                                      0xff7464E4,
                                    ), // Purple background
                                    borderRadius:
                                        BorderRadius.zero, // Sharp rectangle
                                  ),
                                  child: Text(
                                    'Copy',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButtonWithAsset(
    BuildContext context,
    String label,
    String assetPath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF).withOpacity(0.7), // White 70%
          borderRadius: BorderRadius.zero, // Sharp rectangle
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath, width: 20, height: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff070707),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareToFacebook(BuildContext context) {
    // Implement Facebook sharing
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Sharing to Facebook...')));
    Navigator.pop(context);
  }

  void _shareToWhatsApp(BuildContext context) {
    // Implement WhatsApp sharing
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Sharing to WhatsApp...')));
    Navigator.pop(context);
  }

  void _shareToTwitter(BuildContext context) {
    // Implement Twitter sharing
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Sharing to Twitter...')));
    Navigator.pop(context);
  }

  void _shareToInstagram(BuildContext context) {
    // Implement Instagram sharing
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Sharing to Instagram...')));
    Navigator.pop(context);
  }

  void _copyLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: eventUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Link copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
