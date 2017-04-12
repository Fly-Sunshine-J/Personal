import React, { Component, PropTypes } from 'react'
import {
    ScrollView,
    View,
    Text,
    Picker,
    StyleSheet
} from 'react-native'

class PickPage extends Component {

    static propTypes = {
        title: React.PropTypes.string
    }

    render() {
        return (
            <View  style={[{margin: 10, height: 240, backgroundColor: 'white'}, this.props.style]}>
                <Text style={{height: 20, backgroundColor: 'rgb(244, 245, 248)'}}>{this.props.title}</Text>
                <View>{this.props.children}</View>
            </View>
        );
    }
}
export default class ModalExample extends Component {

    constructor(props) {
        super(props)
        this.state = {
            selected1: 'key1',
            selected2: 'key1',
            selected3: 'key1',
            color: 'red',
            mode: 'dialog'
        }
    }

    _onValueChange(itemValue, itemPosition, key) {
        console.log(itemValue, itemPosition)
        var newState = {};
        newState[key] = itemValue;
        this.setState(newState)
    }

    render() {
        return (
            <ScrollView style={{flex: 1, backgroundColor: 'rgb(225, 230, 234)'}}>
                <PickPage title="Basic Picker">
                    <Picker style={styles.picker}
                            selectedValue={this.state.selected1}
                            onValueChange={(itemValue, itemPosition) => {this._onValueChange(itemValue, itemPosition, 'selected1')}}>
                        <Picker.Item label="hello" value="key0"/>
                        <Picker.Item label="world" value="key1"/>
                    </Picker>
                </PickPage>
                <PickPage title='Disable picker'>
                    <Picker style={styles.picker}
                            selectedValue={this.state.selected1}
                            enabled={false}>
                        <Picker.Item label="hello" value="key1"/>
                        <Picker.Item label="world" value="key0"/>
                    </Picker>
                </PickPage>
                <PickPage title='Dropdown Picker'>
                    <Picker style={styles.picker}
                            selectedValue={this.state.selected2}
                            onValueChange={(itemValue, itemPosition) => this._onValueChange(itemValue, itemPosition, 'selected2')}
                            mode='dropdown'>
                        <Picker.Item label="hello" value="key0"/>
                        <Picker.Item label="world" value="key1"/>
                    </Picker>
                </PickPage>
                <PickPage title='Picker with prompt message used on Android in dialog mode'>
                    <Picker style={styles.picker}
                            selectedValue={this.state.selected3}
                            onValueChange={(itemValue, itemPosition) => {this._onValueChange(itemValue, itemPosition, 'selected3')}}
                            prompt='Pick one, Just one'>
                        <Picker.Item label="hello" value="key0"/>
                        <Picker.Item label="world" value="key1"/>
                    </Picker>
                </PickPage>
                <PickPage title='Picker with no listener' style={{justifyContent: 'flex-end'}}>
                    <Picker style={styles.picker}>
                        <Picker.Item label="hello" value="key0"/>
                        <Picker.Item label="world" value="key1"/>
                    </Picker>
                    <Text style={{color: 'red'}}>Cannot change the 试试事实上事实上事实上事实上事实上事实上事实上是事实上事实上事实上 value of this picker because it doesn't update selectedValue</Text>
                </PickPage>
                <PickPage title='Colorful picker' style={{height: 600}}>
                    <Picker style={[styles.picker, {backgroundColor: '#333'}]}
                            selectedValue={this.state.color}
                            onValueChange={(itemValue, ItemPosition) => {this._onValueChange(itemValue, ItemPosition, 'color')}}
                            mode='dropdown'>
                        <Picker.Item label="red" color="red" value="red"/>
                        <Picker.Item label="green" color="green" value="green"/>
                        <Picker.Item label="blue" color="blue" value="blue"/>
                    </Picker>
                    <Picker style={styles.picker}
                            selectedValue={this.state.color}
                            onValueChange={(itemValue, ItemPosition) => {this._onValueChange(itemValue, ItemPosition, 'color')}}
                            mode='dropdown'>
                        <Picker.Item label="red" color="red" value="red"/>
                        <Picker.Item label="green" color="green" value="green"/>
                        <Picker.Item label="blue" color="blue" value="blue"/>
                    </Picker>
                </PickPage>
            </ScrollView>
        );
    }

}

const styles = StyleSheet.create({
    picker: {
        width: 100,
    }
})