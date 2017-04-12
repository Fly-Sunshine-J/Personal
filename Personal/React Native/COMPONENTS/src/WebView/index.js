import React, {Component} from 'react'
import {
    StyleSheet,
    Text,
    TextInput,
    TouchableOpacity,
    TouchableWithoutFeedback,
    View,
    WebView,
    ScrollView,
} from 'react-native'

class Button extends Component {
    _handlePress = () => {
        if (this.props.enable !== false && this.props.onPress) {
            this.props.onPress();
        }
    }

    render() {
        return (
            <TouchableWithoutFeedback onPress={this._handlePress}>
                <View style={styles.button}>
                    <Text>{this.props.text}</Text>
                </View>
            </TouchableWithoutFeedback>
        );
    }
}

var HEADER = '#3b5998';
var BGWASH = 'rgba(255,255,255,0.8)';
var DISABLED_WASH = 'rgba(255,255,255,0.25)';

var TEXT_INPUT_REF = 'urlInput';
var WEBVIEW_REF = 'webview';
var DEFAULT_URL = 'https://facebook.github.io/react/';

class SimpleBrowser extends Component {
    constructor(props) {
        super(props)
        this.state = {
            url: DEFAULT_URL,
            status: 'NO Page Loaded',
            backButtonEnable: false,
            forwardButtonEnable: false,
            loading: true,
            scalesPageToFit: true,
        }
    }

    inputText = '';

    goBack() {
        this.refs[WEBVIEW_REF].goBack();
    }

    goForward() {
        this.refs[WEBVIEW_REF].goForward();
    }

    clickGoButton() {
        var url = this.inputText.toLowerCase();
        if (url === this.state.url) {
            this.refs[WEBVIEW_REF].reload();
        }else {
            this.setState({url: url})
        }
    }

    handleChange(event) {
        var text = event.nativeEvent.text;
        if (!/^[a-zA-Z-_] + :/.test(text)) {
            text = 'https://' + text;
        }
        this.inputText = text;
    }

    _onNavigationStateChange(newState) {
        console.log(newState)
        this.setState({
            backButtonEnable: newState.canGoBack,
            forwardButtonEnable: newState.canGoForward,
            url: newState.url,
            status: newState.title,
            loading: newState.loading,
            scalesPageToFit: true,
        })
    }

    render() {
        this.inputText = this.state.url;
        return (
            <View style={styles.container}>
                <View style={styles.addressBarRow}>
                    <TouchableOpacity onPress={() => {this.goBack()}}
                                      style={this.state.backButtonEnable ? styles.navButton : styles.disableButton}>
                        <Text>{'<'}</Text>
                    </TouchableOpacity>
                    <TouchableOpacity onPress={() => {this.goForward()}}
                                      style={this.state.backButtonEnable ? styles.navButton : styles.disableButton}>
                        <Text>{'>'}</Text>
                    </TouchableOpacity>
                    <TextInput ref={TEXT_INPUT_REF}
                               defaultValue={this.state.url}
                               onSubmitEditing={() => {this.clickGoButton()}}
                               onChange={(event) => {this.handleChange(event)}}
                               clearButtonMode='while-editing'
                               style={styles.addressBarTextInput}
                    />
                    <TouchableOpacity onPress={() => {this.clickGoButton()}}>
                        <View style={styles.goButton}>
                            <Text>GO!</Text>
                        </View>
                    </TouchableOpacity>
                </View>
                <WebView ref={WEBVIEW_REF}
                         source={{uri: this.state.url}}
                         automaticallyAdjustContentInsets={false}
                         style={styles.webView}
                         javaScriptEnabled={true}
                         domStorageEnabled={true}
                         decelerationRate='normal'
                         onNavigationStateChange={(newState) => {this._onNavigationStateChange(newState)}}
                         onShouldStartLoadWithRequest={(event) => {console.log('event' + event); return true}}
                         startInLoadingState={true}
                         scalesPageToFit={this.state.scalesPageToFit}
                />
                <View style={styles.statusBar}>
                    <Text style={styles.statusBarText}>{this.state.status}</Text>
                </View>
                <View style={styles.buttons}>
                    { this.state.scalingEnabled ?
                        <Button
                            text="Scaling:ON"
                            enabled={true}
                            onPress={() => this.setState({scalingEnabled: false})}
                        /> :
                        <Button
                            text="Scaling:OFF"
                            enabled={true}
                            onPress={() => this.setState({scalingEnabled: true})}
                        /> }
                </View>
            </View>
        );
    }
}
const HTML = `
<!DOCTYPE html>\n
<html>
  <head>
    <title>Hello Static World</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=320, user-scalable=no">
    <style type="text/css">
      body {
        margin: 0;
        padding: 0;
        font: 62.5% arial, sans-serif;
        background: #ccc;
      }
      h1 {
        padding: 45px;
        margin: 0;
        text-align: center;
        color: #33f;
      }
    </style>
  </head>
  <body>
    <h1>Hello Static World</h1>
  </body>
</html>
`;

class StaticWebView extends Component {
    render() {
        return (
            <WebView source={{html: HTML}}/>
        );
    }
}

export default class WebViewExample extends Component {
    render() {
        return (
            <ScrollView>
                <SimpleBrowser/>
                <StaticWebView/>
            </ScrollView>
        );
    }
}

const styles = StyleSheet.create({
    button: {
        flex: 0.5,
        width: 0,
        margin: 5,
        borderColor: 'gray',
        borderWidth: 1,
        backgroundColor: 'gray',
    },
    container: {
        flex: 1,
        backgroundColor: HEADER,
        paddingTop: 64
    },
    addressBarRow: {
        flexDirection: 'row',
        padding: 8,
    },
    webView: {
        backgroundColor: BGWASH,
        height: 350,
    },
    navButton: {
        width: 20,
        padding: 3,
        marginRight: 3,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: BGWASH,
        borderColor: 'transparent',
        borderRadius: 3,
    },
    disableButton: {
        width: 20,
        padding: 3,
        marginRight: 3,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: DISABLED_WASH,
        borderColor: 'transparent',
        borderRadius: 3,
    },
    addressBarTextInput: {
        backgroundColor: BGWASH,
        borderColor: 'transparent',
        borderRadius: 3,
        borderWidth: 1,
        height: 24,
        paddingLeft: 10,
        paddingTop: 3,
        paddingBottom: 3,
        flex: 1,
        fontSize: 14,
    },
    goButton: {
        height: 24,
        padding: 3,
        marginLeft: 8,
        alignItems: 'center',
        backgroundColor: BGWASH,
        borderColor: 'transparent',
        borderRadius: 3,
        alignSelf: 'stretch',
    },
    statusBar: {
        flexDirection: 'row',
        alignItems: 'center',
        paddingLeft: 5,
        height: 22,
    },
    statusBarText: {
        color: 'white',
        fontSize: 13,
    },
    buttons: {
        flexDirection: 'row',
        height: 30,
        backgroundColor: 'black',
        alignItems: 'center',
        justifyContent: 'space-between',
    },
})