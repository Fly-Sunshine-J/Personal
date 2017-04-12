import React, {Component} from 'react';
import {
    StyleSheet,
    Text,
    View,
    TextInput,
    AsyncStorage,
    Image
} from 'react-native';

import Button from './Button'
import Forecast from './Forecast'
import LocationButton from './LocationButton'
import textStyles from './styles'
import PhotoBackdrop from './PhotoBackdrop'

const STORAGE_KEY = '@SmarterWeather:zip';
const WEATHER_API_KEY = 'bbeb34ebf60ad50f7893e7440a1e2b0b';
const API_STEM = 'http://api.openweathermap.org/data/2.5/weather?';

var screenWidth = require('Dimensions').get('window').width
var screenHeight = require('Dimensions').get('window').height

export default class Weather extends Component {
    constructor(props) {
        super(props);
        this.state = {
            forecast: null,
        };

        this._getForecastForZip = this._getForecastForZip.bind(this);
        this._getForecastForCoords = this._getForecastForCoords.bind(this);
        this._handleTextChange = this._handleTextChange.bind(this);
        this._getForecast = this._getForecast.bind(this);
    }

    _getForecast(url) {
        fetch(url)
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
            .catch((error) => console.log(error))
    }

    _getForecastForZip(zip) {
        AsyncStorage.setItem(STORAGE_KEY, zip)
            .then(() => console.log('Saved selection to disk: ' + zip))
            .catch((error) => console.log("失败")).done();
        this._getForecast(API_STEM + 'q=' + zip + '&units=imperial&APPID='+ WEATHER_API_KEY);
    }

    _getForecastForCoords(lat, lng) {
        this._getForecast(API_STEM + 'lat=' + lat + '&lon=' + lng + '&units=imperial&APPID=' + WEATHER_API_KEY)
    }

    _handleTextChange(event) {
        var zip = event.nativeEvent.text;
        this._getForecastForZip(zip);
    }


    componentWillMount() {
        AsyncStorage.getItem(STORAGE_KEY)
            .then((value) => {
                if (value !== null) {
                    this._getForecastForZip(value)
                }
            })
            .catch((error) => {
                console.log("读取失败")
            }).done()
    }

    render() {
        var content= null;
        if (this.state.forecast !== null) {
             content = <Forecast main={this.state.forecast.main}
                                    description={this.state.forecast.description}
                                    temp={this.state.forecast.temp} />
        }

        return (

            <View style={styles.container}>
                <Image source={require('./flowers.png')} style={{flex: 1,
                    resizeMode: 'cover',
                    width: screenWidth, height: screenHeight - 20}}>
                    <View style={styles.overlay}>
                        <View style={styles.row}>
                            <Text style={textStyles.mainText}>当前天气为:</Text>
                            <View style={styles.zipContainer}>
                                <TextInput style={[textStyles.mainText, {height: 16}]}
                                           returnKeyType='go'
                                           onSubmitEditing={this._handleTextChange}/>
                            </View>
                        </View>
                        <View style={styles.row}>
                            <LocationButton onGetCoords={this._getForecastForCoords}/>
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
    },
    overlay: {
        backgroundColor: 'black',
        opacity: 0.5,
        alignItems: 'center',
    },
    row: {
        flex: 1,
        flexDirection: 'row',
        flexWrap: 'nowrap',
        alignItems: 'center',
        justifyContent: 'center',
        padding: 20,
    },
    zipContainer: {
        flex: 1,
        borderBottomColor: 'white',
        borderBottomWidth: 1,
        marginLeft: 10,
        marginTop: 5,
    }
})
