import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/app_typography.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';

class SearchField extends StatefulWidget {

  const SearchField({
    required this.hintText, required this.searchQuery, required this.onChanged, super.key,
    this.onFilterTap,
    this.showFilterButton = false,
    this.focusNode,
  });
  final String hintText;
  final String searchQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterTap;
  final bool showFilterButton;
  final FocusNode? focusNode;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.searchQuery);
    _focusNode = widget.focusNode ?? FocusNode();

    // Add listener to handle focus changes
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(SearchField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update controller text when searchQuery changes from outside
    if (widget.searchQuery != _controller.text) {
      _controller.text = widget.searchQuery;
    }

    // Update focus node if it changes
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode
        ..removeListener(_onFocusChange)
        ..dispose();
      _focusNode = widget.focusNode ?? FocusNode()
        ..addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    // Only dispose the focus node if we created it ourselves
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      // Close keyboard when focus is lost
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: (value) {
                widget.onChanged(value);
              },
              onTapOutside: (_) {
                // Close keyboard when tapping outside
                _focusNode.unfocus();
              },
              style: AppTypography.sixteen.withColor(colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: AppTypography.fourteen
                    .withColor(colorScheme.onSurfaceVariant)
                    .withOpacity(0.6),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: colorScheme.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                suffixIcon: widget.searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        onPressed: () {
                          _controller.clear();
                          widget.onChanged('');
                          _focusNode.unfocus(); // Close keyboard when clearing
                        },
                      )
                    : null,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) {
                // Close keyboard when search is submitted
                _focusNode.unfocus();
              },
            ),
          ),
          if (widget.showFilterButton && widget.onFilterTap != null) ...[
            const SizedBox(width: 8),
            SizedBox(
              height: 48,
              child: IconButton(
                onPressed: () {
                  // Close keyboard before showing filter
                  _focusNode.unfocus();
                  widget.onFilterTap!();
                },
                style: IconButton.styleFrom(
                  backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(
                  Icons.filter_list_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
