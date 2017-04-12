import React, { Component } from 'react'
import {
    View,
    Image,
    TouchableWithoutFeedback,
    StyleSheet,
} from 'react-native';
import rebound from 'rebound'

export default class ReboundUse extends Component {
    constructor(props) {
        super(props);
        this.state = {
            scale: 1,
        }
    }

    componentWillMount() {
        this.springSystem = new rebound.SpringSystem();
        this._scrollSpring = this.springSystem.createSpring();
        var springConfig = this._scrollSpring.getSpringConfig();
        springConfig.tension = 230;
        springConfig.friction = 10;

        this._scrollSpring.addListener({
            onSpringUpdate: () => {
                // this.setState({
                //     scale: this._scrollSpring.getCurrentValue(),
                // })
                if (!this._photo) { return }
                var v = this._scrollSpring.getCurrentValue();
                var newProps = {style: {transform: [{scaleX: v},{scaleY: v}]}};
                this._photo.setNativeProps(newProps);
            }
        });
        this._scrollSpring.setCurrentValue(1);
    }

    _onPressIn() {
        this._scrollSpring.setCurrentValue(0.5);
    }

    _onPressOut() {
        this._scrollSpring.setCurrentValue(1);
    }

    render() {
        return(
            <View style={styles.container}>
                <TouchableWithoutFeedback
                    onPressIn={() => this._onPressIn()}
                    onPressOut={() => this._onPressOut()}
                >
                    <Image source={require('../images/XMKOH81.jpg')} style={{
                        width: 300,
                        height: 300,
                    }} ref={(Image) => {this._photo = Image}} />
                </TouchableWithoutFeedback>
            </View>
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

});