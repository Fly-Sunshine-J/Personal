import React, {Component} from 'react'
import {
    TabBarIOS,
} from 'react-native'


import Recipe from './Recipe'
import QuestionAndAnswer from './QuestionAndAnswer'
import Collection from './Collection'
import More from './More'
import Navigator from './Common/Navigator'

const Item = TabBarIOS.Item;

export default class App extends Component {

    constructor(props) {
        super(props)
        this.state = {
            selectedTab: 'cook',
        }
    }

    render() {
        return (
            <TabBarIOS translucent={true}
                       barTintColor='rgb(246, 246, 246)'>
                <Item title='营养食谱'
                      icon={require('../images/cook@2x.png')}
                      selected={this.state.selectedTab === 'cook'}
                      onPress={() => {if(this.state.selectedTab !== 'cook') this.setState({selectedTab: 'cook'})}}
                      renderAsOriginal = {true}>
                    <Recipe/>
                </Item>
                <Item title='营养问答'
                      icon={require('../images/face@2x.png')}
                      selected={this.state.selectedTab === 'face'}
                      onPress={() => {if(this.state.selectedTab !== 'face') this.setState({selectedTab: 'face'})}}
                      renderAsOriginal = {true}>
                    <QuestionAndAnswer/>
                </Item>
                <Item title='美味收藏'
                      icon={require('../images/love@2x.png')}
                      selected={this.state.selectedTab === 'love'}
                      onPress={() => {if(this.state.selectedTab !== 'love') this.setState({selectedTab: 'love'})}}
                      renderAsOriginal = {true}>
                    <Collection />
                </Item>
                <Item title='更多'
                      icon={require('../images/slim@2x.png')}
                      selected={this.state.selectedTab === 'more'}
                      onPress={() => {if(this.state.selectedTab !== 'more') this.setState({selectedTab: 'more'})}}
                      renderAsOriginal = {true}>
                    <More/>
                </Item>
            </TabBarIOS>
        );
    }
}