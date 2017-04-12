import React, {Component} from 'react'
import {
    View,
    Text,
    TouchableOpacity,
    AlertIOS,
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


class Section extends Component {

    static propTypes = {
        title: React.PropTypes.string
    }

    render() {
        return (
            <View style={{margin: 10}}>
                <View style={{backgroundColor: 'rgb(244, 245, 248)'}}>
                    <Text>{this.props.title}</Text>
                </View>
                <View style={{backgroundColor: 'white'}}>
                    {this.props.children}
                </View>
            </View>
        );
    }
}

var alertMessage = 'Credibly reintermediate next-generation potentialities after goal-oriented ' +
    'catalysts for change. Dynamically revolutionize.';

export default class AlertIOSExample extends Component {

    constructor(props) {
        super(props)
        this.saveResponse = this.saveResponse.bind(this);
        this.customButtons = [
            {text: 'Custom OK', onPress: this.saveResponse},
            {text: 'Custom Cancel', onPress: this.saveResponse},
            ]
        this.state = {
                promptValue: undefined,
        }
    }

    saveResponse(promptValue) {
        this.setState({
            promptValue: JSON.stringify(promptValue),
        })
    }

    render() {
        return (
            <ScrollView style={{backgroundColor: 'gray'}}>
                <Section title='Alerts'>
                    <Button label='Alert with one button' onPress={() => {
                        AlertIOS.alert('Alert title', alertMessage,
                        [{text: 'OK', onPress: () => {console.log('OK pressed!')}}])
                    }}/>
                    <Button label='Alert with tow button' onPress={() => {
                        AlertIOS.alert('Alert title', alertMessage,
                            [
                                {text: 'Cancel', onPress: () => {console.log('Cancle pressed!')}},
                                {text: 'OK', onPress: () => {console.log('OK pressed!')}}
                            ])
                    }}/>
                    <Button label='Alert with three button' onPress={() => {
                        AlertIOS.alert('Alert title', null,
                            [
                                {text: 'Foo', onPress: () => {console.log('Foo')}},
                                {text: 'Bar', onPress: () => {console.log('Bar')}},
                                {text: 'Baz', onPress: () => {console.log('Baz')}},
                            ]
                        )
                    }}/>
                    <Button label='Alert with too many button' onPress={() => {
                        AlertIOS.alert('Foo title', alertMessage,
                            '. . . . . . . . . . .'.split(' ').map((dot, index) => {
                                return (
                                {text: 'Button' + index, onPress: () => {console.log('pressed' + index)}}
                                );
                            })
                        )
                    }}/>
                </Section>
                <Section title='Prompt Options'>
                    <Text style={{marginTop: 10}}>{this.state.promptValue}</Text>
                    <Button label='prompt with title & callBack' onPress={() => {
                        AlertIOS.prompt('Type a value', null, this.saveResponse)
                    }}/>
                    <Button label='Prompt with title & custom buttons' onPress={() => {
                        AlertIOS.prompt('Type a value', null, this.customButtons)
                    }}/>
                    <Button label='prompt with title, callback, & default value' onPress={() => {
                        AlertIOS.prompt('Type a value', null, this.saveResponse, undefined, 'Default value')
                    }}/>
                    <Button label='prompt with title, custom buttons, login/password & default value'
                            onPress={() => {
                                AlertIOS.prompt('Type a value', null, this.customButtons, 'login-password', 'admin@site.com')
                            }}
                    />
                </Section>
                <Section title='Prompt Types'>
                    <Button label='plain-text' onPress={() => {
                        AlertIOS.prompt('Plain Text entry')
                    }}/>
                    <Button label='secure-text' onPress={() => {
                        AlertIOS.prompt('Secure Text', null, null, 'secure-text')
                    }}/>
                    <Button label='login-password' onPress={() => {
                        AlertIOS.prompt('Login & Password', null, null, 'login-password')
                    }}/>
                </Section>
            </ScrollView>
        );
    }

}