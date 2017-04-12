/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  NavigatorIOS,
} from 'react-native';

import HomeView from './src/listView'

class COMPONENTS extends Component {
  render() {
    return (
        <HomeView/>
    );
  }
}

AppRegistry.registerComponent('COMPONENTS', () => COMPONENTS);
