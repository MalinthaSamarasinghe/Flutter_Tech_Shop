import 'dart:io';
import 'package:mime/mime.dart';
import '../../../constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/circle_button.dart';
import '../../../components/alert_widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../../../components/shimmer_builder.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../components/custom_snack_bar.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePic extends StatefulWidget {
  final String? userImage;

  const ProfilePic({super.key, required this.userImage});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final ImagePicker picker = ImagePicker();
  dynamic _pickImageError;
  CroppedFile? _croppedFile;
  bool alreadyHasImage = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () {
              if(_croppedFile == null && !alreadyHasImage){
                FocusManager.instance.primaryFocus?.unfocus();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                _showImageSelectorBottomSheet(context);
              }
            },
            child: Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.only(top: 22),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kColorFieldBorder,
              ),
              child: Center(child: _previewImages()),
            ),
          ),
          _croppedFile != null || alreadyHasImage
              ? Positioned(
                  bottom: 0,
                  right: 9,
                  child: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      _showImageSelectorBottomSheet(context);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kColorLightBlue,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/svg/camera.svg",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  void _showImageSelectorBottomSheet(context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: kTextColor.withOpacity(0.5),
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 600),
        reverseCurve: Curves.easeOut,
        reverseDuration: const Duration(milliseconds: 400),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          height: Platform.isAndroid ? 229 : 205,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: kColorWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              /// Filter Handle
              Container(
                height: 3,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kTextColor,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                // Translate the message
                _croppedFile != null || alreadyHasImage ? "Change Customer Image" : "Add Customer Image",
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              picker.supportsImageSource(ImageSource.camera) || picker.supportsImageSource(ImageSource.gallery)
                  ? const SizedBox(height: 33)
                  : !(_croppedFile != null || alreadyHasImage)
                      ? const SizedBox(
                          width: 330,
                          child: Text(
                            "No Camera or Gallery Found!",
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        )
                      : const SizedBox(height: 33),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  picker.supportsImageSource(ImageSource.camera)
                      ? CircleButton(
                          icon: "assets/svg/camera.svg",
                          iconColor: kColorDarkBlue,
                          // Translate the message
                          title: "Camera",
                          onTap: (){
                            Navigator.pop(context);
                            _imgFromCamera(context: context);
                          },
                        )
                      : const SizedBox(),
                  SizedBox(width: picker.supportsImageSource(ImageSource.camera) && picker.supportsImageSource(ImageSource.gallery) ? 53 : 0),
                  picker.supportsImageSource(ImageSource.gallery)
                      ? CircleButton(
                          icon: "assets/svg/gallery.svg",
                          iconColor: kColorDarkBlue,
                          // Translate the message
                          title: "Gallery",
                          onTap: (){
                            Navigator.pop(context);
                            _imgFromGallery(context: context);
                          },
                        )
                      : const SizedBox(),
                  SizedBox(width: picker.supportsImageSource(ImageSource.camera) || picker.supportsImageSource(ImageSource.gallery)
                      ? (_croppedFile != null || alreadyHasImage ? 53 : 0)
                      : 0),
                  _croppedFile != null || alreadyHasImage
                      ? CircleButton(
                          icon: "assets/svg/bin.svg",
                          iconColor: kColorDarkBlue,
                          // Translate the message
                          title: "Remove",
                          onTap: (){
                            Alerts.getInstance().twoButtonAlert(
                              context,
                              // Translate the message
                              title: "Confirm Deletion",
                              msg: "Are you sure you want to delete this image?",
                              btnNoText: "Cancel",
                              btnYesText: "Delete",
                              functionNo:() {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              functionYes:() {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                _clear();
                              },
                            );
                          },
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(height: 35),
            ],
          ),
        );
      },
    );
  }

  _imgFromGallery({required BuildContext context}) async {
    if (context.mounted) {
      try {
        final XFile? pickedImageFromGallery = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
        setState(() {
          _cropSingleImage(pickedImageFromGallery);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  _imgFromCamera({required BuildContext context}) async {
    if (context.mounted) {
      try {
        final XFile? pickedImageFromCamera = await picker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front, imageQuality: 100);
        setState(() {
          _cropSingleImage(pickedImageFromCamera);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  void _clear() {
    setState(() {
      _pickImageError = null;
      _croppedFile = null;
      alreadyHasImage = false;
    });
  }

  Widget _previewImages() {
    if(alreadyHasImage){
      return InstaImageViewer(
        disableSwipeToDismiss: false,
        disposeLevel: DisposeLevel.low,
        backgroundColor: kColorFieldBorder,
        child: CachedNetworkImage(
          imageUrl: widget.userImage ?? "",
          placeholder: (context, url) => shimmerLoader(),
          errorWidget: (context, url, error) {
            return SvgPicture.asset(
              "assets/svg/default_customer.svg",
              fit: BoxFit.cover,
            );
          },
          useOldImageOnUrlChange: true,
          fit: BoxFit.contain,
        ),
      );
    }
    if (_croppedFile != null) {
      final String? mime = lookupMimeType(_croppedFile!.path);
      return InstaImageViewer(
        disableSwipeToDismiss: false,
        disposeLevel: DisposeLevel.low,
        backgroundColor: kColorFieldBorder,
        child: Semantics(
          label: "image_picker_example_picked_image",
          child: kIsWeb
              ? Image.network(_croppedFile!.path)
              : (mime == null || mime.startsWith('image/')
                  ? Image.file(
                      File(_croppedFile!.path),
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        // Translate the message
                        return _buildErrorImage(context, "This image type is not supported!");
                      },
                    )
                  // Translate the message
                  : _buildErrorImage(context, "This type is not an image!")),
        ),
      );
    } else if (_pickImageError != null) {
      return _buildErrorImage(context, _pickImageError);
    } else {
      return _buildErrorImage(context, "");
    }
  }

  Widget _buildErrorImage(BuildContext context, String error) {
    if(error != ""){
      Future.delayed(const Duration(milliseconds: 100), () {
        CustomSnackBar().showSnackBar(
          context,
          msg: error,
          snackBarTypes: SnackBarTypes.error,
        );
      });
    }
    return Center(
      child: SvgPicture.asset(
        "assets/svg/camera.svg",
        width: 60,
        height: 60,
      ),
    );
  }

  _cropSingleImage(XFile? filePath) async {
    try {
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath!.path,
        maxWidth: 1080,
        maxHeight: 1080,
        // aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            // Translate the message
            toolbarTitle: "Storemate",
            toolbarColor: kTextColor,
            statusBarColor: kTextColor,
            toolbarWidgetColor: kColorWhite,
            backgroundColor: kTextColor,
            activeControlsWidgetColor: kColorRed,
            showCropGrid: true,
            cropGridStrokeWidth: 3,
            cropFrameStrokeWidth: 4,
            hideBottomControls: false,
            initAspectRatio: CropAspectRatioPreset.original,
            dimmedLayerColor: kTextColor,
            cropFrameColor: kColorWhite,
            cropGridColor: kColorWhite,
            lockAspectRatio: false,
            cropGridColumnCount: 2,
            cropGridRowCount: 2,
            cropStyle: CropStyle.rectangle,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPresetCustom(),
            ],
          ),
          IOSUiSettings(
            // Translate the message
            title: "Storemate",
            aspectRatioLockDimensionSwapEnabled: false,
            aspectRatioLockEnabled: false,
            aspectRatioPickerButtonHidden: true,
            // Translate the message
            cancelButtonTitle: "Cancel",
            doneButtonTitle: "Done",
            // hidesNavigationBar: false,
            // minimumAspectRatio: 1.0,
            // rectHeight: 1080,
            // rectWidth: 1080,
            // rectX: 0,
            // rectY: 0,
            resetAspectRatioEnabled: true,
            resetButtonHidden: true,
            rotateButtonsHidden: true,
            rotateClockwiseButtonHidden: true,
            showActivitySheetOnDone: true,
            showCancelConfirmationDialog: true,
            cropStyle: CropStyle.rectangle,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPresetCustom(),
            ],
          ),
        ],
      );
      if (croppedImage != null) {
        setState(() {
          _croppedFile = croppedImage;
          alreadyHasImage = false;
        });
      } else {
        throw Exception("ImageCropper Error");
      }
    } catch (e) {
      debugPrint("ImageCropper Error --> $e");
    }
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (16, 9);

  @override
  String get name => "16x9";
}
