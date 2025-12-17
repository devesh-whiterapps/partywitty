import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShareEventModal extends StatelessWidget {
  final String eventUrl;

  const ShareEventModal({
    super.key,
    this.eventUrl = 'https://app.eraser.io/workspace/bK7c...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Color(0xffD0D0D0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Title
                Text(
                  'Share the Event',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff070707),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Social media buttons - Row 1
                Row(
                  children: [
                    Expanded(
                      child: _buildSocialButton(
                        context,
                        'Facebook',
                        Icons.facebook,
                        Color(0xff1877F2),
                        () => _shareToFacebook(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSocialButton(
                        context,
                        'WhatsApp',
                        Icons.chat,
                        Color(0xff25D366),
                        () => _shareToWhatsApp(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSocialButton(
                        context,
                        'Twitter',
                        Icons.close, // Using X icon placeholder
                        Color(0xff000000),
                        () => _shareToTwitter(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Social media buttons - Row 2
                Row(
                  children: [
                    Expanded(
                      child: _buildSocialButton(
                        context,
                        'Instagram',
                        Icons.camera_alt,
                        Color(0xffE4405F),
                        () => _shareToInstagram(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: SizedBox()), // Empty space
                    const SizedBox(width: 12),
                    Expanded(child: SizedBox()), // Empty space
                  ],
                ),
                const SizedBox(height: 20),

                // Link with copy button
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
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
                      ElevatedButton(
                        onPressed: () => _copyLink(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff7464E4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
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
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffE0E0E0), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
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
