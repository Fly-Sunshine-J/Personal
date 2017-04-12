import React, { Component } from 'react'
import {
    TouchableHighlight,
    Text,
    View,
    Image,
    StyleSheet,
} from 'react-native'

export default class Button extends Component {
    render(){
        return(
            <TouchableHighlight onPress={this.props.callback}>
                <View style={[this.props.style, styles.container]}>
                    <Image source={this.props.imageurl}/>
                    <Text>
                        {this.props.text}
                    </Text>
                </View>
            </TouchableHighlight>
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
