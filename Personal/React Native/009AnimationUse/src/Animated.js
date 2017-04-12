import React, { Component } from 'react';
import {
    Animated,
    StyleSheet,
    Text,
    View,
    Image,
} from 'react-native';

export default class AnimatedUse extends Component {
    constructor(props) {
        super(props);
        this.state = {
            bounceValue: new Animated.Value(0),
        };
    }
    render() {
        return(
            <View style={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
                <Animated.Image source={require('../images/XMKOH81.jpg')}
                                style={{
                                    flex: 1,
                                    transform:[{scale: this.state.bounceValue}],
                                }}
                />
            </View>

        );
    }
    componentDidMount(){
        this.state.bounceValue.setValue(1.5);
        Animated.spring(this.state.bounceValue,
            {
                toValue: 0.8,
                friction: 1,
                tension: 40,
            }
        ).start(()=>{
            console.log("完成")
        });
    }
}
