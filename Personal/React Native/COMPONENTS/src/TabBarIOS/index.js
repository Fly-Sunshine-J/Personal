import React, {Component} from 'react'
import {
    View,
    TabBarIOS,
    Text,
    StyleSheet,
} from 'react-native'

export default class TabBarIOSExample extends Component {
    constructor(props) {
        super(props)
        this.state = {
            selectedTab: 'video',
            notifCount: 0,
            presses: 0,
        }
    }

    _renderContent = (color, pageText, num) => {
        return (
            <View style={[styles.tabContent, {backgroundColor: color}]}>
                <Text style={styles.tabText}>{pageText}</Text>
                <Text style={styles.tabText}>{num} re-renders of the {pageText}</Text>
            </View>
        );
    }

    render() {
        return(
            <TabBarIOS unselectedTintColor='yellow'
                       tintColor='red'
                       barTintColor='darkslateblue'
                       translucent={true}>
                <TabBarIOS.Item title="Video"
                                icon={require('../../images/tabbar_video@2x.png')}
                                selected = {this.state.selectedTab === 'video'}
                                selectedIcon={require('../../images/tabbar_video_hl@2x.png')}
                                onPress={() => {if (this.state.selectedTab !== 'video'){this.setState({selectedTab: 'video'})}}}
                                renderAsOriginal = {true}>
                    {this._renderContent('#414A8C', 'Video')}
                </TabBarIOS.Item>
                <TabBarIOS.Item title="News"
                                badge={this.state.notifCount > 0 ? this.state.notifCount : undefined}
                                icon={require('../../images/tabbar_news@2x.png')}
                                selected={this.state.selectedTab === 'news'}
                                selectedIcon={require('../../images/tabbar_news_hl@2x.png')}
                                onPress={() => {if (this.state.selectedTab !== 'news'){this.setState({selectedTab: 'news', notifCount: this.state.notifCount + 1})}}}
                                renderAsOriginal={true}>
                    {this._renderContent('#783E33', 'News', this.state.notifCount)}
                </TabBarIOS.Item>
                <TabBarIOS.Item title="picture"
                                icon={require('../../images/tabbar_picture@2x.png')}
                                selected={this.state.selectedTab === 'picture'}
                                selectedIcon={require('../../images/tabbar_picture_hl@2x.png')}
                                onPress={() => {if(this.state.selectedTab !== 'picture'){this.setState({selectedTab: 'picture', presses: this.state.presses + 1})}}}
                                renderAsOriginal={true}>
                    {this._renderContent('#21551C', 'Picture', this.state.presses)}
                </TabBarIOS.Item>
            </TabBarIOS>
        );
    }
}


const styles = StyleSheet.create({
    tabContent: {
        flex: 1,
        alignItems: 'center',
    },
    tabText: {
        color: 'white',
        margin: 50,
    },
})