/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Navigator
} from 'react-native';
import SimpleNavigatorApp from './src/MyScene'
import NavigatorAppIOS from './NavigatorIOSUse'

class NavigatorUse extends Component {
  render() {
    return (
        <NavigatorAppIOS />
    );
  }
}

const styles = StyleSheet.create({

});

AppRegistry.registerComponent('NavigatorUse', () => NavigatorUse);
