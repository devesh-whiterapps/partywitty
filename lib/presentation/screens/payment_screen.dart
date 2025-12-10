import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:partywitty/presentation/widgets/event_details_section.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../../domain/models/tulips_model.dart';
import '../../domain/models/discount_offer_model.dart';
import '../../data/services/tulips_service.dart';
import '../../data/services/discount_offer_service.dart';
import '../../data/services/payment_service.dart';
import '../widgets/gradient_background.dart';
import 'payment_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final EventModel event;
  final ArtistModel artist;
  final double balanceAmount;

  const PaymentScreen({
    super.key,
    required this.event,
    required this.artist,
    required this.balanceAmount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TulipsService _tulipsService = TulipsService();
  final DiscountOfferService _discountOfferService = DiscountOfferService();
  final PaymentService _paymentService = PaymentService();
  late Razorpay _razorpay;
  bool _isLoadingTulips = true;
  bool _isLoadingDiscountOffer = true;
  TulipsModel? _tulipsData;
  DiscountOfferModel? _discountOfferData;
  bool _useTulips = false;
  int _usableTulips = 0;
  double _platformCharges = 5.90;
  String _selectedPaymentMethod = 'razorpay';
  bool _isProcessingPayment = false;
  String? _activeOrderId;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _fetchTulips();
    _fetchDiscountOffer();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  Future<void> _fetchTulips() async {
    try {
      setState(() => _isLoadingTulips = true);
      final tulips = await _tulipsService.getAvailableTulips(
        userId: '14393',
        clubId: '621',
        netPayableAmount: widget.balanceAmount.toStringAsFixed(0),
        packageCategory: 'alakartDiscountwalkin',
      );
      setState(() {
        _tulipsData = tulips;
        _usableTulips = tulips.usableTulips;
        _isLoadingTulips = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingTulips = false;
        // Set default values on error
        _tulipsData = TulipsModel(
          availableTulips: 280,
          usableTulips: 200,
          tulipValue: 1.0,
        );
        _usableTulips = 200;
      });
    }
  }

  Future<void> _fetchDiscountOffer() async {
    try {
      setState(() => _isLoadingDiscountOffer = true);
      // TODO: Replace with actual values from app state/storage
      final response = await _discountOfferService.getDiscountOffer(
        amount: widget.balanceAmount.toStringAsFixed(0),
        clubId: '621',
        userId: '14393',
        type: 'directpayment',
      );
      if (response.status && response.data.isNotEmpty) {
        setState(() {
          _discountOfferData = response.data.first;
          _platformCharges = _discountOfferData!.platformFee;
          _isLoadingDiscountOffer = false;
        });
      } else {
        setState(() {
          _isLoadingDiscountOffer = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingDiscountOffer = false;
        // Keep default platform charges on error
      });
    }
  }

  double get _tulipsDiscount {
    if (!_useTulips || _tulipsData == null) return 0.0;
    return _usableTulips * _tulipsData!.tulipValue;
  }

  double get _finalPayableAmount {
    if (_discountOfferData != null) {
      // Use net payable amount from API, then subtract tulips discount if used
      return _discountOfferData!.netPayableAmount - _tulipsDiscount;
    }
    // Fallback to original calculation if API data not available
    return widget.balanceAmount - _tulipsDiscount + _platformCharges;
  }

  double get _totalAmount {
    return _discountOfferData?.totalAmount ?? widget.balanceAmount;
  }

  double get _discountedAmount {
    return _discountOfferData?.discountedAmount ?? 0.0;
  }

  double get _cashbackAmount {
    return _discountOfferData?.cashbackAmount ?? 0.0;
  }

  double get _payableAmountBeforeTulips {
    return _discountOfferData?.payableAmount ?? widget.balanceAmount;
  }

  String get _razorpayKey => dotenv.env['RAZORPAY_KEY'] ?? '';

  Future<void> _handlePayNow() async {
    if (_isProcessingPayment) return;

    if (_isLoadingDiscountOffer) {
      _showMessage('Fetching order details, please wait...');
      return;
    }

    if (_discountOfferData == null || _discountOfferData!.orderId.isEmpty) {
      _showMessage('Order details not available. Please retry.');
      return;
    }

    if (_selectedPaymentMethod != 'razorpay') {
      _showMessage('Only Razorpay is supported right now.');
      return;
    }

    final orderId = _discountOfferData!.orderId;

    setState(() {
      _isProcessingPayment = true;
      _activeOrderId = orderId;
    });

    try {
      final paymentData = await _paymentService.submitCarnivalPass(
        orderId: orderId,
        couponCode: '',
        paymentGateway: 'razorpay',
        carrotUse: _useTulips,
      );

      _openRazorpay(paymentData);
    } catch (e) {
      _showMessage(e.toString());
      setState(() {
        _isProcessingPayment = false;
      });
    }
  }

  void _openRazorpay(Map<String, dynamic> paymentData) {
    try {
      final amountValue =
          double.tryParse(paymentData['amount']?.toString() ?? '') ??
          _finalPayableAmount;
      final razorpayOrderId = paymentData['rzp_order_id']?.toString() ?? '';
      final displayOrderId =
          paymentData['order_id']?.toString() ?? _activeOrderId ?? '';
      final contact =
          paymentData['userMobile']?.toString() ??
          paymentData['mobile']?.toString() ??
          '';
      final name = paymentData['userName']?.toString() ?? '';
      final email = paymentData['userEmail']?.toString() ?? '';

      if (razorpayOrderId.isEmpty) {
        throw Exception('Razorpay order id not received from server.');
      }

      final options = {
        'key': _razorpayKey,
        'amount': (amountValue * 100).toInt(),
        'currency': 'INR',
        'name': 'PartyWitty',
        'description': 'PartyWitty Booking - Order $displayOrderId',
        'order_id': razorpayOrderId,
        'prefill': {
          if (name.isNotEmpty) 'name': name,
          if (email.isNotEmpty) 'email': email,
          if (contact.isNotEmpty) 'contact': contact,
        },
        'theme': {'color': '#FF6B6B'},
      };

      _razorpay.open(options);
    } catch (e) {
      _showMessage('Failed to open Razorpay. Please try again.');
      setState(() {
        _isProcessingPayment = false;
      });
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      final verified = await _paymentService.verifyRazorpayPayment({
        'razorpay_payment_id': response.paymentId,
        'razorpay_order_id': response.orderId,
        'razorpay_signature': response.signature,
      });

      if (verified) {
        _navigateToSuccess(response.paymentId ?? '');
      } else {
        _showMessage('Payment verification failed. Please contact support.');
      }
    } catch (e) {
      _showMessage('Something went wrong during payment verification.');
    } finally {
      setState(() {
        _isProcessingPayment = false;
      });
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _showMessage('Payment failed: ${response.message ?? 'Please try again.'}');
    setState(() {
      _isProcessingPayment = false;
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    _showMessage('External wallet selected: ${response.walletName}');
  }

  void _navigateToSuccess(String transactionId) {
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentSuccessScreen(
          event: widget.event,
          artist: widget.artist,
          paidAmount: _finalPayableAmount,
          orderId: _activeOrderId ?? transactionId,
          carrotsEarned: 200,
        ),
      ),
    );
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: false,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // AppBar
              //   _buildAppBar(),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Image.asset(
                    'assets/icons/arrow_back.png',
                    width: 16,
                    height: 13,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                titleSpacing: -10,
                title: Text(
                  'Back',
                  style: GoogleFonts.lexend(
                    color: Color(0xff070707),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: false,

                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      // child: Image.asset(
                      //   'assets/logo/Vector.png',
                      //   width: 40,
                      //   height: 40,
                      // ),
                      child: SvgPicture.asset(
                        'assets/logo/logo.svg',
                        width: 34,
                        height: 34,
                      ),
                    ),
                  ),
                ],
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Color(0xffECECE9), width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Event Details Section
                              _buildEventDetailsSection(),
                              const SizedBox(height: 0),
                              // Balance Amount
                              _buildBalanceAmount(),
                              const SizedBox(height: 14),
                              // Promotional Cards Carousel
                              _buildPromotionalCarousel(),
                              const SizedBox(height: 16),

                              // Tulips Balance Section
                              _buildTulipsSection(),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(horizontal: 15),
                              //   child: SvgPicture.asset(
                              //     'assets/images/partywitty-pay.svg',
                              //     width: double.infinity,
                              //     height: 100,
                              //   ),
                              // ),
                              const SizedBox(height: 5),
                              // Payment Summary
                              _buildPaymentSummary(),
                              //const SizedBox(height: 100), // Space for bottom bar
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Bottom Action Bar
              _buildBottomActionBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventDetailsSection() {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Name and Rating
            // Row(
            //   children: [
            //     Container(
            //       width: 24,
            //       height: 24,
            //       decoration: BoxDecoration(
            //         color: Colors.blue,
            //         borderRadius: BorderRadius.circular(4),
            //       ),
            //       child: Center(
            //         child: Text(
            //           'F',
            //           style: TextStyle(
            //             color: Colors.white,
            //              fontSize: 14,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     Text(
            //       widget.event.venue,
            //       style: GoogleFonts.lexend(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w500,
            //         color: Color(0xff070707),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     Icon(Icons.star, color: Colors.amber[700], size: 18),
            //     const SizedBox(width: 4),
            //     Text(
            //       '${widget.event.rating}',
            //       style: GoogleFonts.lexend(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w500,
            //         color: Color(0xff070707),
            //       ),
            //     ),
            //     const SizedBox(width: 4),
            //     Text(
            //       'Review ',
            //       style: GoogleFonts.lexend(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w500,
            //         decoration: TextDecoration.underline,
            //         color: Color(0xff070707),
            //       ),
            //     ),
            //     Text(
            //       '(${widget.event.reviewCount.toString().padLeft(2, '0')})',
            //       style: GoogleFonts.lexend(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w500,
            //         color: Color(0xff070707),
            //       ),
            //     ),
            //   ],
            // ),
            EventDetailsSection(
              eventDetails: widget.event,
              artist: widget.artist,
            ).buildVenueAndRating(),
            const SizedBox(height: 12),
            //  const SizedBox(height: 12),

            // Location
            // Row(
            //   children: [
            //     Icon(
            //       Icons.location_on_outlined,
            //       color: Colors.grey[700],
            //       size: 20,
            //     ),
            //     const SizedBox(width: 6),
            //     Text(
            //       widget.event.location,
            //       style: GoogleFonts.lexend(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w400,
            //         color: Color(0xff4F4F4F),
            //       ),
            //     ),
            //     const SizedBox(width: 15),
            //     Container(
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 8,
            //         vertical: 4,
            //       ),
            //       decoration: BoxDecoration(
            //         color: Color(0xff7464E4).withValues(alpha: 0.1),
            //         borderRadius: BorderRadius.circular(4),
            //       ),
            //       child: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Image.asset(
            //             'assets/icons/distance.png',
            //             width: 12,
            //             height: 12,
            //           ),
            //           const SizedBox(width: 4),
            //           Text(
            //             '${widget.event.distance.toStringAsFixed(1)} Kms',
            //             style: TextStyle(
            //               fontSize: 12,
            //               color: Color(0xff7464E4),
            //               fontWeight: FontWeight.w500,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            EventDetailsSection(
              eventDetails: widget.event,
              artist: widget.artist,
            ).buildLocation(),
            const SizedBox(height: 16),
            // Date, Time, and Pax
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // _buildInfoColumn(
                //   Icons.calendar_today_outlined,
                //   'Date',
                //   widget.event.date,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Icon(, size: 16, color: Colors.grey[700]),
                        SvgPicture.asset(
                          'assets/icons/calender.svg',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Date',
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4F4F4F),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.event.date,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff070707),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 28),
                _buildInfoColumn(Icons.access_time, 'Time', widget.event.time),
                const SizedBox(width: 28),

                // _buildInfoColumn(Icons.person_add_outlined, 'Pax', '50'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Icon(, size: 16, color: Colors.grey[700]),
                        SvgPicture.asset(
                          'assets/icons/user.svg',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Date',
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4F4F4F),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '50',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff070707),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[700]),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff4F4F4F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff070707),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceAmount() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      // decoration: BoxDecoration(
      //   color: Color(0xffECECE9).withValues(alpha: 0.71)0
      //   borderRadius: BorderRadius.circular(4),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Balance Amount',
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff4F4F4F),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 49,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xff7464E4).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Color(0xffF3F3F3), width: 1),
            ),
            child: Container(
              height: 23,
              child: Row(
                children: [
                  Text(
                    '₹ ',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff7464E4),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(width: 2, height: 18, color: Color(0xff7464E4)),
                  const SizedBox(width: 10),
                  Text(
                    '${widget.balanceAmount.toStringAsFixed(0)}',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff7464E4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionalCarousel() {
    final cards = [
      PromoCardData(
        title: 'Use Tulips To Make Payment',
        subtitle: 'Earn 25 Tulips',
        buttonText: 'Watch & Earn',
        imagePath: 'assets/icons/celebration.svg',
        backgroundColor: const Color(0xffFFF9C4),
      ),
      PromoCardData(
        title: 'Upto 50% Off',
        subtitle: 'On Food & Beverages Bill',
        buttonText: 'Pre-Booking',
        imagePath: 'assets/images/group_celeb.svg',
        backgroundColor: const Color(0xffFFF9C4),
      ),
      PromoCardData(
        title: 'Use Tulips To Make Payment',
        subtitle: 'Earn 25 Tulips',
        buttonText: 'Watch & Earn',
        imagePath: 'assets/images/card3.svg',
        backgroundColor: const Color(0xffFFF9C4),
      ),
      PromoCardData(
        title: 'Earn Up To 200',
        subtitle: 'Pay Using Partywitty Pay',
        buttonText: 'Earn Now',
        imagePath: 'assets/images/25pay.svg',
        backgroundColor: const Color(0xffFFF9C4),
      ),
    ];

    return PromoCarousel(
      cards: cards,
      borderColor: Colors.black,
      //cardsPerView: 2,
    );
  }

  Widget _buildTulipsSection() {
    if (_isLoadingTulips) {
      return Center(child: CircularProgressIndicator());
    }

    final availableTulips = _tulipsData?.availableTulips ?? 280;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 1),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFAFAFAFA).withOpacity(0.1),
                  Color(0xffF05753).withValues(alpha: 0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Color(0xffEFEFEF), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Available Tulips :',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4F4F4F),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/icons/tulip.svg',
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$availableTulips',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff070707),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 1,
                  alignment: Alignment.center,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomPaint(
                        size: Size(constraints.maxWidth, 1),
                        painter: _DottedDividerPainter(
                          color: Color(0xff989898).withValues(alpha: 0.37),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Checkbox(
                        value: _useTulips,
                        onChanged: (value) {
                          setState(() {
                            _useTulips = value ?? false;
                          });
                        },
                        activeColor: Color(0xff7464E4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pay Using Tulips Balance',
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff070707),
                            ),
                          ),
                          // if (_useTulips) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Usable Tulips',
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff4F4F4F),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SvgPicture.asset(
                                'assets/icons/tulip.svg',
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$_usableTulips',
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff070707),
                                ),
                              ),
                            ],
                          ),
                          // ],
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
    if (_isLoadingDiscountOffer) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        //  color: Colors.white.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total Amount (from API)
          if (_discountOfferData != null) ...[
            _buildSummaryRow(
              'Total Amount',
              '₹${_totalAmount.toStringAsFixed(0)}',
              Color(0xff070707),
              Color(0xff070707),
              false,
            ),
            // Discounted Amount (if any)
            if (_discountedAmount > 0) ...[
              const SizedBox(height: 8),
              _buildSummaryRow(
                'Discount',
                '-₹${_discountedAmount.toStringAsFixed(0)}',
                Color(0xff3CBD53),
                Color(0xff3CBD53),
                false,
                isDiscount: true,
              ),
            ],
            // Cashback Amount (if any) - shown as positive but will be added
            if (_cashbackAmount > 0) ...[
              const SizedBox(height: 8),
              _buildSummaryRow(
                'Cashback',
                '₹${_cashbackAmount.toStringAsFixed(0)}',
                Color(0xff3CBD53),
                Color(0xff3CBD53),
                false,
              ),
            ],
            const SizedBox(height: 8),
            _buildSummaryRow(
              'Payable Amount',
              '₹${_payableAmountBeforeTulips.toStringAsFixed(0)}',
              Color(0xff070707),
              Color(0xff070707),
              false,
            ),
          ] else ...[
            // Fallback to original display if API data not available
            _buildSummaryRow(
              'Payable Amount',
              '₹${widget.balanceAmount.toStringAsFixed(0)}',
              Color(0xff070707),
              Color(0xff070707),
              false,
            ),
          ],
          // Tulips discount (if used)
          if (_useTulips) ...[
            const SizedBox(height: 8),
            _buildSummaryRow(
              'Reward Discount(Tulip)',
              '-₹${_tulipsDiscount.toStringAsFixed(0)}',
              Color(0xff3CBD53),
              Color(0xff3CBD53),
              false,
              isDiscount: true,
            ),
          ],
          // Platform & Other Charges
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Platform & Other Charges',
            '₹${_platformCharges.toStringAsFixed(2)}',
            Color(0xff7464E4),
            Color(0xff7464E4),
            false,
            isUnderlined: true,
          ),
          // Final Payable Amount
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Payable Amount',
            '₹${_finalPayableAmount.toStringAsFixed(2)}',
            Color(0xff070707),
            Color(0xff070707),
            false,
            isUnderlined: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value,
    Color primaryColor,
    Color secondaryColor,
    bool isBold, {
    bool isDiscount = false,
    bool isUnderlined = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: primaryColor,
            decoration: isUnderlined ? TextDecoration.underline : null,
            decorationColor: Color(0xff7464E4),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.lexend(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: secondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      decoration: BoxDecoration(
        color: Color(0xffffffff).withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Color(0xff7464E4),
              borderRadius: BorderRadius.circular(2),
            ),
            child: GestureDetector(
              onTap: () => _showPaymentMethodDialog(context),
              child: Icon(Icons.more_horiz, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: _isProcessingPayment ? null : _handlePayNow,
              // onTap: () {
              //   // Use order ID from API if available, otherwise generate one
              //   String orderId;
              //   if (_discountOfferData != null &&
              //       _discountOfferData!.orderId.isNotEmpty) {
              //     orderId = _discountOfferData!.orderId;
              //   } else {
              //     final random = Random();
              //     orderId =
              //         '#${random.nextInt(10000)}${String.fromCharCodes(List.generate(5, (index) => random.nextInt(26) + 65))}\$';
              //   }

              //   Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (context) => PaymentSuccessScreen(
              //         event: widget.event,
              //         artist: widget.artist,
              //         paidAmount: _finalPayableAmount,
              //         orderId: orderId,
              //         carrotsEarned: 200,
              //       ),
              //     ),
              //   );
              // },
              child: Container(
                height: 44,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: _isProcessingPayment
                      ? Color(0xff7464E4).withValues(alpha: 0.6)
                      : Color(0xff7464E4),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: _isProcessingPayment
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xffffffff),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Processing...',
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        '₹${_finalPayableAmount.toStringAsFixed(2)}  Pay Now',
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffffffff),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethodDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _PaymentMethodBottomSheet(
        selectedMethod: _selectedPaymentMethod,
        onMethodSelected: (method) {
          setState(() {
            _selectedPaymentMethod = method;
          });
          Navigator.pop(context);
        },
      ),
    );
  }
}

