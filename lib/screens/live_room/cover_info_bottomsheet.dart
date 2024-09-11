import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class CoverInfoBottomsheet extends StatefulWidget {
  const CoverInfoBottomsheet({super.key});

  @override
  State<CoverInfoBottomsheet> createState() => _CoverInfoBottomsheetState();
}

class _CoverInfoBottomsheetState extends State<CoverInfoBottomsheet> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final List<String> _chipLabels = [
    'Any',
    'Live',
    'Chat',
    'Party',
    'Sing',
    'Radio',
    'Game',
    'Scoor',
    'Birthday',
    'Emotions',
    'Dj'
  ];

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7, // Set height to 60% of screen height
      child: ClipRRect(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _image!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: '',
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.grey,
                                    width: 80,
                                    height: 80,
                                  ),
                                  fit: BoxFit.fill,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                      ),
                      const Positioned(
                        bottom: 1,
                        right: 1,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 12,
                          child: Icon(
                            Icons.add,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              verticalGap(20),
              const Text(
                'Your Live\'s Title',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalGap(20),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4, // 4 chips per row
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2,
                children: List.generate(_chipLabels.length, (index) {
                  return LayoutBuilder(builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth,
                      child: ChoiceChip(
                        label: Text(_chipLabels[index]),
                        selected: _selectedIndex == index,

                        onSelected: (bool isSelected) {
                          setState(() {
                            _selectedIndex = isSelected ? index : -1;
                          });
                        },
                        selectedColor: Colors.red, // Color when selected
                        side: const BorderSide(
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          color: _selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    );
                  });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
