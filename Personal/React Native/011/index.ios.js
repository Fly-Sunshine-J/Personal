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
  TouchableOpacity,
} from 'react-native';

class MyButton extends Component {
  setNativeProps(nativeProps) {
    this._root.setNativeProps(nativeProps);
  }
  render() {
    return(
        <View>
          <Text>{this.props.label}</Text>
        </View>
    );
  }
}

class Timers extends Component {
  render() {
    return (

    <TouchableOpacity onPress={() => {
      console.log('aaa')
    }}>
      <MyButton label="Press me!"/>
    </TouchableOpacity>
        // <View  style={styles.container}>
        //
        // </View>
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
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('Timers', () => Timers);
