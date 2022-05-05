import 'package:ecommerce_app/Provider/ProductProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Utils/Colors.dart';

class ProductAttributes extends StatefulWidget {
  const ProductAttributes({Key? key}) : super(key: key);

  @override
  State<ProductAttributes> createState() => _ProductAttributesState();
}

class _ProductAttributesState extends State<ProductAttributes>
    with AutomaticKeepAliveClientMixin {
  List<String> _sizeList = [];
  bool get wantKeepAlive => true;
  bool? _saved = false;
  final _sizeText = TextEditingController();
  bool? _enter = false;
  String? selectedUnit;
  List<String> _units = [
    'kg',
    'grm',
    'no.',
    'ltr',
    'ml',
    'ft',
    'set',
  ];

//creating form widget
  Widget _formField(
      {String? label,
      TextInputType? type,
      TextInputAction? inputaction,
      String? Function(String?)? validator,
      onChanged,
      int? minLine,
      int? maxLine}) {
    return TextFormField(
      keyboardType: type,
      decoration: InputDecoration(
        label: Text(label!),
        labelStyle: TextStyle(
            color: AppColors.buttonColor.withOpacity(0.5), fontSize: 14),
        contentPadding:
            EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        border: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
        //for focused border
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(),
            borderSide: BorderSide(
              width: 1.0,
              color: AppColors.textboxColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(),
            borderSide: BorderSide(
              width: 2.0,
              color: AppColors.textboxColor,
            )),
      ),
      onChanged: onChanged,
      minLines: minLine,
      maxLines: maxLine,
      textInputAction: inputaction,
    );
  }

  //to craete the dropdown button
  Widget _unitDropDown(ProductProvider provider) {
    return DropdownButtonFormField<String>(
      value: selectedUnit,
      hint: Text('Select Unit',
          style: TextStyle(
              color: AppColors.buttonColor.withOpacity(0.5), fontSize: 14)),
      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF056608)),
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        border: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
        //for focused border
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(),
            borderSide: BorderSide(
              width: 1.0,
              color: AppColors.textboxColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(),
            borderSide: BorderSide(
              width: 2.0,
              color: AppColors.textboxColor,
            )),
      ),
      elevation: 16,
      style: const TextStyle(color: Color(0xFF056608)),
      onChanged: (String? newValue) {
        setState(() {
          selectedUnit = newValue;
          provider.getFormData(unit: newValue);
        });
      },
      items: _units.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value!.isEmpty) return 'Select unit';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProductProvider>(builder: (context, provider, _) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            //for Product tags
            _formField(
                label: 'Tags',
                type: TextInputType.text,
                inputaction: TextInputAction.next,
                onChanged: (value) {
                  provider.getFormData(tags: value);
                }),

            SizedBox(height: 10),
            //to craete unitdropdown
            _unitDropDown(provider),
            SizedBox(height: 10),

            //for ProductSize
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        label: Text('Size',
                            style: TextStyle(
                                color: AppColors.buttonColor.withOpacity(0.5),
                                fontSize: 14))),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _enter = true;
                        });
                      }
                    },
                    controller: _sizeText,
                  ),
                ),
                if (_enter == true)
                  ElevatedButton(
                      child: Text('Add'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF056608))),
                      onPressed: () {
                        setState(() {
                          _sizeList.add(_sizeText.text);
                          _sizeText.clear();
                          _enter = false;
                          _saved = false;
                        });
                      })
              ],
            ),

            SizedBox(height: 20),

            Container(
              height: 50,
              width: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _sizeList.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onLongPress: () {
                        setState(() {
                          _sizeList.removeAt(index);
                          provider.getFormData(sizeList: _sizeList);
                        });
                      },
                      child: Container(
                        color: const Color(0xFFe2efdd),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(_sizeList[index])),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 20),

            Text('Long Press to Delete',
                style: TextStyle(
                    color: AppColors.buttonColor.withOpacity(0.5),
                    fontSize: 14)),

            Padding(
              padding: const EdgeInsets.all(50),
              child: ElevatedButton(
                  child: Text(_saved == true ? 'Saved' : 'Save Size'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF056608))),
                  onPressed: () {
                    setState(() {
                      provider.getFormData(sizeList: _sizeList);
                      _saved = true;
                    });
                  }),
            ),
            SizedBox(height: 10),

            //for additional Detail
            _formField(
                label: 'Additional Detail',
                type: TextInputType.text,
                inputaction: TextInputAction.done,
                maxLine: 6,
                onChanged: (value) {
                  provider.getFormData(additionalDetail: value);
                }),
          ],
        ),
      );
    });
  }
}
