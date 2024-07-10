import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/category/category_detail_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/category/category_detail_state.dart';
import 'package:alpha_gymnastic_center/aplication/BLoC/category/category_detail_event.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/widgets/carrusel_h.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/category/get_category_use_case.dart';

class CategoryCarousel extends StatelessWidget {
  const CategoryCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryDetailBloc(GetIt.instance<GetCategoryDataUseCase>())
            ..add(const LoadCategoryDetail(page: 0, perPage: 7)),
      child: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
        builder: (context, state) {
          if (state is CategoryDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryDetailLoaded) {
            final categories = state.categories.take(3).toList();
            return SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((category) {
                  return ScrollH<Map<String, dynamic>>(
                    item: {
                      'titulo': category.name,
                      'fotoUrl': category.icon,
                      'isNew': true,
                    },
                    disposicion: 2,
                  );
                }).toList(),
              ),
            );
          } else if (state is CategoryDetailFailed) {
            return Center(child: Text('Error: ${state.failure}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
