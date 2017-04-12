import React, {Component} from 'react'
import {
    Switch,
    View,
    Text,
    StyleSheet,
    ScrollView,
} from 'react-native'


class Page extends Component {
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
        )
    }
}

export default class SwitchExample extends Component {

    constructor(props) {
        super(props)
        this.state = {
            trueSwitchIsOn: true,
            falseSwitchIsOn: false,
            colorTrueSwitchIsOn: true,
            colorFalseSwitchIsOn: false,
            eventSwitchIsOn: false,
            eventSwitchRegressionIsOn: true,
        }
    }

    render() {
        return (
            <ScrollView style={{backgroundColor: 'rgb(228, 229, 234)'}}>
                <Page title='Switches can be set to ture of false'>
                    <Switch value={this.state.trueSwitchIsOn}
                            onValueChange={(value) => {this.setState({
                                trueSwitchIsOn: value
                            })}}
                    />
                    <Switch value={this.state.falseSwitchIsOn}
                            onValueChange={(value) => {this.setState({
                                falseSwitchIsOn: value
                            })}}
                    />
                </Page>
                <Page title='Color with Switch'>
                    <Switch onValueChange={(value) => {
                        this.setState({
                            colorFalseSwitchIsOn: value,
                        })
                    }}      onTintColor='#00ff00'
                            thumbTintColor='#0000ff'
                            tintColor='#ff0000'
                            value={this.state.colorFalseSwitchIsOn}
                            style={{marginBottom: 10}}
                    />
                    <Switch onValueChange={(value) => {
                        this.setState({
                            colorTrueSwitchIsOn: value,
                        })
                    }}
                            onTintColor='#00ff00'
                            thumbTintColor='#0000ff'
                            tintColor='#ff0000'
                            value={this.state.colorTrueSwitchIsOn}
                    />
                </Page>
                <Page title='event with Switch'>
                    <View style={{flexDirection: 'row', justifyContent:'space-around', alignItems: 'center'}}>
                        <Switch onValueChange={(value) => {this.setState({eventSwitchIsOn: value})}}
                                value={this.state.eventSwitchIsOn}/>
                        <Switch onValueChange={(value) => {this.setState({eventSwitchIsOn: value})}}
                                value={this.state.eventSwitchIsOn}/>
                        <Text>{this.state.eventSwitchIsOn ? 'On' : 'Off'}</Text>
                    </View>
                </Page>
            </ScrollView>
        );
    }
}