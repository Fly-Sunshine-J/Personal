import React, { Component } from 'react'
import {
    View,
    Text,
    Navigator,
    TouchableHighlight,
    StyleSheet,
} from 'react-native'

export default class SimpleNavigatorApp extends Component {
    render() {
        return(
            <Navigator
            initialRoute={{title: 'My Initial Scence', index: 0}}
            renderScene={(route, navigator) => {
                return(
                    <MyScence title={route.title}
                              onForward={() => {
                                  const nextIndex = route.index + 1;
                                  navigator.push({
                                      title: 'Scene' + nextIndex,
                                      index: nextIndex,
                                  })
                              }}
                              onBack={() => {
                                  if (route.index > 0){
                                      navigator.pop();
                                  }
                              }}
                    />
                );
            }}
            />
        );
    }
}

class MyScence extends Component {
    render(){
        return(
            <View>
                <View style={styles.nagivator}>
                    <Text>
                        Current Scene: {this.props.title}.
                    </Text>
                </View>
                <TouchableHighlight onPress={this.props.onForward}>
                    <Text>
                        Tap me to load the next scece
                    </Text>
                </TouchableHighlight>
                <TouchableHighlight onPress={this.props.onBack}>
                    <Text>
                        Tap me to go to back
                    </Text>
                </TouchableHighlight>

            </View>
        );
    }
}

const styles = StyleSheet.create({
    nagivator:{
        height: 64,
        backgroundColor: 'red',
        justifyContent: 'center',
        alignItems: 'center',
    }
});

MyScence.defaultProps = {
    title: 'MyScence',
}