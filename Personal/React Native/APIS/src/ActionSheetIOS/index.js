import React, {Component} from 'react'
import {
    ActionSheetIOS,
    StyleSheet,
    Text,
    View,
    ScrollView,
    UIManager,
} from 'react-native'

var BUTTONS = ['OPTIONS 0', 'OPTIONS 1', 'OPTIONS 2', 'DELETE', 'CANCEL'];
var DESTRUCTIVE_INDEX = 3;
var CANCEL_INDEX = 4;

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

export default class ActionSheetExample extends Component {
    constructor(props) {
        super(props)
        this.state = {
            clicked: 'none',
            text: ''
        }
    }

    showActionSheet() {
        ActionSheetIOS.showActionSheetWithOptions({options: BUTTONS, cancelButtonIndex: CANCEL_INDEX,
                                                   destructiveButtonIndex: DESTRUCTIVE_INDEX, title: 'ActionSheet',
                                                   message: 'show', tintColor: 'green'},
            (buttonIndex) => {
                this.setState({
                    clicked: BUTTONS[buttonIndex]
                })
            }
        )
    }

    showShareActionSheet() {
        ActionSheetIOS.showShareActionSheetWithOptions({
            url: 'https://code.facebook.com',
            message: 'message to go with the shared url',
            subject: 'a subject to go in the email heading',
            excludedActivityTypes: ['com.apple.UIKit.activity.PostToTwitter'],
        }, (error) => alert(error), (success, method) => {
            var text;
            if (success) {
                text = 'Shared via ${method}'
            }else {
                text =  'You did not share';
            }
            this.setState({text: text})
        })
    }

    showShareActionSheet1() {
        UIManager.takeSnapshot('window').then((uri) => {
            ActionSheetIOS.showShareActionSheetWithOptions({url: uri, excludedActivityTypes: ['com.apple.UIKit.activity.PostToTwitter']},
                (err) => alert(err), (success, method) => {
                    var text;
                    if (success) {
                        text = `Shared via ${method}`;
                    } else {
                        text = 'You didn\'t share';
                    }
                    this.setState({text});
                })
        }).catch((err) => {alert(err)})
    }

    render() {
        return (
            <ScrollView style={{backgroundColor:'rgb(228, 229, 234)'}}>
                <Section title="Show Action Sheet">
                    <Text onPress={() => {this.showActionSheet()}} style={styles.button}>
                        Click to show the ActionSheet
                    </Text>
                    <Text>Click button: {this.state.clicked}</Text>
                </Section>
                <Section>
                    <Text onPress={() => {this.showShareActionSheet()}} style={styles.button}>
                        Click to show the Share ActionSheet
                    </Text>
                    <Text>{this.state.text}</Text>
                </Section>
                <Section>
                    <Text onPress={() => {this.showShareActionSheet1()}} style={styles.button}>
                        Click to show the Share ActionSheet
                    </Text>
                    <Text>{this.state.text}</Text>
                </Section>
            </ScrollView>
        );
    }
}

const styles = StyleSheet.create({
    button: {
        fontWeight: '500',
        marginBottom: 10,
    }
})


