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
  ScrollView,
  Image,
} from 'react-native';
import Util from './src/utils';
import ScrollViewTest from './src/scrollViewUse';


class ScrollViewUse extends Component {
  componentWillMount(){
    // Util.getDataFromServerUsingFetch(
      // 'http://api.sina.cn/sinago/list.json?channel=news_toutiao',
      // null,
      // 'GET',
      // (data)=>this.printData(data)
      // );
      Util.getDataFromServerUsingXMLHttpRequest(
          'http://api.sina.cn/sinago/list.json?channel=news_toutiao',
          null,
          'GET',
          (data)=>this.printData(data)
      );
  }

  printData(data){
    console.log(data.data);
  }

  render() {
    return (
        <ScrollViewTest />

    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  }
});

AppRegistry.registerComponent('ScrollViewUse', () => ScrollViewUse);
