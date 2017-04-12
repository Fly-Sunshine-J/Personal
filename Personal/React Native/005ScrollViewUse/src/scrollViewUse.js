import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    ScrollView,
    Image,
} from 'react-native';

export default class extends Component {
    render() {
        return (
            <ScrollView>
                <Text style={{fontSize: 90}}>ScrollView Use</Text>
                <Image source={require('../images/ic_weixin_login_normal.png')} />
                <Image source={require('../images/ic_qq_login_normal.png')} />
                <Text style={{fontSize: 90}}>ScrollView Use</Text>
                <Image source={require('../images/ic_weibo_login_normal.png')}/>
                <Image source={require('../images/ic_renren_login_normal.png')}/>
                <Text style={{fontSize: 90}}>ScrollView Use</Text>
                <Image source={require('../images/ic_tencent_login_normal.png')}/>
            </ScrollView>
        );
    }
}