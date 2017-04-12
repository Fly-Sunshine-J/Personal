/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image,
  TextInput,
  ScrollView,
  ListView,
} from 'react-native';


var screenWidth = require('Dimensions').get('window').width
var screenHeight = require('Dimensions').get('window').height


class Greeting extends Component {
  render(){
    return(
      <Text>Hello {this.props.name} </Text>
      );
  }
}

class Blink extends Component {
  constructor(props) {
    super(props);
  
    this.state = { showText: true };

    setInterval(() => {
      this.setState({showText: !this.state.showText});
    }, 1000);
  }

  render(){
    let display = this.state.showText ? this.props.text : '';
    return(

        <Text> {display} </Text>
      );
  }
}


class PizzaTranslator extends Component {
  constructor(props) {
    super(props);
  
    this.state = {text: ''};
  }

  render() {
    return(
      <View style={{width: screenWidth}}>
        <TextInput style={{height: 40}} 
                placeholder="Type here to Translate"
                onChangeText={(text)=>this.setState({text})} 
        />

        <Text style={{padding: 10, fontSize: 40}}>
          {this.state.text.split(' ').map((word)=> word && '🍕').join(' ')}
        </Text>
     </View>
    );
  }
}


class ScrollViewUse extends Component {
  render(){
    return(
        <ScrollView>
          <Greeting name='jhon' />
          <Greeting name='jhon' />
          <Blink text='LOVE' />
          <PizzaTranslator />
          <Image source={require('./images/ic_qq_login_normal.png')} />
          <Image source={require('./images/ic_weixin_login_normal.png')} />
        </ScrollView>
      );
  }
}


class ListViewUse extends Component {
  constructor(props) {
    super(props);
    const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 != r2});
    this.state = {
      dataSource: ds.cloneWithRows(['Jhon', 'Joel', 'James', 'Jimmy', 'Devin'])
    };
  }

  render(){
    return(
        <View>
          <ListView dataSource={this.state.dataSource}
                    renderRow={(rowData) => <Text>{rowData}</Text>}
          />
        </View>
      );
  }
}

class Login extends Component {
  render() {
    return (
      <View style={styles.container}>
      
      <ListViewUse />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'rgb(250, 250, 250)',
    alignItems: 'center',
    justifyContent: 'center',
  },
});

AppRegistry.registerComponent('Login', () => Login);

