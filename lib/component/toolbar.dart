// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/src/widgets/toolbar/camera_button.dart';
import 'package:flutter_quill/src/widgets/toolbar/search_button.dart';
import 'package:flutter_quill/src/widgets/toolbar/quill_font_family_button.dart';
import 'package:flutter_quill/src/translations/toolbar.i18n.dart';
import 'package:flutter_quill/src/utils/font.dart';

class ToolBar extends StatelessWidget {
  final QuillController controller;
  final double toolbarIconSize = kDefaultIconSize;
  final double toolbarSectionSpacing = 4;
  final WrapAlignment toolbarIconAlignment = WrapAlignment.center;
  final bool showDividers = true;
  final bool showFontFamily = true;
  final bool showFontSize = true;
  final bool showBoldButton = true;
  final bool showItalicButton = true;
  final bool showSmallButton = false;
  final bool showUnderLineButton = true;
  final bool showStrikeThrough = true;
  final bool showInlineCode = true;
  final bool showColorButton = true;
  final bool showBackgroundColorButton = true;
  final bool showClearFormat = true;
  final bool showAlignmentButtons = false;
  final bool showLeftAlignment = true;
  final bool showCenterAlignment = true;
  final bool showRightAlignment = true;
  final bool showJustifyAlignment = true;
  final bool showHeaderStyle = true;
  final bool showListNumbers = true;
  final bool showListBullets = true;
  final bool showListCheck = true;
  final bool showCodeBlock = true;
  final bool showQuote = true;
  final bool showIndent = true;
  final bool showLink = true;
  final bool showUndo = true;
  final bool showRedo = true;
  final bool multiRowsDisplay = false;
  final bool showImageButton = true;
  final bool showVideoButton = true;
  final bool showCameraButton = true;
  final bool showDirection = false;
  final bool showSearchButton = true;
  final OnImagePickCallback? onImagePickCallback;
  final OnVideoPickCallback? onVideoPickCallback;
  final MediaPickSettingSelector? mediaPickSettingSelector;
  final FilePickImpl? filePickImpl;
  final WebImagePickImpl? webImagePickImpl;
  final WebVideoPickImpl? webVideoPickImpl;
  final List<QuillCustomButton> customButtons = const [];

  ///Map of font sizes in string
  final Map<String, String>? fontSizeValues;

  ///Map of font families in string
  final Map<String, String>? fontFamilyValues;

  ///The theme to use for the icons in the toolbar; uses type [QuillIconTheme]
  final QuillIconTheme? iconTheme;

  ///The theme to use for the theming of the [LinkDialog()];
  ///shown when embedding an image; for example
  final QuillDialogTheme? dialogTheme;

  /// The locale to use for the editor toolbar; defaults to system locale
  /// More at https://github.com/singerdmx/flutter-quill#translation
  final Locale? locale;

