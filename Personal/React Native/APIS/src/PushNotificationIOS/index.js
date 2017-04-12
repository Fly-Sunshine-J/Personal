import React, {Component} from 'react'
import {
    AlertIOS,
    PushNotificationIOS,
    StyleSheet,
    Text,
    TouchableOpacity,
    View,
} from 'react-native'

class Button extends Component {
    render() {
        return (
            <TouchableOpacity
                underlayColor={'white'}
                style={styles.button}
                onPress={this.props.onPress}>
                <Text style={styles.buttonLabel}>
                    {this.props.label}
                </Text>
            </TouchableOpacity>
        )
    }
}

export default class NotificationExample extends Component {

    componentWillMount() {
        PushNotificationIOS.addEventListener('notification', this._onNotification)
    }

    render() {
        return (
            <View style={{paddingTop: 64}}>
                <Button
                    onPress={this._sendNotification}
                    label="Send fake notification"
                />

                <Button
                    onPress={this._sendLocalNotification}
                    label="Send fake local notification"
                />
            </View>
        );
    }

    _onNotification = (notification) => {
        AlertIOS.alert(
            'Push Notification Received',
            'Alert message: ' + notification.getMessage(),
            [{
                text: 'Dismiss',
                onPress: null,
            }]
        );
    }

}


var styles = StyleSheet.create({
    button: {
        padding: 10,
        alignItems: 'center',
        justifyContent: 'center',
    },
    buttonLabel: {
        color: 'blue',
    },
});