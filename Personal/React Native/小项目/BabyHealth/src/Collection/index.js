import React, {Component, PropTypes} from 'react'
import {
    View,
    StyleSheet,
    Text,
    RefreshControl,
    DeviceEventEmitter,
} from 'react-native'

import Navigator from '../Common/Navigator'
import Realm from '../Data/realm'
import Model from '../Data/RecipeItemModel'
import MyListView from '../Common/MyListView'
import {ListViewCell} from '../Recipe/RecipeItem'
import Detail from '../Recipe/RecipeItemDetail'


class CollectionContainer extends Component{
    constructor(props) {
        super(props)
        this.state = {
            refresh: false,
            dataSource: [],
        }
    }

    componentWillMount() {
        DeviceEventEmitter.addListener('refresh', this._refresh)
        var arr = [];
        Realm.objects('Item').map((item) => {
            arr.push(Model.fromItem(item));
        })
        this.setState({dataSource: arr})
    }

    _renderRow = (rowData, sectionID, rowID) => {
        return (
            <ListViewCell data={rowData} push={() => this._push(rowData, rowID)} edit={true} delete={() => this._delete(rowData)}/>
        );
    }

    _delete = (rowData) => {
        Realm.write(() => {
            let item = Realm.objects('Item').filtered('id = $0', rowData.id);
            Realm.delete(item);
            this._refresh();
        })
    }

    _push = (rowData, rowID)=> {
        this.props.navigator.push({
            title: rowData.name,
            component: Detail,
            navigationBarHidden: true,
            passProps: {item: rowData, refreshListView:() => {this._refresh()}},
        })
    }
    
    _renderHeader = () => {
        return (
            <Text style={{marginTop: 30, marginLeft: 15, color: 'lightgray'}}>收藏</Text>
        );
    }

    _refresh = () => {
        this.setState({refresh: true})
        var arr = [];
        Realm.objects('Item').map((item) => {
            arr.push(Model.fromItem(item));
        })
        this.setState({dataSource: arr, refresh: false})
    }

    render() {
        return (
            <View style={styles.container}>
                <MyListView dataSource={this.state.dataSource}
                            renderRow={this._renderRow}
                            refreshControl={<RefreshControl refreshing={this.state.refresh} onRefresh={() => {this._refresh()}}/>}
                            renderHeader={this._renderHeader}/>
            </View>
        )
    }
}

export default class Collection extends Component{
    render() {
        return (
            <Navigator title='美味收藏' component={CollectionContainer}/>
        )
    }
}


const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'rgb(255, 250, 196)',
    },

})