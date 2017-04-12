import React, { Component, PropTypes } from 'react'
import styles from '../styles'
import Button from '../Button'

export default class LocationButtton extends Component {
    static propTypes = {
        onGetCoords: React.PropTypes.func.isRequired,
    }

    _onPress() {
        navigator.geolocation.getCurrentPosition((position) => {this.props.onGetCoords(position.coords.latitude, position.coords.longitude)},
            (error) => {console.log(error)},
            {enableHighAccuracy: true, timeout: 20000, maximumAge: 1000}
        )
    }

    render() {
        return (
            <Button onPress={() => this._onPress()} style={styles.buttonStyle} label='定位'/>
        )
    }
}