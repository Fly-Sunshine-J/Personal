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
  Image,
  CameraRoll,
} from 'react-native';


import Weather from './SmartWeatherProject'



class SmarterWeather extends Component {
  render() {
    return (
        <Weather/>

    );
  }
}


AppRegistry.registerComponent('SmarterWeather', () => SmarterWeather);
