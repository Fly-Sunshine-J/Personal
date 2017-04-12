import React, {Component} from 'react'
import {
    View,
    Text,
    TouchableOpacity,
    Image,
    WebView,
    StyleSheet,
} from 'react-native'

import Navigator from '../Common/Navigator'
import MyListView from '../Common/MyListView'
import MoreSection from '../Data/MoreSection.json'
import Common from '../Common/Common'

class ListViewCell extends Component {
    static PropTypes = {
        data: React.PropTypes.object,
        push: React.PropTypes.func,
    }

    render() {
        return(
            <TouchableOpacity onPress={this.props.push}>
                <View style={{height: 90, flexDirection: 'row', alignItems: 'center'}}>
                    <Image style={{height: 60, width: 60, marginLeft: 20, marginRight: 20, borderRadius: 30}} source={{uri: this.props.data.url}}/>
                    <Text style={{color: 'rgb(241, 82, 116)', fontSize: 16, width: Common.screenWidth - 120}}>{this.props.data.name}</Text>
                </View>
            </TouchableOpacity>
        )
    }
}

class MoreContainer extends Component{

    constructor(props) {
        super(props);
        this.state = {
            dataSource: [],
        }
    }

    componentDidMount() {
        this.setState({dataSource: MoreSection.section})
    }

    _push(rowData) {
        this.props.navigator.push({
            title: "详情",
            component: DetialWebView,
            passProps: {url: rowData.linkUrl},
        })
    }

    render() {
        return (
            <View style={styles.container}>
                <MyListView dataSource={this.state.dataSource}
                            renderHeader={() => {return <Text style={{marginTop: 30, marginLeft: 15, color: 'lightgray'}}>更多</Text>}}
                            renderRow={(rowData) => {return <ListViewCell data={rowData} push={() => {this._push(rowData)}}/>}}/>
            </View>
        )
    }
}


class DetialWebView extends Component {

    static PropTypes = {
        url: React.PropTypes.string
    }

    render() {
        return(
            <WebView style={{flex: 1}} source={{uri: this.props.url}}/>
        )
    }
}


export default class More extends Component{

    render() {
        return (
            <Navigator title='更多' component={MoreContainer}/>
        )
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'rgb(255, 250, 196)',
    }
})
