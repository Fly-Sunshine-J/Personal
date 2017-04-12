import React, { Component } from 'react'
import {
    ProgressViewIOS,
    View,
    StyleSheet,
} from 'react-native'


export default class ProgressViewIOSExample extends Component{
    constructor(props) {
        super(props)
        this.state = {
            progress : 0,
        }
    }

    timer: 0;

    render() {
       return (
           <View style={styles.container}>
               <ProgressViewIOS style={styles.progressView} progress={this._progress(0)}/>
               <ProgressViewIOS style={styles.progressView} progressTintColor='purple' progress={this._progress(0.2)}/>
               <ProgressViewIOS style={styles.progressView} progressTintColor='red' progress={this._progress(0.4)}/>
               <ProgressViewIOS style={styles.progressView} progressTintColor='orange' progress={this._progress(0.6)}/>
               <ProgressViewIOS style={styles.progressView} progressTintColor='yellow' progress={this._progress(0.8)}/>
           </View>
       );
    }

    componentDidMount() {
        this.timer = setInterval(() => {
            this.setState({progress: this.state.progress + 0.01})
        }, 10)
    }

    componentWillUnmount() {
        clearInterval(this.timer)
    }

    _progress(offset) {
        var progress = this.state.progress + offset;
        return Math.sin(progress % Math.PI) % 1;
    }
}

const styles = StyleSheet.create({
    container: {
        marginTop: 64,
        backgroundColor: 'transparent'
    },
    progressView: {
        marginTop: 20,
    }
})