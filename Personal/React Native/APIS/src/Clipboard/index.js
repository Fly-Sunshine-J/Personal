import React, {Component} from 'react'
import {
    Clipboard,
    View,
    Text,
} from 'react-native'


export default class ClipboardExample extends Component {
    constructor(props) {
        super(props)
        this.state = {
            content: 'Content will appear here'
        }
    }

     _setClipboardContent = async () => {
        Clipboard.setString('Hello World');
        try {
            var content = await Clipboard.getString();
            this.setState({content: content})
        } catch (error) {
            this.setState({content: error.message})
        }
    }

    render() {
        return (
            <View style={{paddingTop: 64}}>
                <Text onPress={this._setClipboardContent}>
                    Tap to put "Hello World" in the clipboard
                </Text>
                <Text style={{marginTop: 20}}>
                    {this.state.content}
                </Text>
            </View>
        );
    }
}