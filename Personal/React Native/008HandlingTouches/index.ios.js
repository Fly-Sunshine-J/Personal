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
  View
} from 'react-native';
import Button from './src/TouchableHighlight'
import TouchableOpacityButton from './src/TouchableOpacity'

class HandlingTouches extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Button style={{width: 100, height: 40, backgroundColor:'red'}} text='按钮1' callback={() => {
            console.log("点击了按钮");
        }}/>
        <TouchableOpacityButton style={{width: 100, height: 40, backgroundColor:'yellow'}} text='按钮2' callback={() => {
          console.log("点击了按钮");
        }} longPressCallback={()=>{
          console.log("长按了按钮");
        }}/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },

});

AppRegistry.registerComponent('HandlingTouches', () => HandlingTouches);