// Payment Method Bottom Sheet
class _PaymentMethodBottomSheet extends StatefulWidget {
  final String selectedMethod;
  final Function(String) onMethodSelected;

  const _PaymentMethodBottomSheet({
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  State<_PaymentMethodBottomSheet> createState() =>
      _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<_PaymentMethodBottomSheet> {
  late String _selectedMethod;

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.selectedMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top indicator
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 50,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
            child: Text(
              'Choose Payment Methods',
              style: GoogleFonts.lexend(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xff070707),
              ),
            ),
          ),
          // Payment method cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildPaymentMethodCard(
                    method: 'razorpay',
                    logo: Image.asset(
                      'assets/icons/pay1.png',
                      fit: BoxFit.fitWidth,
                    ),
                    name: 'Razorpay',
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: _buildPaymentMethodCard(
                    method: 'easebuzz',
                    logo: Image.asset(
                      'assets/icons/easebuzz.png',
                      fit: BoxFit.fitWidth,
                    ),
                    name: 'Easebuzz',
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: _buildPaymentMethodCard(
                    method: 'payu',
                    logo: Image.asset(
                      'assets/icons/payu.png',
                      fit: BoxFit.fitWidth,
                    ),
                    name: 'PayU India',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 44),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard({
    required String method,
    required Widget logo,
    required String name,
  }) {
    final isSelected = _selectedMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
        });
        widget.onMethodSelected(method);
      },
      child: Container(
        height: 59,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.27),
          border: Border.all(
            color: isSelected ? Color(0xff7464E4) : Colors.transparent,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Radio button
            Radio<String>(
              value: method,
              groupValue: _selectedMethod,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedMethod = value;
                  });
                  widget.onMethodSelected(value);
                }
              },
              activeColor: Color(0xff7464E4),
              fillColor: MaterialStateProperty.resolveWith<Color>((
                Set<MaterialState> states,
              ) {
                if (states.contains(MaterialState.selected)) {
                  return Color(0xff7464E4);
                }
                // Show purple border even when not selected
                return Color(0xff7464E4).withOpacity(0.8);
              }),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            const SizedBox(width: 4),
            // Logo with constraints
            Expanded(child: SizedBox(height: 40, child: logo)),
          ],
        ),
      ),
    );
  }
}

