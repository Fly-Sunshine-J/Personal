import React, { Component, PropTypes } from 'react';
import { NavigatorIOS, Text, View, TouchableHighlight } from 'react-native';

export default class NavigatorIOSApp extends Component {
    render() {
        return (
            <NavigatorIOS
                initialRoute={{
                    component: MyScene,
                    title: 'My Initial Scene',
                    passProps: {title: 'bbbbb',}
                }}
                style={{flex: 1}}
                ref="nav"
            />
        );
    }
}

class MyScene extends Component {
    static propTypes = {
        title: PropTypes.string.isRequired,
        navigator: PropTypes.object.isRequired,
    }

    constructor(props, context) {
        super(props, context);
        this._onForward = this._onForward.bind(this);
        this._onBack = this._onBack.bind(this);
    }

    _onForward() {
        this.props.navigator.push({
            title: 'Scene ' + 2,
            component: MyScene,
            passProps: {title: 'ccc'}
        });
    }

    _onBack() {
        this.props.navigator.pop();
    }

    render() {
        return (
            <View style={{top: 64}}>
                <Text>Current Scene: { this.props.title }</Text>
                <TouchableHighlight onPress={this._onForward}>
                    <Text>Tap me to load the next scene</Text>
                </TouchableHighlight>
            </View>
        )
    }
}