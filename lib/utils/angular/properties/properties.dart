// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Parses [strValue] into a [bool].
///
/// Only the following values are acceptable as `strValue`:
///  '' = true
///  'true' = true
///  'false' = false
///
/// **NOTE**: If [strValue] is an empty string (''), it is always true. This is
/// because when you declare something like:
///     <material-button disabled></material-button>
///
/// ... The value of "disabled" is ''.
bool _parseBool(String strValue) {
  switch (strValue) {
    case '':
      return true;
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw new ArgumentError.value(
          strValue,
          'strValue',
          'Only "", "true", and "false" are acceptable values for parseBool. '
          'Found: ');
  }
}

/// A typed version of [getDynamic].
///
/// If [inputValue] is a [bool], returns it.
/// If [inputValue] is a [String], then '' and 'true' evaluate to `true` while
/// 'false' evaluates to `false`. All other string values produce an argument
/// error.
///
/// **NOTE**: inputValue must be non-null.
@Deprecated('Angular now supports boolean properties natively, for @Attribute'
    ' use [attributeToBool].')
bool getBool(inputValue) {
  if (inputValue == null) throw new ArgumentError.notNull('inputValue');

  if (inputValue is String) return _parseBool(inputValue);
  if (inputValue is bool) return inputValue;

  throw new ArgumentError.value(
      inputValue, 'inputValue', 'Expected a String, or bool type');
}

/// Parses html attribute [String] to a [bool].
///
/// Should be used to parse values passed to @Attribute constructor argument.
///
/// This does not fully follow the HTML boolean attribute definition
/// (https://stackoverflow.com/a/4139805), as 'false' String will be parsed
/// to false value.
///
/// When no attribute is present [defaultValue] value is returned (by default
/// false).
///
/// NOTE: no attribute is not the same as no value for attribute:
///
/// * <my-component foo> - foo attribute is present but has no value, which
///                        is parsed to *true*.
/// * <my-component> - no attribute is present, parsed to [defaultValue].
bool attributeToBool(String inputValue, {bool defaultValue: false}) {
  if (inputValue == null) return defaultValue;
  return _parseBool(inputValue);
}

/// A typed version of [getDynamic].
///
/// If [inputValue] is an [int], returns it.
/// If [inputValue] is a `null`, returns [defaultValue].
/// If [inputValue] is a String, parses using [onString], or uses [int.parse].
int getInt(inputValue, {int defaultValue: 0}) {
  if (inputValue == null) {
    return defaultValue;
  } else if (inputValue is String) {
    return int.parse(inputValue);
  } else {
    assert(inputValue is int);
    return inputValue;
  }
}
