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
  Image
} from 'react-native';


var screenWidth = require('Dimensions').get('window').width
var screenHeight = require('Dimensions').get('window').height

class Login extends Component {
  render() {
    return (
      <View style={styles.container}>
        <View style={[styles.TopView, styles.base]}>
          <Image source={require('./images/login_large_ic.png')} style={styles.topImage} />
        </View>
        <View style={styles.ButtomView}>
          <View style={[styles.phoneLoginView, styles.base, {borderWidth: 1, borderColor: 'white'}]}>
            <Text style={{fontSize: 18, color: 'white'}}>
              手机号登陆
            </Text>
          </View>
          <View style={[styles.phoneLoginView, {margin: 20, backgroundColor: 'white', borderWidth: 1, borderColor: 'red'}, styles.base]}>
            <Text style={{fontSize: 18, color: 'red'}}>
              立即注册
            </Text>
          </View>
          <View style={styles.otherLoginView}>
            <View style={styles.otherLoginViewTop}>
              <View style={styles.lineView}>
              </View>
              <Text style={{fontSize: 15, color: 'gray'}}>
                其他登录方式
              </Text>
              <View style={styles.lineView}>
              </View>
            </View>
            <View style={[styles.otherLoginViewButtom, styles.base]}>
              <Image source={require('./images/ic_qq_login_normal.png')} style={styles.otherLoginViewImage}/>
              <Image source={require('./images/ic_renren_login_normal.png')} style={styles.otherLoginViewImage}/>
              <Image source={require('./images/ic_tencent_login_normal.png')} style={styles.otherLoginViewImage}/>
              <Image source={require('./images/ic_weibo_login_normal.png')} style={styles.otherLoginViewImage}/>
              <Image source={require('./images/ic_weixin_login_normal.png')} style={styles.otherLoginViewImage}/>
            </View>

          </View>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'rgb(250, 250, 250)',
  },
  TopView: {
    flex: 3,
    backgroundColor: 'rgb(250, 250, 250)',
  },
  ButtomView: {
    flex: 2,
    backgroundColor: 'rgb(250, 250, 250)',
    alignItems: 'center'
  },
  topImage: {
    width: screenWidth * 0.5,
    height: screenWidth * 0.5,
  },
  phoneLoginView: {
    width: screenWidth * 0.5,
    height: 35,
    backgroundColor: 'red',
    borderRadius: 5
  },
  base: {
    justifyContent: 'center',
    alignItems: 'center',
  },
  otherLoginView: {
    height: 100,
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    backgroundColor: 'rgb(250, 250, 250)'
  },
  otherLoginViewTop:{
    flex: 1,
    backgroundColor: 'rgb(250, 250, 250)',
    justifyContent: 'center',
    alignItems: 'center',
    flexDirection: 'row'
  },
  lineView: {
    height: 1,
    width: 60,
    backgroundColor: 'gray',
    margin: 15,
  },
  otherLoginViewButtom:{
    flex: 2,
    flexDirection: 'row'
  },
  otherLoginViewImage: {
    width: 35, 
    height: 35,
    marginLeft: 5,
  },
});

AppRegistry.registerComponent('Login', () => Login);
