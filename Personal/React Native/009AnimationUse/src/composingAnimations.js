import React, { Component } from 'react';
import {
    View,
    Animated,
} from 'react-native';

export default class composingAnimationsUse extends Component {
    constructor(props) {
        super(props);
        this.state = {
            fadeAnim: new Animated.Value(0),
            position: new Animated.ValueXY(0, 0),
            twirl: new Animated.Value(0),
        }
    }

    render() {
        return(
            <Animated.Image source={require('../images/login_large_ic.png')}
                            style={
                                {
                                    position: 'absolute',
                                    top: this.state.position.y,
                                    left: this.state.position.x,
                                    width: 100,
                                    height: 100,
                                }
                            } />
        );
    }
    componentDidMount() {
        Animated.sequence([

            Animated.parallel([
                Animated.spring(
                    this.state.position,
                    {
                        toValue: {x: 200, y: 200}
                    }
                ),
                Animated.timing(
                    this.state.twirl,
                    {
                        toValue: 360,
                    }
                )
            ])
        ]).start()
    }
}