import React, { Component } from 'react'
import {
    TouchableOpacity,
    Text,
    View,
    Image,
    StyleSheet,
} from 'react-native'

export default class Button extends Component {
    render(){
        return(
            <TouchableOpacity onPress={this.props.callback} activeOpacity={0.2} onLongPress={this.props.longPressCallback} delayLongPress={1000}>
                <View style={[this.props.style, styles.container]}>
                    <Image source={this.props.imageurl}/>
                    <Text>
                        {this.props.text}
                    </Text>
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
        flexDirection: 'row'
    },

});
