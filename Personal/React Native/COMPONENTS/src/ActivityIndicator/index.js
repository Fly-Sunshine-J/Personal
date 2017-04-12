import React, { Component } from 'react'
import {
    ActivityIndicator,
    View,
    ActivityIndicatorIOS,
    StyleSheet,
} from 'react-native'

export default class ActivityIndicatorUse extends Component {
    constructor(props) {
        super(props);
        this.state = {
            animation: false,
        }
    }

    timer = 0;

    componentDidMount() {
        this.timer = setInterval(() => {
            this.setState({
                animation: !this.state.animation,
            })
        }, 2000)
    }

    componentWillUnmount() {
        clearInterval(this.timer)
    }

    render() {
        return (
            <View style={styles.mainView}>
                < ActivityIndicator animating={this.state.animation}
                                    color='green'
                                    size='large'/>
                < ActivityIndicator animating={this.state.animation}
                                    color='purple'
                                    size='small'/>
                < ActivityIndicatorIOS animating={!this.state.animation}
                                    color='purple'
                                    size='small'/>
                < ActivityIndicatorIOS animating={!this.state.animation}
                                    color='purple'
                                    size='large'
                                       />

            </View>
        );
    }
}

const styles = StyleSheet.create({
    mainView: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'space-around'
    }
})