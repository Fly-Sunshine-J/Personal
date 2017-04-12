import React, { Component } from 'react';
import {
    View,
    Text,
    StyleSheet,
} from 'react-native';

export default class Forecast extends Component {
    render() {
        return (
            <View>
                <Text style={styles.bigText}>{this.props.main}</Text>
                <Text style={styles.mainText}>{this.props.description}</Text>
                <Text style={styles.bigText}>{((this.props.temp - 32) / 1.8).toFixed(1)}°C</Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    bigText: {
        flex: 4,
        fontSize: 20,
        textAlign: 'center',
        color: 'white'
    },
    mainText: {
        flex: 3,
        fontSize: 16,
        textAlign: 'center',
        color: 'white',
    }
})