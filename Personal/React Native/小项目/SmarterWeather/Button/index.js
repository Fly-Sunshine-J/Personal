import React, { Component, PropTypes} from 'react'
import {
    View,
    Text,
    TouchableHighlight,
    StyleSheet,
} from 'react-native'
import styles from '../styles'

export default class Button extends Component {
    static propTypes = {
        onPress: React.PropTypes.func,
        label: React.PropTypes.string
    }

    render() {
        return (
            <TouchableHighlight onPress={this.props.onPress}>
                <View style={[styles.buttonStyle, this.props.style]}>
                    <Text>{this.props.label}</Text>
                </View>
            </TouchableHighlight>
        );
    }
}
