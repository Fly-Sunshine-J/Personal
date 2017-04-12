import React, {Component} from 'react'
import {
    StatusBar,
    StatusBarIOS,
    View,
    Text,
    TouchableOpacity,
    StyleSheet,
    ScrollView,
} from 'react-native'



class Button extends Component {

    static propTypes = {
        label: React.PropTypes.string,
        onPress: React.PropTypes.func,
    }

    render() {
        return (
            <TouchableOpacity onPress={this.props.onPress}>
                <View style={{height: 40, justifyContent: 'center', margin: 10, backgroundColor: 'gray'}}>
                    <Text style={{textAlign: 'left'}}>{this.props.label}</Text>
                </View>
            </TouchableOpacity>
        );
    }
}

class Page extends Component {
    static propTypes = {
        title: React.PropTypes.string,
    }

    render() {
        return (
            <View style={{margin: 10, backgroundColor: 'white'}}>
                <View style={{height: 20, backgroundColor: 'rgb(244, 245, 248)'}}>
                    <Text>{this.props.title}</Text>
                </View>
                <View style={{justifyContent: 'space-around'}}>
                    {this.props.children}
                </View>
            </View>
        );
    }
}

const colors = [
    '#ff0000',
    '#00ff00',
    '#0000ff',
];

const barStyles = [
    'default',
    'light-content',
];

const showHideTransitions = [
    'fade',
    'slide',
];

const Uitil = {
    getValue(values, index) {
        return values[index % values.length];
    },
}

export default class StatusBarExample extends Component {

    constructor(props) {
        super(props);
        this.state = {
            animated: true,
            hidden: false,
            showHideTransition: 'fade',
            networkActivityIndicatorVisible: false,
            barStyle: 'default',
        }
    }

    _onPressHidden() {
        this.setState({
            hidden: !this.state.hidden,
        })
    }

    _onPressAnimated() {
        this.setState({
            animated: !this.state.animated,
        })
    }

    _showHideTransitionIndex = 0;

    _onPressshowHideTransition() {
        this.setState({
            showHideTransition: Uitil.getValue(showHideTransitions, this._showHideTransitionIndex += 1)
        })
    }

    _styleIndex = 0;

    _onPressStyle() {
        this.setState({
            barStyle: Uitil.getValue(barStyles, this._styleIndex += 1),
        })
    }

    _onPressActivityIndicator() {
        this.setState({
            networkActivityIndicatorVisible: !this.state.networkActivityIndicatorVisible,
        })
    }

    render() {
        return (
            <ScrollView style={{backgroundColor: 'rgb(228, 229, 234)'}}>
                <StatusBar showHideTransition={this.state.showHideTransition}
                           animated={this.state.animated}
                           hidden={this.state.hidden}
                           networkActivityIndicatorVisible={this.state.networkActivityIndicatorVisible}
                           barStyle={this.state.barStyle}
                />
                <Page title='StatusBar hidden'>
                    <Button label={'hidden: ' + this.state.hidden.toString()} style={{}} onPress={() => {this._onPressHidden()}}/>
                    <Button label={"animated(ios only): " + this.state.animated.toString()} onPress={() => {this._onPressAnimated()}}/>
                    <Button label={"showHideTransition(ios only): " + this.state.showHideTransition} onPress={() => {this._onPressshowHideTransition()}}/>
                </Page>
                <Page title='StatusBar style(ios only)'>
                    <Button label={'style: ' + this.state.barStyle} onPress={() => {this._onPressStyle()}}/>
                    <Button label={'animated: ' + this.state.animated.toString()} onPress={() => {this._onPressAnimated()}}/>
                </Page>
                <Page title='StatusBar network activity indicator (ios only)'>
                    <Button label={'networkActivityIndicatorVisiable: ' + this.state.networkActivityIndicatorVisible.toString()}
                            onPress={() => {this._onPressActivityIndicator()}}/>
                </Page>
                <Page title='StatusBar static API (ios only)'>
                    <Button label={'setHidden('+ this.state.animated + ', ' + this.state.showHideTransition + ')'}
                            onPress={() => {StatusBar.setHidden(this.state.animated, this.state.showHideTransition)}}/>
                    <Button label={'setBarStyle('+ this.state.barStyle + ', ' + this.state.animated + ')'}
                            onPress={() => {StatusBar.setBarStyle(this.state.barStyle, this.state.animated)}}/>
                    <Button label={'setnetworkActivityIndicatorVisible('+ this.state.networkActivityIndicatorVisible + ')'}
                            onPress={() => {StatusBar.setNetworkActivityIndicatorVisible(this.state.networkActivityIndicatorVisible)}}/>
                </Page>
            </ScrollView>
        )
    }
}


