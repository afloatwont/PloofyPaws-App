import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/adaptive_modal_bottom_sheet.dart';
import 'package:ploofypaws/components/dotted_container.dart';
import 'package:ploofypaws/components/global_snack_bar.dart';
import 'package:ploofypaws/components/input_label.dart';
import 'package:ploofypaws/config/theme/theme.dart';

class DocumentPicker extends StatefulWidget {
  final String? inputLabel;
  final List<File> files;
  final int? maxFiles;

  const DocumentPicker({super.key, required this.files, this.maxFiles = 3, this.inputLabel});

  @override
  State<DocumentPicker> createState() => _DocumentPickerState();
}

class _DocumentPickerState extends State<DocumentPicker> {
  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      List<File> newFiles = result.paths
          .map((path) => File(path!))
          .where((file) => file.lengthSync() <= 1024 * 1024) // Limit file size to 1 MB
          .toList();

      if (widget.files.length + newFiles.length > widget.maxFiles!) {
        GlobalSnackBar.show(context, message: 'You can only upload a maximum of ${widget.maxFiles} files');
        setState(() {
          widget.files.addAll(newFiles.sublist(0, widget.maxFiles! - widget.files.length));
        });
      } else {
        for (var file in newFiles) {
          if (file.lengthSync() > 1024 * 1024) {
            GlobalSnackBar.show(context, message: 'File size cannot exceed 1 MB');
            return;
          }
        }

        setState(() {
          widget.files.addAll(newFiles);
        });
      }
    }
  }

  void _openFilePreview(File file, BuildContext context) {
    showAdaptiveModalBottomSheet(
        context: context,
        builder: (context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: colors(context).onSurface.s100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: file.path.endsWith('pdf')
                    ? const Center(
                        child: Text('PDF Preview'),
                      )
                    : Image.file(file),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: InputLabel(label: widget.inputLabel ?? 'Documents')),
            if (widget.files.isNotEmpty && widget.files.length < 3)
              InkWell(
                onTap: _pickFiles,
                child: Row(
                  children: [
                    const Icon(Iconsax.add, color: primary),
                    const SizedBox(width: 8),
                    Text(
                      'Add more',
                      style: typography(context).smallBody.copyWith(
                            color: primary,
                          ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        CustomPaint(
          painter: DottedBorderPainter(),
          child: GestureDetector(
            onTap: widget.files.isEmpty ? _pickFiles : null,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: colors(context).onSurface.s100,
              ),
              child: widget.files.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: widget.files.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => _openFilePreview(widget.files[index], context),
                                  child: Container(
                                    height: 64,
                                    width: 64,
                                    decoration: BoxDecoration(
                                      color: colors(context).onSurface.s100,
                                      border: Border.all(color: colors(context).onSurface.s200),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: widget.files[index].path.endsWith('pdf')
                                        ? Container(
                                            height: 64,
                                            width: 64,
                                            decoration: BoxDecoration(
                                              color: colors(context).onSurface.s50,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: colors(context).onSurface.s200),
                                            ),
                                            child: const Icon(Iconsax.document))
                                        : Container(
                                            height: 64,
                                            width: 64,
                                            decoration: BoxDecoration(
                                              color: colors(context).onSurface.s50,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: colors(context).onSurface.s200),
                                              image: DecorationImage(
                                                image: FileImage(widget.files[index]),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                  ),
                                  child: Text(
                                    widget.files[index].path.split('/').last,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 10,
                              right: 20,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.files.removeAt(index);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colors(context).onSurface.s50,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.remove_circle, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Iconsax.document_upload,
                          color: Colors.black,
                          size: 24,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Upload',
                          style: typography(context).smallBody,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
