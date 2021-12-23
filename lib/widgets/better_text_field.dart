import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
    with RestorationMixin
    implements TextSelectionGestureDetectorBuilderDelegate {
  RestorableTextEditingController? _controller;
  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();
  EditableTextState? get _editableText => editableTextKey.currentState;
  late _TextFieldSelectionGestureDetectorBuilder
      _selectionGestureDetectorBuilder;

  final FocusNode _focusNode = FocusNode();
  void _requestKeyboard() {
    _editableText?.requestKeyboard();
  }

  // InputDecoration _getEffectiveDecoration() {
  //   final MaterialLocalizations localizations =
  //       MaterialLocalizations.of(context);
  //   final ThemeData themeData = Theme.of(context);
  //   final InputDecoration effectiveDecoration =
  //       (widget.decoration ?? const InputDecoration())
  //           .applyDefaults(themeData.inputDecorationTheme)
  //           .copyWith(
  //             enabled: true,
  //             hintMaxLines: widget.decoration?.hintMaxLines ?? widget.maxLines,
  //           );

  //   // No need to build anything if counter or counterText were given directly.
  //   if (effectiveDecoration.counter != null ||
  //       effectiveDecoration.counterText != null) {
  //     return effectiveDecoration;
  //   }

  //   // If buildCounter was provided, use it to generate a counter widget.
  //   Widget? counter;
  //   final int currentLength = _currentLength;
  //   if (effectiveDecoration.counter == null &&
  //       effectiveDecoration.counterText == null &&
  //       widget.buildCounter != null) {
  //     final bool isFocused = _effectiveFocusNode.hasFocus;
  //     final Widget? builtCounter = widget.buildCounter!(
  //       context,
  //       currentLength: currentLength,
  //       maxLength: widget.maxLength,
  //       isFocused: isFocused,
  //     );
  //     // If buildCounter returns null, don't add a counter widget to the field.
  //     if (builtCounter != null) {
  //       counter = Semantics(
  //         container: true,
  //         liveRegion: isFocused,
  //         child: builtCounter,
  //       );
  //     }
  //     return effectiveDecoration.copyWith(counter: counter);
  //   }

  //   if (widget.maxLength == null) {
  //     return effectiveDecoration;
  //   } // No counter widget

  //   String counterText = '$currentLength';
  //   String semanticCounterText = '';

  //   // Handle a real maxLength (positive number)
  //   if (widget.maxLength! > 0) {
  //     // Show the maxLength in the counter
  //     counterText += '/${widget.maxLength}';
  //     final int remaining =
  //         (widget.maxLength! - currentLength).clamp(0, widget.maxLength!);
  //     semanticCounterText =
  //         localizations.remainingTextFieldCharacterCount(remaining);
  //   }

  //   if (_hasIntrinsicError) {
  //     return effectiveDecoration.copyWith(
  //       errorText: effectiveDecoration.errorText ?? '',
  //       counterStyle: effectiveDecoration.errorStyle ??
  //           themeData.textTheme.caption!.copyWith(color: themeData.errorColor),
  //       counterText: counterText,
  //       semanticCounterText: semanticCounterText,
  //     );
  //   }

  //   return effectiveDecoration.copyWith(
  //     counterText: counterText,
  //     semanticCounterText: semanticCounterText,
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _selectionGestureDetectorBuilder =
        _TextFieldSelectionGestureDetectorBuilder(state: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = RepaintBoundary(
      child: UnmanagedRestorationScope(
        bucket: bucket,
        child: EditableText(
          key: editableTextKey,
          // readOnly: widget.readOnly || !_isEnabled,
          // toolbarOptions: widget.toolbarOptions,
          // showCursor: widget.showCursor,
          // showSelectionHandles: _showSelectionHandles,
          controller: widget.controller,
          focusNode: widget.focusNode ?? _focusNode,
          // keyboardType: widget.keyboardType,
          // textInputAction: widget.textInputAction,
          // textCapitalization: widget.textCapitalization,
          style: Theme.of(context).textTheme.subtitle1!.merge(widget.textStyle),
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
    // final MouseCursor effectiveMouseCursor =
    //     MaterialStateProperty.resolveAs<MouseCursor>(
    //   widget.mouseCursor ?? MaterialStateMouseCursor.textable,
    //   <MaterialState>{
    //     if (!_isEnabled) MaterialState.disabled,
    //     if (_isHovering) MaterialState.hovered,
    //     if (focusNode.hasFocus) MaterialState.focused,
    //     if (_hasError) MaterialState.error,
    //   },
    // );

    const int? semanticsMaxValueLength = null;

    return FocusTrapArea(
      focusNode: widget.focusNode ?? _focusNode,
      child: AnimatedBuilder(
        animation: widget.controller, // changes the _currentLength
        builder: (BuildContext context, Widget? child) {
          return Semantics(
            maxValueLength: semanticsMaxValueLength,
            currentValueLength: widget.controller.text.length,
            onTap: () {
              if (!widget.controller.selection.isValid) {
                widget.controller.selection = TextSelection.collapsed(
                    offset: widget.controller.text.length);
              }
              _requestKeyboard();
            },
            onDidGainAccessibilityFocus: () {
              // macOS automatically activated the TextField when it receives
              // accessibility focus.
              if (!(widget.focusNode ?? _focusNode).hasFocus &&
                  (widget.focusNode ?? _focusNode).canRequestFocus) {
                (widget.focusNode ?? _focusNode).requestFocus();
              }
            },
            child: child,
          );
        },
        child: _selectionGestureDetectorBuilder.buildGestureDetector(
          behavior: HitTestBehavior.translucent,
          child: child,
        ),
      ),
    );

    // return FocusTrapArea(
    //   focusNode: widget.focusNode ?? _focusNode,
    //   child: _selectionGestureDetectorBuilder.buildGestureDetector(
    //     behavior: HitTestBehavior.translucent,
    //     child: RepaintBoundary(
    //       child: EditableText(
    //         onSelectionHandleTapped: () {
    //           if (widget.controller.selection.isCollapsed) {
    //             _editableText!.toggleToolbar();
    //           }
    //           log('double tapped');
    //         },
    //         key: editableTextKey,
    //         controller: widget.controller,
    //         focusNode: widget.focusNode ?? _focusNode,
    //         style:
    //             Theme.of(context).textTheme.subtitle1!.merge(widget.textStyle),
    //         cursorColor: Colors.black,
    //         backgroundCursorColor: Colors.black12,
    //         showCursor: true,
    //         toolbarOptions: const ToolbarOptions(
    //           copy: true,
    //           cut: true,
    //           paste: true,
    //           selectAll: true,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  @override
  bool forcePressEnabled = false;

  @override
  bool get selectionEnabled => true;

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

class _TextFieldSelectionGestureDetectorBuilder
    extends TextSelectionGestureDetectorBuilder {
  _TextFieldSelectionGestureDetectorBuilder({
    required _BetterTextfieldState state,
  })  : _state = state,
        super(delegate: state);

  final _BetterTextfieldState _state;

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {
    // Not required.
  }

  @override
  void onSingleLongTapMoveUpdate(LongPressMoveUpdateDetails details) {
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          renderEditable.selectPositionAt(
            from: details.globalPosition,
            cause: SelectionChangedCause.longPress,
          );
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          renderEditable.selectWordsInRange(
            from: details.globalPosition - details.offsetFromOrigin,
            to: details.globalPosition,
            cause: SelectionChangedCause.longPress,
          );
          break;
      }
    }
  }

  @override
  void onSingleTapUp(TapUpDetails details) {
    editableText.hideToolbar();
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          switch (details.kind) {
            case PointerDeviceKind.mouse:
            case PointerDeviceKind.stylus:
            case PointerDeviceKind.invertedStylus:
              // Precise devices should place the cursor at a precise position.
              renderEditable.selectPosition(cause: SelectionChangedCause.tap);
              break;
            case PointerDeviceKind.touch:
            case PointerDeviceKind.unknown:
              // On macOS/iOS/iPadOS a touch tap places the cursor at the edge
              // of the word.
              renderEditable.selectWordEdge(cause: SelectionChangedCause.tap);
              break;
          }
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          renderEditable.selectPosition(cause: SelectionChangedCause.tap);
          break;
      }
    }
    _state._requestKeyboard();
    _state.widget.onTap?.call();
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    if (delegate.selectionEnabled) {
      switch (Theme.of(_state.context).platform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          renderEditable.selectPositionAt(
            from: details.globalPosition,
            cause: SelectionChangedCause.longPress,
          );
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          renderEditable.selectWord(cause: SelectionChangedCause.longPress);
          Feedback.forLongPress(_state.context);
          break;
      }
    }
  }
}
