import React, {Component, PropTypes} from 'react'
import {
    View,
    NavigatorIOS,
} from 'react-native'

export default class Navigator extends Component{

    static PropTypes = {
        title: React.PropTypes.string.isRequired,
        component: React.PropTypes.object.isRequired,
    }

    render() {
        return (
            <NavigatorIOS initialRoute={{title: this.props.title, component: this.props.component, backButtonTitle: '返回', tintColor:'white'}}
                          style={{flex: 1}}
                          barTintColor='rgb(241, 82, 116)'
                          titleTextColor='white'/>
        )
    }
}