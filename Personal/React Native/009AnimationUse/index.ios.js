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
  Animated,
} from 'react-native';
import AnimatedUse from './src/Animated'
import ComposingAnimation from './src/composingAnimations'
import LayoutAnimationUse from './src/LayoutAnimation'
import ReboundUse from './src/rebound'


class AnimationUse extends Component {
  render(){
    return(
        // <AnimatedUse />
        // <ComposingAnimation />
        // <LayoutAnimationUse/>
        <ReboundUse />

    )
  }
}



AppRegistry.registerComponent('AnimationUse', () => AnimationUse);
