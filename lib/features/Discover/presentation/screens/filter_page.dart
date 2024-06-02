import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoesly/core/constants/app_text_styles.dart';
import 'package:shoesly/core/constants/assets.dart';
import 'package:shoesly/core/theme/colors.dart';
import 'package:shoesly/core/widgets/custom_app_bar.dart';
import 'package:shoesly/core/widgets/custom_button.dart';

class FilterPage extends StatefulWidget {
  static const routeName = "/filter_page";
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double _currentMinPrice = 200;
  double _currentMaxPrice = 750;
  String _selectedSort = 'Most recent';
  String _selectedGender = 'Man';
  String _selectedColor = 'Black';
  String _selectedBrand = 'Nike';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        isBack: true,
        onTap: () {
          Navigator.of(context).pop();
        },
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 10),
            child: InkWell(
              child: SvgPicture.asset(Assets.cartsvg),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Brands',
                style: bodyMediumTextStyle.copyWith(fontSize: 16)),
            SizedBox(height: 10),
            _buildBrandFilter(),
            SizedBox(height: 20),
            Text('Price Range',
               style: bodyMediumTextStyle.copyWith(fontSize: 16)),
            RangeSlider(
              min: 0,
              max: 1750,
             
              activeColor: AppColors.blackColor,
              inactiveColor: AppColors.tabColor,
              values: RangeValues(_currentMinPrice, _currentMaxPrice),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentMinPrice = values.start;
                  _currentMaxPrice = values.end;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${_currentMinPrice.toInt()}'),
                Text('\$${_currentMaxPrice.toInt()}'),
              ],
            ),
            SizedBox(height: 20),
            Text('Sort By',
               style: bodyMediumTextStyle.copyWith(fontSize: 16)),
            SizedBox(height: 10),
            _buildSortByFilter(),
            SizedBox(height: 20),
            Text('Gender',
                style: bodyMediumTextStyle.copyWith(fontSize: 16)),
            SizedBox(height: 10),
            _buildGenderFilter(),
            SizedBox(height: 20),
            Text('Color',
                style: bodyMediumTextStyle.copyWith(fontSize: 16)),
            SizedBox(height: 10),
            _buildColorFilter(),
            SizedBox(height: 20),
            
          ],
        ),
      ),
      bottomNavigationBar: Padding(padding: EdgeInsets.all(15),
      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  width: screenWidth*0.3,
                  onPressed: () {
                    setState(() {
                      _currentMinPrice = 200;
                      _currentMaxPrice = 750;
                      _selectedSort = 'Most recent';
                      _selectedGender = 'Man';
                      _selectedColor = 'Black';
                      _selectedBrand = 'Nike';
                    });
                  },
                  title: 'RESET',
                  color: AppColors.whiteColor,
                  textColor: AppColors.blackColor,
                ),
                CustomButton(
                   width: screenWidth*0.3,
                  title: 'APPLY',
                   onPressed: (){

                   }, 
                   textColor:AppColors.whiteColor,
                   color: AppColors.blackColor,
                   )
              ],
            ),
      )
    );
  }

 Widget _buildBrandFilter() {
  final brands = [
    {'name': 'Nike', 'items': 1001, 'icon': FontAwesomeIcons.n},
    {'name': 'Puma', 'items': 601, 'icon': FontAwesomeIcons.productHunt},
    {'name': 'Adidas', 'items': 709, 'icon': FontAwesomeIcons.adn},
    {'name': 'Reebok', 'items': 555, 'icon': FontAwesomeIcons.rev},
  ];

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: brands.map((brand) {
        return Padding(
          padding: EdgeInsets.only(right: 20),
          child:  GestureDetector(
          onTap: () {
            setState(() {
              _selectedBrand = brand['name'] as String;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(brand['icon'] as IconData, color: Colors.black, size: 24),
                  ),
                  if (_selectedBrand == brand['name'])
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.check, color: Colors.white, size: 12),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8),
              Text(brand['name'] as String, style: TextStyle(fontSize: 12)),
              Text('${brand['items']} Items', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
          );
      }).toList(),
    ),
  );
}



  Widget _buildSortByFilter() {
    final sortOptions = ['Most recent', 'Lowest price', 'Highest price'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: sortOptions.map((sort) {
        return ChoiceChip(
          
          backgroundColor: AppColors.whiteColor,
          selectedColor: AppColors.blackColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),

          ),
          checkmarkColor: AppColors.whiteColor,
          label: Text(sort,style: bodyMediumTextStyle.copyWith(color: _selectedSort==sort? AppColors.whiteColor:AppColors.blackColor),),
          selected: _selectedSort == sort,
          onSelected: (selected) {
            setState(() {
              _selectedSort = sort;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildGenderFilter() {
    final genderOptions = ['Man', 'Woman', 'Unisex'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: genderOptions.map((gender) {
        return ChoiceChip(
          backgroundColor: AppColors.whiteColor,
          checkmarkColor: AppColors.whiteColor,
           selectedColor: AppColors.blackColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),

          ),
          label: Text(gender,style: bodyMediumTextStyle.copyWith(color: _selectedGender==gender? AppColors.whiteColor:AppColors.blackColor),),
          selected: _selectedGender == gender,
          onSelected: (selected) {
            setState(() {
              _selectedGender = gender;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildColorFilter() {
    final colorOptions = ['Black', 'White', 'Red'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: colorOptions.map((color) {
        return ChoiceChip(
          checkmarkColor: AppColors.whiteColor,
          backgroundColor: AppColors.whiteColor,
           selectedColor: AppColors.blackColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),

          ),
          label: Text(color,style: bodyMediumTextStyle.copyWith(color: _selectedColor==color? AppColors.whiteColor:AppColors.blackColor),),
          selected: _selectedColor == color,
          onSelected: (selected) {
            setState(() {
              _selectedColor = color;
            });
          },
        );
      }).toList(),
    );
  }
}
