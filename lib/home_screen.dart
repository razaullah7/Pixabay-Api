import 'package:assignment/image_view_model/image_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ImageViewModel _imageViewModel = ImageViewModel();
  final _searchController = TextEditingController();
  String? _search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: const Text('Images Collection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10),
                height: 50,
                decoration: BoxDecoration(color: Colors.white),
                child: TextFormField(
                  controller: _searchController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Search Image here',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        print('Pressed Icon Button');
                        setState(() {
                          _search = _searchController.text;
                        });
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                  future: _search != null
                      ? _imageViewModel.fetchImagesApi(_search!)
                      : null,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return const Text('No data available');
                    } else {
                      return MasonryGridView.count(
                          primary: false,
                          itemCount: 20,
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              constraints: BoxConstraints(
                                  minWidth:
                                      (MediaQuery.of(context).size.width / 2) -
                                          10),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16)),
                              child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.hits![index].largeImageURL
                                      .toString()),
                            );
                          });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