  const ToolBar({
    required this.controller,
    this.onVideoPickCallback,
    this.mediaPickSettingSelector,
    this.filePickImpl,
    this.webImagePickImpl,
    this.webVideoPickImpl,

    ///Map of font sizes in string
    this.fontSizeValues,

    ///Map of font families in string
    this.fontFamilyValues,

    ///The theme to use for the icons in the toolbar, uses type [QuillIconTheme]
    this.iconTheme,

    ///The theme to use for the theming of the [LinkDialog()],
    ///shown when embedding an image, for example
    this.dialogTheme,

    /// The locale to use for the editor toolbar, defaults to system locale
    /// More at https://github.com/singerdmx/flutter-quill#translation
    this.locale,
    this.onImagePickCallback,
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isButtonGroupShown = [
      showFontFamily ||
          showFontSize ||
          showBoldButton ||
          showItalicButton ||
          showSmallButton ||
          showUnderLineButton ||
          showStrikeThrough ||
          showInlineCode ||
          showColorButton ||
          showBackgroundColorButton ||
          showClearFormat ||
          onImagePickCallback != null ||
          onVideoPickCallback != null,
      showAlignmentButtons || showDirection,
      showLeftAlignment,
      showCenterAlignment,
      showRightAlignment,
      showJustifyAlignment,
      showHeaderStyle,
      showListNumbers || showListBullets || showListCheck || showCodeBlock,
      showQuote || showIndent,
      showLink || showSearchButton
    ];
    //default font family values
    final fontFamilies = fontFamilyValues ??
        {
          'Sans Serif': 'sans-serif',
          'Serif': 'serif',
          'Monospace': 'monospace',
          'Ibarra Real Nova': 'ibarra-real-nova',
          'SquarePeg': 'square-peg',
          'Nunito': 'nunito',
          'Pacifico': 'pacifico',
          'Roboto Mono': 'roboto-mono',
          'Clear': 'Clear'
        };
    final fontSizes = fontSizeValues ??
        {
          'Small'.i18n: 'small',
          'Large'.i18n: 'large',
          'Huge'.i18n: 'huge',
          'Clear'.i18n: '0'
        };
    return QuillToolbar(
      key: key,
      color: Colors.transparent,
      toolbarHeight: toolbarIconSize * 2,
      toolbarSectionSpacing: toolbarSectionSpacing,
      toolbarIconAlignment: toolbarIconAlignment,
      multiRowsDisplay: multiRowsDisplay,
      customButtons: customButtons,
      locale: locale,
      children: [
        if (showUndo)
          HistoryButton(
            icon: Icons.undo_outlined,
            iconSize: toolbarIconSize,
            controller: controller,
            undo: true,
            iconTheme: iconTheme,
          ),
        if (showRedo)
          HistoryButton(
            icon: Icons.redo_outlined,
            iconSize: toolbarIconSize,
            controller: controller,
            undo: false,
            iconTheme: iconTheme,
          ),
        if (showFontFamily)
          QuillFontFamilyButton(
            iconTheme: iconTheme,
            iconSize: toolbarIconSize,
            attribute: Attribute.font,
            controller: controller,
            items: [
              for (MapEntry<String, String> fontFamily in fontFamilies.entries)
                PopupMenuItem<String>(
                  key: ValueKey(fontFamily.key),
                  value: fontFamily.value,
                  child: Text(fontFamily.key.toString(),
                      style: TextStyle(
                          color:
                              fontFamily.value == 'Clear' ? Colors.red : null)),
                ),
            ],
            onSelected: (newFont) {
              controller.formatSelection(Attribute.fromKeyValue(
                  'font', newFont == 'Clear' ? null : newFont));
            },
            rawItemsMap: fontFamilies,
          ),
        if (showFontSize)
          QuillFontSizeButton(
            iconTheme: iconTheme,
            iconSize: toolbarIconSize,
            attribute: Attribute.size,
            controller: controller,
            items: [
              for (MapEntry<String, String> fontSize in fontSizes.entries)
                PopupMenuItem<String>(
                  key: ValueKey(fontSize.key),
                  value: fontSize.value,
                  child: Text(fontSize.key.toString(),
                      style: TextStyle(
                          color: fontSize.value == '0' ? Colors.red : null)),
                ),
            ],
            onSelected: (newSize) {
              controller.formatSelection(Attribute.fromKeyValue(
                  'size', newSize == '0' ? null : getFontSize(newSize)));
            },
            rawItemsMap: fontSizes,
          ),
        if (showBoldButton)
          ToggleStyleButton(
            attribute: Attribute.bold,
            icon: Icons.format_bold,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showItalicButton)
          ToggleStyleButton(
            attribute: Attribute.italic,
            icon: Icons.format_italic,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showSmallButton)
          ToggleStyleButton(
            attribute: Attribute.small,
            icon: Icons.format_size,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showUnderLineButton)
          ToggleStyleButton(
            attribute: Attribute.underline,
            icon: Icons.format_underline,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showStrikeThrough)
          ToggleStyleButton(
            attribute: Attribute.strikeThrough,
            icon: Icons.format_strikethrough,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showInlineCode)
          ToggleStyleButton(
            attribute: Attribute.inlineCode,
            icon: Icons.code,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showColorButton)
          ColorButton(
            icon: Icons.color_lens,
            iconSize: toolbarIconSize,
            controller: controller,
            background: false,
            iconTheme: iconTheme,
          ),
        if (showBackgroundColorButton)
          ColorButton(
            icon: Icons.format_color_fill,
            iconSize: toolbarIconSize,
            controller: controller,
            background: true,
            iconTheme: iconTheme,
          ),
        if (showClearFormat)
          ClearFormatButton(
            icon: Icons.format_clear,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
          ),
        if (showImageButton)
          ImageButton(
            icon: Icons.image,
            iconSize: toolbarIconSize,
            controller: controller,
            onImagePickCallback: onImagePickCallback,
            filePickImpl: filePickImpl,
            webImagePickImpl: webImagePickImpl,
            mediaPickSettingSelector: mediaPickSettingSelector,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          ),
        if (showVideoButton)
          VideoButton(
            icon: Icons.movie_creation,
            iconSize: toolbarIconSize,
            controller: controller,
            onVideoPickCallback: onVideoPickCallback,
            filePickImpl: filePickImpl,
            webVideoPickImpl: webImagePickImpl,
            mediaPickSettingSelector: mediaPickSettingSelector,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          ),
        if ((onImagePickCallback != null || onVideoPickCallback != null) &&
            showCameraButton)
          CameraButton(
            icon: Icons.photo_camera,
            iconSize: toolbarIconSize,
            controller: controller,
            onImagePickCallback: onImagePickCallback,
            onVideoPickCallback: onVideoPickCallback,
            filePickImpl: filePickImpl,
            webImagePickImpl: webImagePickImpl,
            webVideoPickImpl: webVideoPickImpl,
            iconTheme: iconTheme,
          ),
        if (showDividers &&
            isButtonGroupShown[0] &&
            (isButtonGroupShown[1] ||
                isButtonGroupShown[2] ||
                isButtonGroupShown[3] ||
                isButtonGroupShown[4] ||
                isButtonGroupShown[5]))
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        if (showAlignmentButtons)
          SelectAlignmentButton(
            controller: controller,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
            showLeftAlignment: showLeftAlignment,
            showCenterAlignment: showCenterAlignment,
            showRightAlignment: showRightAlignment,
            showJustifyAlignment: showJustifyAlignment,
          ),
        if (showDirection)
          ToggleStyleButton(
            attribute: Attribute.rtl,
            controller: controller,
            icon: Icons.format_textdirection_r_to_l,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showDividers &&
            isButtonGroupShown[1] &&
            (isButtonGroupShown[2] ||
                isButtonGroupShown[3] ||
                isButtonGroupShown[4] ||
                isButtonGroupShown[5]))
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        if (showHeaderStyle)
          SelectHeaderStyleButton(
            controller: controller,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showDividers &&
            showHeaderStyle &&
            isButtonGroupShown[2] &&
            (isButtonGroupShown[3] ||
                isButtonGroupShown[4] ||
                isButtonGroupShown[5]))
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        if (showListNumbers)
          ToggleStyleButton(
            attribute: Attribute.ol,
            controller: controller,
            icon: Icons.format_list_numbered,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showListBullets)
          ToggleStyleButton(
            attribute: Attribute.ul,
            controller: controller,
            icon: Icons.format_list_bulleted,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showListCheck)
          ToggleCheckListButton(
            attribute: Attribute.unchecked,
            controller: controller,
            icon: Icons.check_box,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showCodeBlock)
          ToggleStyleButton(
            attribute: Attribute.codeBlock,
            controller: controller,
            icon: Icons.code,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showDividers &&
            isButtonGroupShown[3] &&
            (isButtonGroupShown[4] || isButtonGroupShown[5]))
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        if (showQuote)
          ToggleStyleButton(
            attribute: Attribute.blockQuote,
            controller: controller,
            icon: Icons.format_quote,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
          ),
        if (showIndent)
          IndentButton(
            icon: Icons.format_indent_increase,
            iconSize: toolbarIconSize,
            controller: controller,
            isIncrease: true,
            iconTheme: iconTheme,
          ),
        if (showIndent)
          IndentButton(
            icon: Icons.format_indent_decrease,
            iconSize: toolbarIconSize,
            controller: controller,
            isIncrease: false,
            iconTheme: iconTheme,
          ),
        if (showDividers && isButtonGroupShown[4] && isButtonGroupShown[5])
          VerticalDivider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.shade400,
          ),
        if (showLink)
          LinkStyleButton(
            controller: controller,
            iconSize: toolbarIconSize,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          ),
        if (showSearchButton)
          SearchButton(
            icon: Icons.search,
            iconSize: toolbarIconSize,
            controller: controller,
            iconTheme: iconTheme,
            dialogTheme: dialogTheme,
          ),
        if (customButtons.isNotEmpty)
          if (showDividers)
            VerticalDivider(
              indent: 12,
              endIndent: 12,
              color: Colors.grey.shade400,
            ),
        for (var customButton in customButtons)
          QuillIconButton(
              highlightElevation: 0,
              hoverElevation: 0,
              size: toolbarIconSize * kIconButtonFactor,
              icon: Icon(customButton.icon, size: toolbarIconSize),
              borderRadius: iconTheme?.borderRadius ?? 2,
              onPressed: customButton.onTap),
      ],
    );
  }
}
