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

class accessibility extends Component {

  renderOne() {
    return(
        <View style={styles.container} accessible={true}>
          <Text>text one</Text>
          <Text>text two</Text>
        </View>
    );
  }

  renderTwo() {
    return(
        <TouchableOpacity accessible={true} accessibilityLabel={'Tap me!'} onPress={() => this._onPress()} style={styles.container}>
          <View style={styles.button}>
            <Text style={styles.buttonText}>Press me!</Text>
          </View>
        </TouchableOpacity>
    );
  }

  _onPress() {
    console.log('点击了按钮');
  }

  render() {
    return (
        // this.renderOne()
        // this.renderTwo()
        this.renderThree()
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
  button: {
    width: 100,
    height: 40,
    backgroundColor: 'black',
    justifyContent: 'center',
    alignItems: 'center',
  },
  buttonText: {
    fontSize: 18,
    color: 'white',
  }
});

AppRegistry.registerComponent('accessibility', () => accessibility);
