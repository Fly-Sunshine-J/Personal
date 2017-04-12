import React, { Component } from 'react'
import {
    View,
    Text,
} from 'react-native'
import styles from '../styles'

export default class Forecast extends Component {
    render() {
        return (
            <View style={{alignItems: 'center'}}>
                <Text style={styles.bigText}>
                    {this.props.main}
                </Text>
                <Text style={styles.mainText}>
                    {this.props.description}
                </Text>
                <Text style={styles.bigText}>
                    {((this.props.temp - 30) / 1.8).toFixed(1)}°C
                </Text>
            </View>
        );
    }
}