import React, {Component} from 'react'
import {
    AppState,
    Text,
    View,
} from 'react-native'


export default class AppStateSubscription extends Component {
    constructor(props) {
        super(props);
        this.state = {
            appState: AppState.currentState,
            previousAppStates: [],
            memoryWarnings: 0,
        }
    }

    componentDidMount() {
        AppState.addEventListener('change', this._handleAppStateChange);
        AppState.addEventListener('memoryWarning', this._handleMemoryWarning)
    }

    componentWillUnmount() {
        AppState.removeEventListener('change', this._handleAppStateChange);
        AppState.removeEventListener('memoryWarning', this._handleMemoryWarning)
    }

    _handleAppStateChange = (state) => {
        console.log(state)
        var previousAppStates = this.state.previousAppStates.slice();
        previousAppStates.push(state);
        this.setState({state, previousAppStates})
    }

    _handleMemoryWarning = () => {
        this.setState({
            memoryWarnings: this.state.memoryWarnings + 1,
        })
    }

    render() {
        return (
            <View style={{paddingTop: 64}}>
                <Text>memoryWarnings: {this.state.memoryWarnings}</Text>
                <Text>AppState:Current State: {this.state.appState}</Text>
                <Text>PreviousAppStates: {JSON.stringify(this.state.previousAppStates)}</Text>
            </View>
        );
    }
}
