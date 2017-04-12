/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
} from 'react-native';

import HomeView from './src/HomeView'

class APIS extends Component {
  render() {
    return (
      <HomeView/>
    );
  }
}


AppRegistry.registerComponent('APIS', () => APIS);
