import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BetterTextfield extends StatefulWidget {
  const BetterTextfield({
    Key? key,
    required this.controller,
    this.textStyle,
    this.focusNode,
    this.decoration,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
  }) : super(key: key);
  final TextEditingController controller;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final InputDecoration? decoration;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;

  @override
  State<BetterTextfield> createState() => _BetterTextfieldState();
}

class _BetterTextfieldState extends State<BetterTextfield>
    with RestorationMixin {
  RestorableTextEditingController? _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          RepaintBoundary(
            child: UnmanagedRestorationScope(
              bucket: bucket,
              child: EditableText(
                // readOnly: widget.readOnly || !_isEnabled,
                // toolbarOptions: widget.toolbarOptions,
                // showCursor: widget.showCursor,
                // showSelectionHandles: _showSelectionHandles,
                controller: widget.controller,
                focusNode: widget.focusNode ?? _focusNode,
                // keyboardType: widget.keyboardType,
                // textInputAction: widget.textInputAction,
                // textCapitalization: widget.textCapitalization,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .merge(widget.textStyle),
                // strutStyle: widget.strutStyle,
                // textAlign: widget.textAlign,
                // textDirection: widget.textDirection,
                // autofocus: widget.autofocus,
                // obscuringCharacter: widget.obscuringCharacter,
                // obscureText: widget.obscureText,
                // autocorrect: widget.autocorrect,
                // smartDashesType: widget.smartDashesType,
                // smartQuotesType: widget.smartQuotesType,
                // enableSuggestions: widget.enableSuggestions,
                // maxLines: widget.maxLines,
                // minLines: widget.minLines,
                // expands: widget.expands,
                // Only show the selection highlight when the text field is focused.
                // selectionColor: focusNode.hasFocus ? selectionColor : null,
                // selectionControls:
                // widget.selectionEnabled ? textSelectionControls : null,
                // onChanged: widget.onChanged,
                // onSelectionChanged: _handleSelectionChanged,
                // onEditingComplete: widget.onEditingComplete,
                // onSubmitted: widget.onSubmitted,
                // onAppPrivateCommand: widget.onAppPrivateCommand,
                // onSelectionHandleTapped: _handleSelectionHandleTapped,
                // inputFormatters: formatters,
                // rendererIgnoresPointer: true,
                // mouseCursor: MouseCursor.defer, // TextField will handle the cursor
                // cursorWidth: widget.cursorWidth,
                // cursorHeight: widget.cursorHeight,
                // cursorRadius: cursorRadius,
                cursorColor: Colors.black,
                // selectionHeightStyle: widget.selectionHeightStyle,
                // selectionWidthStyle: widget.selectionWidthStyle,
                // cursorOpacityAnimates: cursorOpacityAnimates,
                // cursorOffset: cursorOffset,
                // paintCursorAboveText: paintCursorAboveText,
                backgroundCursorColor: CupertinoColors.inactiveGray,
                // scrollPadding: widget.scrollPadding,
                // keyboardAppearance: keyboardAppearance,
                // enableInteractiveSelection: widget.enableInteractiveSelection,
                // dragStartBehavior: widget.dragStartBehavior,
                // scrollController: widget.scrollController,
                // scrollPhysics: widget.scrollPhysics,
                // autofillClient: this,
                // autocorrectionTextRectColor: autocorrectionTextRectColor,
                // clipBehavior: widget.clipBehavior,
                // restorationId: 'editable',
                // enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
              ),
            ),
          ),
          AnimatedPositioned(
            bottom: -(widget.decoration?.labelStyle?.fontSize ??
                Theme.of(context).inputDecorationTheme.labelStyle?.fontSize ??
                8),
            left: widget.controller.text.length * 6.45,
            duration: const Duration(milliseconds: 200),
            child: Container(
              width: 8,
              height: 8,
              color: Colors.red,
            ),
          )
        ],
      ),
    );

    if (widget.decoration != null) {
      child = AnimatedBuilder(
        animation: Listenable.merge(
            <Listenable>[widget.focusNode ?? _focusNode, widget.controller]),
        builder: (BuildContext context, Widget? child) {
          return InputDecorator(
            decoration: const InputDecoration.collapsed(hintText: "hint")
                .applyDefaults(Theme.of(context).inputDecorationTheme),
            baseStyle: widget.textStyle,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            isHovering: false,
            isFocused: (widget.focusNode ?? _focusNode).hasFocus,
            isEmpty: widget.controller.value.text.isEmpty,
            expands: false,
            child: child,
          );
        },
        child: child,
      );
    }

    return FocusTrapArea(
      focusNode: widget.focusNode ?? _focusNode,
      child: AnimatedBuilder(
        animation: widget.controller, // changes the _currentLength
        builder: (BuildContext context, Widget? child) {
          return Semantics(
            maxValueLength: null,
            currentValueLength: widget.controller.text.length,
            onTap: () {
              if (!widget.controller.selection.isValid) {
                widget.controller.selection = TextSelection.collapsed(
                    offset: widget.controller.text.length);
              }
            },
            onDidGainAccessibilityFocus: () {
              if (!(widget.focusNode ?? _focusNode).hasFocus &&
                  (widget.focusNode ?? _focusNode).canRequestFocus) {
                (widget.focusNode ?? _focusNode).requestFocus();
              }
            },
            child: child,
          );
        },
        child: child,
      ),
    );
  }

  @override
  String? get restorationId => 'bettertf_editable';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_controller != null) {
      _registerController();
    }
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }
}
