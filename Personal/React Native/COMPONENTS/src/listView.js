import React, { Component } from 'react'
import {
    ListView,
    NavigatorIOS,
} from 'react-native'

import Model from './data/model'
import ListViewCell from './listViewCell'
import ActivityIndicator from './ActivityIndicator'
import DatePickerIOS from './DatePickerIOS'
import MapView from './MapView'
import Modal from  './Modal'
import Picker from './Picker'
import PickerIOS from './PickerIOS'
import ProgressViewIOS from './ProgressViewIOS'
import RefreshControl from './RefreshControl'
import SegmentedControlIOS from './SegmentedControllOS'
import Slider from './Slider'
import StatusBar from './StatusBar'
import Switch from './Switch'
import TabBarIOS from './TabBarIOS'
import WebView from './WebView'

var data = [
    {name: 'ActivityIndicator', imageSource: require('../images/circular.png')},
    {name: 'DatePickerIOS', imageSource: require('../images/date.png')},
    {name: 'MapView', imageSource: require('../images/map.png')},
    {name: 'Modal', imageSource: require('../images/modal.png')},
    {name: 'Picker', imageSource: require('../images/picker.png')},
    {name: 'PickerIOS', imageSource: require('../images/pickerIOS.png')},
    {name: 'ProgressViewIOS', imageSource: require('../images/progress.png')},
    {name: 'RefreshControl', imageSource: require('../images/refresh.png')},
    {name: 'SegmentedControlIOS', imageSource: require('../images/segment.png')},
    {name: 'Slider', imageSource: require('../images/slider.png')},
    {name: 'StatusBar', imageSource: require('../images/status.png')},
    {name: 'Switch', imageSource: require('../images/switch.png')},
    {name: 'TabBarIOS', imageSource: require('../images/tabbar.png')},
    {name: 'WebView', imageSource: require('../images/webView.png')},
];

export default class HomeView extends Component {
    render() {
        return (
            <NavigatorIOS initialRoute={{
                component: MyListView,
                title: '首页'
            }} style={{flex: 1}}/>
        );
    }
}

class MyListView extends Component {
    constructor(props) {
        super(props);
        const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
        this.state = {
            dataSource: ds,
        }
    }

    componentWillMount() {
        var dataSource = Array();
        data.map((ob) => {
            dataSource.push(Model.fromObject(ob));
        })
        this.setState({
            dataSource: this.state.dataSource.cloneWithRows(dataSource)
        })
    }

    _jumpToPage(rowID) {
        console.log(rowID.rowID);
        switch (rowID.rowID) {
            case '0': {
                this.props.navigator.push({
                    title: 'ActivityIndicator',
                    component: ActivityIndicator,
                });
                break;
            }
            case '1': {
                this.props.navigator.push({
                    title: 'DatePickerIOS',
                    component: DatePickerIOS,
                });
                break;
            }
            case '2': {
                this.props.navigator.push({
                    title: 'MapView',
                    component: MapView,
                });
                break;
            }
            case '3': {
                this.props.navigator.push({
                    title: 'Modal',
                    component: Modal,
                })
                break;
            }
            case '4': {
                this.props.navigator.push({
                    title: 'Picker',
                    component: Picker,
                })
            }
            case '5': {
                this.props.navigator.push({
                    title: 'PickerIOS',
                    component: PickerIOS,
                })
            }
            case '6': {
                this.props.navigator.push({
                    title: 'ProgressViewIOS',
                    component: ProgressViewIOS,
                })
            }
            case '7': {
                this.props.navigator.push({
                    title: 'RefreshControl',
                    component: RefreshControl,
                })
            }
            case '8': {
                this.props.navigator.push({
                    title: 'SegmentedControlIOS',
                    component: SegmentedControlIOS
                })
            }
            case '9': {
                this.props.navigator.push({
                    title: 'Slider',
                    component: Slider,
                })
            }
            case '10': {
                this.props.navigator.push({
                    title: 'StatusBar',
                    component: StatusBar,
                })
            }
            case '11': {
                this.props.navigator.push({
                    title: 'Switch',
                    component: Switch,
                })
            }
            case '12': {
                this.props.navigator.push({
                    title: 'TabBarIOS',
                    component: TabBarIOS,
                })
            }
            case '13': {
                this.props.navigator.push({
                    title: 'WebView',
                    component: WebView,
                })
            }
        }

    }

    render() {
        return (
            <ListView dataSource={this.state.dataSource}
                      renderRow={(rowData, sectionID, rowID,) => <ListViewCell data={rowData} push={() => this._jumpToPage({rowID})}/>}/>
        );
    }
}


