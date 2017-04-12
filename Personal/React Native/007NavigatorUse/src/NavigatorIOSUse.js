import React, { Component } from 'react'
import {
    View,
    Text,
    NavigatorIOS,
    TouchableHighlight,
    StyleSheet,
} from 'react-native'

export default class SimpleNavigatorApp extends Component {
    render() {
        return(
            <NavigatorIOS
                initialRoute={{title: 'My Initial Scence', component: MyScence}}
                style={styles.container}
            />
        );
    }
}


class MyScence extends Component {

    constructor(props, context) {
        super(props, context);
        this._onForward = this._onForward.bind(this);
    }

    _onForward() {
        this.props.navigator.push({
            title: 'aaa',
            component: MyScence,
            backButtonTitle: 'Custom Back',
        })
    }

    render(){
        return(
            <View style={{backgroundColor: 'red', flex: 1}}>
                <TouchableHighlight onPress={this._onForward()} style={{width: 100, height: 100}}>
                    <Text>
                        Tap me to load the next scece
                    </Text>
                </TouchableHighlight>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container:{
        flex: 1,
    }
});

MyScence.defaultProps = {
    title: 'MyScence',
}