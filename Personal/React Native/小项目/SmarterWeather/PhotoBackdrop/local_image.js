import React, { Component } from 'react'
import {
    Image
} from 'react-native'

export default class PhotoBackdrop extends Component {
    render() {
        return (
            <Image style={{flex: 1, flexDirection: 'column'}} source={require('../flowers.png')} resizeMode='cover'>
                {this.props.children}
            </Image>
        );
    }
}