import 'package:flutter/material.dart';

class AppStyles {
  static const TextStyle bodySmallText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle bodyMediumText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyLargeText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyExtraLargeText = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    textStyle: bodyMediumText,
    fixedSize: const Size(150, 50),
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static Widget tableContainerVertical<T>(
    List<String> headers,
    List<T> values,
    List<Function(T)> propertyGetters,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          for (int i = 0; i < headers.length; i++) i: const FlexColumnWidth(2),
        },
        border: TableBorder.symmetric(
          inside: const BorderSide(color: Colors.black, width: 1.5),
          outside: const BorderSide(color: Colors.black, width: 2.0),
        ),
        children: [
          TableRow(
            children: headers.map((header) {
              return TableCell(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFC0C0C0), Color(0xFF00FFFF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    border: Border.symmetric(
                      vertical: BorderSide(color: Colors.black, width: 1.5),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(
                      minHeight: 30.0,
                      minWidth: 30.0,
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          header.length > 15
                              ? '${header.substring(0, (header.length / 2).ceil())}\n${header.substring((header.length / 2).ceil())}'
                              : header,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          ...values.map((item) {
            return TableRow(
              children: propertyGetters.map((getter) {
                final value = getter(item).toString();
                return TableCell(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFF806517)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      border: Border.symmetric(
                        vertical: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(
                        minHeight: 30.0,
                        minWidth: 30.0,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            value.length > 15
                                ? '${value.substring(0, (value.length / 2).ceil())}\n${value.substring((value.length / 2).ceil())}'
                                : value,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ],
      ),
    );
  }

  static Widget tableContainerHorizontal<T>(
    List<String> headers,
    List<T> values,
    List<Function(T)> propertyGetters,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          for (int i = 0; i < values.length + 1; i++)
            i: const FlexColumnWidth(2),
        },
        border: TableBorder.symmetric(
          inside: const BorderSide(color: Colors.black, width: 1.5),
          outside: const BorderSide(color: Colors.black, width: 2.0),
        ),
        children: [
          for (int i = 0; i < headers.length; i++)
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFC0C0C0), Color(0xFF00FFFF)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(
                        minHeight: 30.0,
                        minWidth: 30.0,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Text(
                          headers[i].length > 15
                              ? '${headers[i].substring(0, 15)}\n${headers[i].substring(15)}'
                              : headers[i],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                ...values.map((item) {
                  final value =
                      item != null ? propertyGetters[i](item).toString() : '';
                  return TableCell(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFD700), Color(0xFF806517)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        border: Border.symmetric(
                          horizontal:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(
                          minHeight: 30.0,
                          minWidth: 30.0,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(
                            value.length > 15
                                ? '${value.substring(0, 15)}\n${value.substring(15)}'
                                : value,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
        ],
      ),
    );
  }
}
