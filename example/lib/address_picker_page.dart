import 'package:example/widget/my_app_bar.dart';
import 'package:example/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/address_picker/address_picker.dart';

class AddressPickerPage extends StatefulWidget {
  @override
  _AddressPickerPageState createState() => _AddressPickerPageState();
}

class _AddressPickerPageState extends State<AddressPickerPage> {
  // 所在区域  省 市 区
  String initProvince = '四川省', initCity = '成都市', initTown = '双流县';

  // 选择器2
  List locations1 = ['', ''];

  // 选择器3
  List locations2 = ['四川省', '成都市', '双流县'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: '地址选择器'),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('三级地址选择'),
            _checkLocation(),
            SizedBox(height: 20),
            Text('二级地址选择'),
            _checkLocation2(),
            SizedBox(height: 20),
            Text('更多参数说明'),
            SizedBox(height: 6),
            _checkLocation3(),
          ],
        ),
      ),
    );
  }

  Widget _checkLocation() {
    Widget textView = Text(spliceCityName(pname: initProvince, cname: initCity, tname: initTown));

    return InkWell(
      onTap: () {
        AddressPicker.showPicker(
          context,
          showTitlebar: true,
          initProvince: initProvince,
          initCity: initCity,
          initTown: initTown,
          onConfirm: (p, c, t) {
            setState(() {
              initProvince = p;
              initCity = c;
              initTown = t;
            });
          },
        );
      },
      child: _outsideView(textView, initProvince, initCity, initTown),
    );
  }

  Widget _checkLocation2() {
    Widget textView = Text(spliceCityName(pname: locations1[0], cname: locations1[1]));

    return InkWell(
      onTap: () {
        AddressPicker.showPicker(
          context,
          initProvince: locations1[0],
          initCity: locations1[1],
          // initTown: null,
          showTitlebar: true,
          onConfirm: (p, c, t) {
            setState(() {
              locations1[0] = p;
              locations1[1] = c;
            });
          },
        );
      },
      child: _outsideView(textView, locations1[0], locations1[1], null),
    );
  }

  Widget _checkLocation3() {
    Widget _headMenuView = Container(
        color: Colors.grey,
        child: Row(children: [
          Expanded(child: Center(child: Text('省'))),
          Expanded(child: Center(child: Text('市'))),
          Expanded(child: Center(child: Text('区'))),
        ]));

    Widget _cancelButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 1), borderRadius: BorderRadius.circular(4)),
      child: MyText('取消', color: Theme.of(context).primaryColor, size: 14),
    );

    Widget _commitButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(4)),
      child: MyText('确认', color: Theme.of(context).primaryColor, size: 14),
    );

    Widget title = Text('请选择地址', style: TextStyle(color: Theme.of(context).unselectedWidgetColor));

    return InkWell(
      onTap: () {
        AddressPicker.showPicker(
          context,
          initProvince: locations2[0],
          initCity: locations2[1],
          initTown: locations2[2],

          // showTitlebar: true,
          // menu: _headMenuView,
          // menuHeight: 80.0,
          // title:title,
          // cancelWidget: _cancelButton,
          // commitWidget: _commitButton,
          // textColor: Colors.red,
          // backgroundColor: Colors.blue,


          onConfirm: (p, c, t) {
            setState(() {
              locations2[0] = p;
              locations2[1] = c;
              locations2[2] = t;
            });
          },
        );
      },
      child: Text(spliceCityName(pname: locations2[0], cname: locations2[1], tname: locations2[2]),
          style: TextStyle(fontSize: 16)),
    );
  }

  Widget _outsideView(Widget textView, initProvince, initCity, initTown) {
    return Container(
      constraints: const BoxConstraints(minHeight: 42),
      padding: const EdgeInsets.fromLTRB(10, 0, 12, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          textView,
          SizedBox(width: 8),
          (initProvince != '')
              ? InkWell(
                  child: Icon(Icons.close, size: 20, color: Colors.grey[500]),
                  onTap: () {
                    setState(() {
                      initProvince = '';
                      initCity = '';
                      initTown = '';
                    });
                  })
              : SizedBox(),
          SizedBox(width: 8),
          Icon(Icons.keyboard_arrow_down, size: 28, color: Colors.grey[500]),
        ],
      ),
    );
  }

  // 拼接城市
  String spliceCityName({String pname, String cname, String tname}) {
    if (strEmpty(pname)) return '不限';
    StringBuffer sb = StringBuffer();
    sb.write(pname);
    if (strEmpty(cname)) return sb.toString();
    sb.write(' - ');
    sb.write(cname);
    if (strEmpty(tname)) return sb.toString();
    sb.write(' - ');
    sb.write(tname);
    return sb.toString();
  }

  /// 字符串为空
  bool strEmpty(String value) {
    if (value == null) return true;

    return value.trim().isEmpty;
  }
}
