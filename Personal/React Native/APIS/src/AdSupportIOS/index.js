import React, {Component} from 'react'
import {
    AdSupportIOS,
    View,
    Text,
} from 'react-native'


export default class AdSupportIOSExample extends Component {
    constructor(props) {
        super(props);
        this.state = {
            deviceID: 'No IDFA yet',
            hasAdvertiserTracking: 'unset'
        }
    }

    componentDidMount() {
        AdSupportIOS.getAdvertisingId(this._getAdvertisingIDOnSuccess, this._getAdvertisingIDOnFailure)

        AdSupportIOS.getAdvertisingTrackingEnabled(this._getAdvertisingTrackingEnabledOnSuccess, this._getAdvertisingTrackingEnabledOnFailure)
    }

    _getAdvertisingIDOnSuccess = (deviceId) => {
        this.setState({
            deviceID: deviceId
        })
    }

    _getAdvertisingIDOnFailure = (error) => {
        this.setState({
            deviceID: error,
        })
    }

    _getAdvertisingTrackingEnabledOnSuccess = (hasTracking) => {
        this.setState({
            hasAdvertiserTracking: hasTracking,
        })
    }

    _getAdvertisingTrackingEnabledOnFailure = (error) => {
        this.setState({
            hasAdvertiserTracking: error
        })
    }


    render() {
        return (
            <View style={{paddingTop: 64}}>
                <Text>Advertising ID: {JSON.stringify(this.state.deviceID)}</Text>
                <Text>Has Advertiser Tracking: {JSON.stringify(this.state.hasAdvertiserTracking)}</Text>
            </View>
        );
    }


}