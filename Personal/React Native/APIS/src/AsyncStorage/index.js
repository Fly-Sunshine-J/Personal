import React, {Component} from 'react'
import {
    View,
    Text,
    PickerIOS,
    AsyncStorage,
} from 'react-native'

var Item = PickerIOS.Item;
var KEY = 'AsyncStorageKey'
var COLORS = ['red', 'orange', 'yellow', 'green', 'blue'];

export default class AsyncStorageExample extends Component {

    constructor(props) {
        super(props)
        this.state = {
            selectedValue: COLORS[0],
            message: [],
        }
    }

    componentWillMount() {
        this._loadInitialState().done();
    }

    _loadInitialState = async () => {
        try {
            var value = await AsyncStorage.getItem(KEY);
            if (value !== null) {
                this.setState({selectedValue: value})
                this._appendMessage('Recovered selection from disk: ' + value)
            }else {
                this._appendMessage('Initialized with no selection no disk')
            }
        } catch (error) {
            this._appendMessage('AysncStorage error: ' + error.message)
        }
    }

    _appendMessage = (message) => {
        this.setState({message: this.state.message.concat(message)})
    }

    _onValueChange = async (value) => {
        this.setState({selectedValue: value});
        try {
            await AsyncStorage.setItem(KEY, value);
            this._appendMessage('Saved seletction to disk: ' + value);
        } catch (error) {
            this._appendMessage('AsyncStorage error: ' + error.message);
        }
    }

    _removeStorage = async () => {
        try {
            await AsyncStorage.removeItem(KEY);
            this._appendMessage('Selection removed from disk.');
        } catch (error) {
            this._appendMessage('AsyncStorage error: ' + error.message);
        }
    };

    render() {
        var color = this.state.selectedValue;
        return (
            <View style={{paddingTop: 64}}>
                <PickerIOS selectedValue={color}
                           onValueChange={this._onValueChange}>
                    {COLORS.map((value, index) => {
                        return <Item key={value} value={value} label={value}/>
                    })}
                </PickerIOS>
                <Text>Selected: </Text>
                <Text style={{color: color}}>{this.state.selectedValue}</Text>
                <Text>{' '}</Text>
                <Text onPress={this._removeStorage}>
                    Press here to remove from storage.
                </Text>
                <Text>{' '}</Text>
                <Text>Messages:</Text>
                {this.state.message.map((m) => <Text key={m}>{m}</Text>)}
            </View>
        );
    }


}