// Model for card data
class PromoCardData {
  final String title;
  final String subtitle;
  final String buttonText;
  final String imagePath;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  PromoCardData({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imagePath,
    this.backgroundColor = const Color(0xffFFF9C4),
    this.onPressed,
  });
}

// Reusable Single Card Widget
class PromoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String imagePath;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const PromoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imagePath,
    this.backgroundColor = const Color(0xffFFF9C4),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 120,
      child: CustomPaint(
        painter: _PromoCardDottedBorderPainter(),
        child: Opacity(
          opacity: 1,
          child: Container(
            padding: const EdgeInsets.only(
              left: 8,
              right: 0,
              top: 8,
              bottom: 0,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffF0CF66).withValues(alpha: 0.0),
                  Color(0xffCCED29).withValues(alpha: 0.3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 3.0,
                right: 0.0,
                top: 9.0,
                bottom: 0.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff070707),
                      //height: 1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff070707),
                    ),
                  ),
                  //const SizedBox(height: 7),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Transform.translate(
                          offset: const Offset(0, -6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff000000).withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(
                                color: Color(
                                  0xff000000,
                                ).withValues(alpha: 0.06),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              buttonText,
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff070707),
                              ),
                              //  maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 0),

                      // Image.asset(
                      //   imagePath,
                      //   width: 48,
                      //   height: 48,
                      //   fit: BoxFit.contain,
                      //   errorBuilder: (context, error, stackTrace) {
                      //     return Icon(
                      //       Icons.celebration_outlined,
                      //       size: 48,
                      //       color: Color(0xff7464E4).withValues(alpha: 0.5),
                      //     );
                      //   },
                      // ),
                      SvgPicture.asset(
                        imagePath,
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Carousel Widget with Multiple Cards
class PromoCarousel extends StatefulWidget {
  final List<PromoCardData> cards;
  final Color borderColor;
  final int cardsPerView;

  const PromoCarousel({
    super.key,
    required this.cards,
    this.borderColor = Colors.black,
    this.cardsPerView = 2,
  });

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardSpacing = 8.0; // Space between cards
    final cardHeight = 109.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: cardHeight,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.cards.length,
          itemBuilder: (context, index) {
            final card = widget.cards[index];
            return Container(
              width: 200,
              margin: EdgeInsets.only(
                right: index < widget.cards.length - 1 ? cardSpacing : 0,
              ),
              child: PromoCard(
                title: card.title,
                subtitle: card.subtitle,
                buttonText: card.buttonText,
                imagePath: card.imagePath,
                backgroundColor: card.backgroundColor,
                onPressed: card.onPressed,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Custom painter for dotted border on promo cards
class _PromoCardDottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xff020202).withValues(alpha: 0.92)
      ..strokeWidth = 0.3
      ..style = PaintingStyle.stroke;

    const dashWidth = 3.0;
    const dashSpace = 2.0;
    const radius = 2.0;

    // Draw dotted border around the container
    _drawDottedRect(
      canvas,
      paint,
      Offset(0, 0),
      size,
      radius,
      dashWidth,
      dashSpace,
    );
  }

  void _drawDottedRect(
    Canvas canvas,
    Paint paint,
    Offset offset,
    Size size,
    double radius,
    double dashWidth,
    double dashSpace,
  ) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    final dashPath = _dashPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _dashPath(Path path, double dashWidth, double dashSpace) {
    final dashPath = Path();
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        dashPath.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    return dashPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for dotted divider
class _DottedDividerPainter extends CustomPainter {
  final Color color;

  _DottedDividerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const dashWidth = 4.0;
    const dashSpace = 3.0;
    double startX = 0;
    // Center the line vertically
    final centerY = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, centerY),
        Offset(startX + dashWidth, centerY),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
