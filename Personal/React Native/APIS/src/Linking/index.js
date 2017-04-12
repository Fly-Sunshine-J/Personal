import React, {Component} from 'react'
import {
    Linking,
    StyleSheet,
    Text,
    TouchableOpacity,
    View,
} from 'react-native'

class Button extends Component {
    static PropTypes = {
        url: React.PropTypes.string,
    }

    _handleClick = () => {
        Linking.canOpenURL(this.props.url).then((support) => {
            if (support) {
                Linking.openURL(this.props.url);
            }else {
                console.log('Don\'t know how to open URI: ' + this.props.url)
            }
        })
    }

    render() {
        return(
            <TouchableOpacity onPress={this._handleClick}>
                <View style={styles.button}>
                    <Text style={styles.text}>Open {this.props.url}</Text>
                </View>
            </TouchableOpacity>
        );
    }
}

export default class LinkingExample extends Component {
    render() {
        return (
            <View style={{paddingTop: 64}}>
                <Button url={'https://www.facebook.com'} />
                <Button url={'http://www.facebook.com'} />
                <Button url={'http://facebook.com'} />
                <Button url={'fb://notifications'} />
                <Button url={'geo:37.484847,-122.148386'} />
                <Button url={'tel:9876543210'} />
            </View>
        );
    }
}

var styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'white',
        padding: 10,
        paddingTop: 30,
    },
    button: {
        padding: 10,
        backgroundColor: '#3B5998',
        marginBottom: 10,
    },
    text: {
        color: 'white',
    },
});