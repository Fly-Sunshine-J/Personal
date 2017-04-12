import React, { Component } from 'react'
import {
    DatePickerIOS,
    View,
    TextInput,
    Text,
    ScrollView,
    StyleSheet,
} from 'react-native'


class WithLabel extends Component {
    render() {
        return (
            <View style={styles.labelContainer}>
                <View style={styles.labelView}>
                    <Text style={{fontWeight: '500'}}>
                        {this.props.label}
                    </Text>
                </View>
                {this.props.children}
            </View>
        );
    }
}

class Heading extends Component {
    render() {
        return (
            <View style={styles.headingContainer}>
                <Text style={styles.heading}>
                    {this.props.label}
                </Text>
            </View>
        );
    }
}

export default class DatePickerIOSExample extends Component {

    static defaultProps = {
        date: new Date(),
        timeZoneOffsetInHours: - (new Date()).getTimezoneOffset() / 60,
    }

    constructor(props) {
        super(props);
        this.state = {
            date: this.props.date,
            timeZoneOffsetInHours: this.props.timeZoneOffsetInHours,
        }
    }

    onTimezoneChange(event) {
        var offset = parseInt(event.nativeEvent.text, 10);
        if (isNaN(offset)) return;
        this.setState({
            timeZoneOffsetInHours: offset,
        })
    }

    _onDateChange(date) {
        this.setState({
            date: date,
        })
    }

    render() {
        return (
            <ScrollView>
                <WithLabel label="Value: ">
                    <Text>{this.state.date.toLocaleDateString() + ' ' + this.state.date.toLocaleTimeString()}</Text>
                </WithLabel>
                <WithLabel label="TimeZone: ">
                    <TextInput style={styles.textInpute}
                               value={this.state.timeZoneOffsetInHours.toString()}
                               onChange={(event) => this.onTimezoneChange(event)}/>
                    <Text style={{marginLeft: 1}}> hours from UTC</Text>
                </WithLabel>
                <Heading label="Date + time picker" />
                <DatePickerIOS date={this.state.date}
                               onDateChange={(date) => this._onDateChange(date)}
                               mode='datetime'
                               timeZoneOffsetInMinutes={this.state.timeZoneOffsetInHours * 60}
                />
                <DatePickerIOS date={this.state.date}
                               onDateChange={(date) => this._onDateChange(date)}
                               mode='date'
                               timeZoneOffsetInMinutes={this.state.timeZoneOffsetInHours * 60}
                />
                <DatePickerIOS date={this.state.date}
                               onDateChange={(date) => this._onDateChange(date)}
                               mode='time'
                               timeZoneOffsetInMinutes={this.state.timeZoneOffsetInHours * 60}
                               minuteInterval={10}
                />
            </ScrollView>
        );
    }

}


const styles = StyleSheet.create({
    textInpute: {
        height: 30,
        width: 50,
        borderWidth: 1,
        borderColor: 'green',
        padding: 4,
        fontSize: 15,
    },
    labelContainer: {
        flexDirection: 'row',
        alignItems: 'center',
        marginVertical: 2,
    },
    labelView: {
        marginRight: 10,
        paddingVertical: 2,
    },
    headingContainer: {
        padding: 4,
        backgroundColor: '#f6f7f8',
    },
    heading: {
        fontWeight: '500',
        fontSize: 14,
    },

})