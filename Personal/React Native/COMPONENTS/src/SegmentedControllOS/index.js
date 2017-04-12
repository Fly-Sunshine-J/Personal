import React, {Component} from 'react'
import {
    View,
    SegmentedControlIOS,
    Text,
    ScrollView,
    StyleSheet,
} from 'react-native'

class BasicSegmentedControlIOSExample extends Component {
    render() {
        return (
            <View>
                <View style={{marginBottom: 10}}>
                    <SegmentedControlIOS values={['One', 'Tow']} selectedIndex={0}/>
                </View>
                <View>
                    <SegmentedControlIOS values={['One', "Tow", 'Three', 'Four', 'Five']} selectedIndex={2}/>
                </View>
            </View>
        );
    }
}

class MomentarySegmentedControlIOSExample extends Component {
    render() {
        return (
            <View style={{marginTop: 10}}>
                <SegmentedControlIOS values={['One', 'Tow']} momentary={true}/>
            </View>
        );
    }
}

class ColorSegmentedControlExample extends Component {
    render() {
        return (
            <View>
                <View style={{marginTop: 10}}>
                    <SegmentedControlIOS values={['One', 'Tow', 'Three', 'Four']} tintColor='#ff0000' selectedIndex={1}/>
                </View>
                <View style={{marginTop: 10}}>
                    <SegmentedControlIOS values={['One', 'Tow', 'Three', 'Four']} tintColor='#00ff00' selectedIndex={2}/>
                </View>
            </View>
        );
    }
}

class EventSegmentedControlExample extends Component {

    constructor(props) {
        super(props);
        this.state = {
            values: ['Red', 'Green', 'Blue'],
            value: 'Not selected',
            selectedIndex: undefined,
            color: undefined,
        }
    }

    _onChange(event) {
        this.setState({
            selectedIndex: event.nativeEvent.selectedSegmentIndex
        })
    }

    _onValueChange(value) {
        this.setState({
            value: value,
            color: value.toLowerCase(),
        })
    }

    render() {
        return (
            <View style={{marginTop: 10}}>
                <Text>Value: {this.state.value}</Text>
                <Text>Index: {this.state.selectedIndex}</Text>
                <SegmentedControlIOS values={this.state.values}
                                     selectedIndex={this.state.selectedIndex}
                                     onChange={(event) => {this._onChange(event)}}
                                     onValueChange={(value) => this._onValueChange(value)}
                                     tintColor={this.state.color}
                />
            </View>
        );
    }
}

export default class SegmentedControlIOSExample extends Component {

    render() {
        return (
            <ScrollView style={{flex: 1}}>
                <BasicSegmentedControlIOSExample/>
                <MomentarySegmentedControlIOSExample/>
                <ColorSegmentedControlExample/>
                <EventSegmentedControlExample/>
            </ScrollView>
        );
    }

}