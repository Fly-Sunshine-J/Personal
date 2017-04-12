import React, {Component} from 'react'
import {
    View,
    ListView,
    NavigatorIOS,
} from 'react-native'

import ListViewCell from './Cell'
import ActionSheetIOS from '../src/ActionSheetIOS'
import AdSupportIOS from '../src/AdSupportIOS'
import Alert from '../src/AlertIOS'
import Animated from '../src/Animated'
import AppState from '../src/AppState'
import AsyncStorage from '../src/AsyncStorage'
import CameraRoll from '../src/CameraRoll'
import Clipboard from '../src/Clipboard'
import Linking from '../src/Linking'
import NetInfo from '../src/NetInfo'
import PanResponder from '../src/PanResponder'
import PushNotificationIOS from '../src/PushNotificationIOS'

var data = ['ActionSheetIOS', 'AdSupportIOS', 'AlertIOS', 'Animated', 'AppState',
            'AsyncStorage', 'Clipboard', 'Linking', 'NetInfo', 'PanResponder', 'PushNotificationIOS']

export default class HomeView extends Component {
    render() {
        return (
            <NavigatorIOS initialRoute={{
                component: MyListView,
                title: '首页',
            }} style={{flex: 1}}/>
        );
    }
}

class MyListView extends Component {
    constructor(props) {
        super(props)
        this.state = {
            dataSource: new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2})
        }
    }

    componentWillMount() {
        this.setState({
            dataSource: this.state.dataSource.cloneWithRows(data)
        })
    }

    _jumpToPage(rowID) {
        console.log(rowID)
        switch (rowID) {
            case '0':{
                this.props.navigator.push({
                    component: ActionSheetIOS,
                    title: 'ActionSheetIOS'
                })
            }
            case '1': {
                this.props.navigator.push({
                    component: AdSupportIOS,
                    title: 'AdSupportIOS'
                })
            }
            case '2': {
                this.props.navigator.push({
                    component: Alert,
                    title: 'Alert'
                })
            }
            case '3': {
                this.props.navigator.push({
                    component: Animated,
                    title: 'Animated'
                })
            }
            case '4': {
                this.props.navigator.push({
                    component: AppState,
                    title: 'AppState'
                })
            }
            case '5': {
                this.props.navigator.push({
                    component: AsyncStorage,
                    title: 'AsyncStorage'
                })
            }
            // case '6': {
            //     this.props.navigator.push({
            //         component: CameraRoll,
            //         title: 'CameraRoll',
            //     })
            // }
            case '6': {
                this.props.navigator.push({
                    component: Clipboard,
                    title: 'Clipboard',
                })
            }
            case '7': {
                this.props.navigator.push({
                    component: Linking,
                    title: 'Linking',
                })
            }
            case '8': {
                this.props.navigator.push({
                    component: NetInfo,
                    title: 'NetInfo'
                })
            }
            case '9': {
                this.props.navigator.push({
                    component: PanResponder,
                    title: 'PanResponder',
                })
            }
            case '10': {
                this.props.navigator.push({
                    component: PushNotificationIOS,
                    title: 'PushNotificationIOS'
                })
            }
        }
    }

    render() {
        return (
            <ListView dataSource={this.state.dataSource}
                      renderRow={(rowData, sectionID, RowID) =>
                          <ListViewCell data={rowData} push={() => {this._jumpToPage(RowID)}}/>
                      }
            />
        )
    }
}