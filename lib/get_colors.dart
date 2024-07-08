import 'dart:convert';

import 'package:color_app/color_model.dart';
import 'package:color_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetColors extends StatefulWidget {
  const GetColors({super.key});

  @override
  State<GetColors> createState() => _GetColorsState();
}

class _GetColorsState extends State<GetColors> {
  final List<ColorModel> colors = [];
  String selectedColor = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchColors();
  }

  Future<void> _fetchColors() async {
    try {
      final response =
          await http.get(Uri.parse('https://www.csscolorsapi.com/api/colors'));

      if (response.statusCode == 200) {
        final newColors = jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          colors.addAll(List<ColorModel>.from(newColors['colors']
              .map((x) => ColorModel.fromMap(x as Map<String, dynamic>))));
          isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch colors : ${e.toString()}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Center(child: CircularProgressIndicator()) : AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: selectedColor == '' ? null : BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            hexToColor(selectedColor),
            Colors.transparent
          ],
          stops: const [0.0, 1.0],
        )
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: colors.length,
              itemBuilder: (context, index) {
                final color = ColorModel(
                    name: colors[index].name,
                    hex: colors[index].hex,
                    theme: colors[index].theme,
                    group: colors[index].group,
                    rgb: colors[index].rgb);
      
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color.hex;
                      });
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${color.name} Selected, Theme is ${color.theme}, Group is${color.group}.'),
      
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: hexToColor(color.hex),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
