import React, { Component } from 'react'
import {
    View,
    Image,
    Text,
    TextInput,
    StyleSheet,
} from 'react-native'

import Forecast from './Forecast'

const API_KEY = 'bbeb34ebf60ad50f7893e7440a1e2b0b';
var deviceWidth = require('Dimensions').get('window').width;
var deviceHeight = require('Dimensions').get('window').height;

export default class WeatherProject extends Component {
    constructor(props) {
        super(props);
        this.state = {
            zip: '',
            forecast: null,
        }
    }

    _handleText(event) {
        var zip = event.nativeEvent.text;
        fetch('http://api.openweathermap.org/data/2.5/weather?q='
            + zip + '&units=imperial&APPID=' + API_KEY)
            .then((response) => {return response.json()})
            .then((responseJSON) => {
                this.setState({
                    forecast: {
                        main: responseJSON.weather[0].main,
                        description: responseJSON.weather[0].description,
                        temp: responseJSON.main.temp,
                    }
                })
            })
            .catch((error) => {
                console.log(error);
            })
    }

    render() {
        var content = null;
        if (this.state.forecast !== null) {
            content = <Forecast main={this.state.forecast.main}
                                description={this.state.forecast.description}
                                temp={this.state.forecast.temp}
            />
        }
        return (
            <View style={styles.container}>
                <Image source={require('./flowers.png')} style={{width: deviceWidth, height:deviceHeight - 20}}>
                    <View style={styles.overlay}>
                        <View style={styles.row}>
                            <Text style={styles.mianText}>Current weather for</Text>
                            <View style={styles.zipContainer}>
                                <TextInput style={[styles.zipCode, styles.mianText]} onSubmitEditing={(event) => this._handleText(event)}/>
                            </View>
                        </View>
                        {content}
                    </View>
                </Image>
            </View>
        );
    }
}

const styles = StyleSheet.create({
   container: {
      flex: 1,
      alignItems: 'center',
      paddingTop: 20,
   } ,

    overlay: {
      backgroundColor: 'black',
        opacity: 0.5,
        alignItems: 'center',
    },
    row: {
        flex: 1,
        flexDirection: 'row',
        flexWrap: 'nowrap',
        alignItems: 'flex-start',
        padding: 20
    },
    mianText: {
        flex: 1,
        fontSize: 16,
        color: '#FFFFFF',
    },
    zipContainer: {
        flex: 1,
        borderBottomColor: '#DDDDDD',
        borderBottomWidth: 1,
        marginLeft: 5,
        marginTop: 3
    },
    zipCode: {
        height: 18,
    },
});