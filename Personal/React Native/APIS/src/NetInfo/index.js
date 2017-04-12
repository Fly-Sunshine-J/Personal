import React, {Component} from 'react'
import {
    NetInfo,
    Text,
    View,
    TouchableWithoutFeedback,
} from 'react-native'


class ConnectionInfoSubscription extends Component {
    constructor(props) {
        super(props)
        this.state = {
            connectionInfoHistory: [],
        }
    }

    _handleConnectionInfoChange = (connectionInfo) => {
        const infoHistory = this.state.connectionInfoHistory;
        infoHistory.push(connectionInfo);
        this.setState({infoHistory})
    }

    componentWillMount() {
        NetInfo.addEventListener('change', this._handleConnectionInfoChange)
    }

    componentWillUnmount() {
        NetInfo.removeEventListener('change', this._handleConnectionInfoChange)
    }

    render() {
        return(
            <View>
                <Text>{JSON.stringify(this.state.connectionInfoHistory)}</Text>
            </View>
        )
    }
}


class ConnectionInfoCurrent extends Component {
    constructor(props) {
        super(props)
        this.state = {
            connectionInfo: null,
        }
    }

    _handleConnectionInfoChange = (connectionInfo) => {

        this.setState({connectionInfo})
    }

    componentWillMount() {
        NetInfo.addEventListener('change', this._handleConnectionInfoChange)
    }

    componentWillUnmount() {
        NetInfo.removeEventListener('change', this._handleConnectionInfoChange)
    }

    render() {
        return(
            <View>
                <Text>{this.state.connectionInfo}</Text>
            </View>
        )
    }
}


class IsConnected extends Component {
    constructor(props) {
        super(props)
        this.state = {
            isConnected: null,
        }
    }

    _handleConnectionInfoChange = (isConnected) => {

        this.setState({isConnected})
    }

    componentWillMount() {
        NetInfo.isConnected.addEventListener('change', this._handleConnectionInfoChange)
        NetInfo.isConnected.fetch().done((isConnected) => {this.setState({isConnected})})
    }

    componentWillUnmount() {
        NetInfo.isConnected.removeEventListener('change', this._handleConnectionInfoChange)
    }

    render() {
        return(
            <View>
                <Text>{this.state.isConnected ? 'Online' : 'Offline'}</Text>
            </View>
        )
    }
}

export default class NetInfoExample extends Component {
    render() {
        return (
            <View style={{paddingTop: 64}}>
                <ConnectionInfoSubscription/>
                <ConnectionInfoCurrent/>
                <IsConnected/>
            </View>
        );
    }
}