import React, {Component} from 'react'
import {
    WebView,
    ScrollView,
    Image,
    Text,
    View,
    StyleSheet,
} from 'react-native'

import Common from '../Common/Common'

export default class Detail extends Component {

    render() {

        return (
            <ScrollView style={{height: Common.screenHeight - 64 - 44}}>
                <Text style={styles.title}>{this.props.item.title}</Text>
                <Image style={styles.image} source={{uri: this.props.item.thumbnail + '.jpg'}}/>
                <WebView source={{html: this.props.item.content}} style={styles.webView}/>
            </ScrollView>
        );
    }
}

const styles = StyleSheet.create({
    webView: {
        marginTop: 30,
        marginLeft: 20,
        marginRight: 20,
        width: Common.screenWidth - 40,
        height: Common.screenWidth - 40,
    },
    title: {
        textAlign: 'center',
        marginTop: 30,
        fontSize: 18
    },
    image: {
        margin: 17,
        width: Common.screenWidth -34,
        height: Common.screenWidth - 34,
    }
})