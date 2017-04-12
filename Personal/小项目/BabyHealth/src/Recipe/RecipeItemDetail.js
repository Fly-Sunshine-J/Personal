import React, {Component} from 'react'
import {
    Image,
    Text,
    View,
    ScrollView,
    TouchableOpacity,
    StyleSheet,
    DeviceEventEmitter
} from 'react-native'

import realm from '../Data/realm'
import Common from '../Common/Common'

const screenWidth = Common.screenWidth;


export default class Detail extends Component {

    constructor(props) {
        super(props)

        this.state = {
            collected: false,
        }
    }

    componentWillMount() {
        if (this._selected() !== undefined) {
            this.setState({collected: true});
        }
    }

    _selected() {
        let item = realm.objects('Item').filtered('id == $0', this.props.item.id);
        return item[0]
    }

    _collected(item) {
        if (!this.state.collected) {
            realm.write(() => {
                realm.create('Item',
                    {
                        id: item.id, prompt: item.prompt, symptoms: item.symptoms, ingredients: item.ingredients,
                        lock: item.lock, month: item.month, practice: item.practice, name: item.name
                    })
            })
        }else {
            realm.write(() => {
                realm.delete(this._selected());
            })
        }
        DeviceEventEmitter.emit('refresh', {true})
        this.setState({collected: !this.state.collected});

    }

    _pop() {
        this.props.navigator.pop();
        if (this.props.refreshListView) {
            this.props.refreshListView();
        }
    }

    render() {
        return (
            <View style={{flex: 1}}>

                <View style={{height: 64, backgroundColor: 'rgb(241, 82, 116)'}}>
                    <View style={{marginTop: 20, height: 44, flexDirection: 'row', alignItems: 'center'}}>
                        <View style={{flex: 1}}>
                            <TouchableOpacity onPress={() => {this._pop()}}
                                              style={{alignItems: 'center', flexDirection: 'row'}}>
                                <Image style={{marginLeft: 10, marginRight: 5, width: 17, height: 25}} source={require('../../images/arrow.png')}/>
                                <Text style={{fontSize: 18, color: 'white'}}>返回</Text>
                            </TouchableOpacity>
                        </View>
                        <View style={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
                            <Text style={{color: 'white', fontSize: 18, fontWeight: '500', textAlign: 'center'}}>{this.props.item.name}</Text>
                        </View>
                        <View style={{flex: 1, alignItems:'center'}}>
                            <TouchableOpacity style={{alignItems:'center', alignSelf: 'flex-end', flexDirection: 'row'}} onPress={() => {this._collected(this.props.item)}}>
                                <Text style={{fontSize: 18, color: 'white'}}>{this.state.collected ? '取消收藏' : '收藏'}</Text>
                                <Image style={{marginRight: 10, width: 30, height: 30}} source={{uri: this.state.collected ? 'has_collect' : 'no_collect'}}/>
                            </TouchableOpacity>
                        </View>
                    </View>
                </View>
                <ScrollView>
                    <Image style={{width: screenWidth - 40, height: screenWidth -40, left: 20}} source={{uri: this.props.item.id + '.jpg'}}/>
                    <Text style={styles.text}>{'[针对症状]: ' + this.props.item.symptoms}</Text>
                    <Text style={styles.text}>{'[适合宝宝]: ' + this.props.item.month}</Text>
                    <Text style={styles.text}>{'做法:'}</Text>
                    <Text style={{marginLeft: 40}}>{this.props.item.practice}</Text>
                    <Text style={styles.text}>{'特点'}</Text>
                    <Text style={{marginLeft: 40}}>{this.props.item.prompt}</Text>
                </ScrollView>

            </View>
        );
    }

}

const styles = StyleSheet.create({
    text: {
        marginLeft: 30,
        marginTop: 20
    }
})