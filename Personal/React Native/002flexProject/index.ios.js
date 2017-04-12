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

class felxProject extends Component {
  render() {
    return (
      <View style={styles.container}>
        <View style={styles.topView}>
          <View style={styles.topLeftView}>
            <View style={styles.topLeftViewTop}>
            </View>
            <View style={styles.topLeftViewButtom}>
            </View>
          </View>
          <View style={styles.topRightView} />
        </View>
        <View style={styles.buttomView}>
          <View style={styles.buttomViewLeft} />
          <View style={styles.buttomViewCenter} />
          <View style={styles.buttomViewRight}>
            <View style={styles.rightTopView} />
            <View style={styles.rightButtomView} />
          </View>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5FCFF',
  },
  topView: {
    flex: 2,
    backgroundColor: 'red',
    flexDirection: 'row',
  },
  buttomView: {
    flex: 1,
    backgroundColor: 'yellow',
    flexDirection: 'row',
  },
  topLeftView: {
    flex: 2,
    backgroundColor: 'gray',
  },
  topRightView: {
    flex: 3,
    backgroundColor: 'green',
  },
  topLeftViewTop: {
    flex: 1,
    backgroundColor: 'red',
  },
  topLeftViewButtom: {
    flex: 3,
    backgroundColor: 'purple',
  },
  buttomViewLeft: {
    flex: 2,
    backgroundColor: 'blue',
  },
  buttomViewCenter: {
    flex: 2,
    backgroundColor: 'yellow',
  },
  buttomViewRight: {
    flex: 1,
    backgroundColor: 'purple',
  },
  rightTopView: {
    flex: 1,
    backgroundColor: 'white',
  },
  rightButtomView: {
    flex: 1,
    backgroundColor: 'purple'
  }
});

AppRegistry.registerComponent('felxProject', () => felxProject);
