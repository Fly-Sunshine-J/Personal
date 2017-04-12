import React, { Component } from 'react';
import {
    View,
    Text,
    TouchableOpacity,
    LayoutAnimation,
    StyleSheet,
} from 'react-native';

export default class LayoutAnimationUse extends Component {
    constructor(props) {
        super(props);
        this.state = {
            w: 100,
            h: 100,
        }
    }

    componentWillMount() {
        LayoutAnimation.spring();
    }

    _onPress() {
        LayoutAnimation.spring();
        this.setState({
            w: this.state.w + 15,
            h: this.state.h + 15,
        })
    }

    recovery() {
        LayoutAnimation.spring();
        this.setState({
            w: 100,
            h: 100,
        })
    }

    render() {
        return(
            <TouchableOpacity activeOpacity={1} onPress={()=> this.recovery()} style={styles.container}>
                <View style={styles.container}>
                    <View style={[styles.box, {width: this.state.w, height:this.state.h}]}></View>
                    <TouchableOpacity onPress={()=>this._onPress()}>
                        <View style={styles.button}>
                            <Text style={styles.buttonText}>Press me!</Text>
                        </View>
                    </TouchableOpacity>
                </View>
            </TouchableOpacity>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
    box: {
        marginBottom: 10,
        backgroundColor: 'red'
    },
    button: {
        backgroundColor: 'black',
        width: 80,
        height: 40,
        justifyContent: 'center',
        alignItems: 'center'
    },
    buttonText: {
        fontSize: 18,
        color: 'white',
    }
});