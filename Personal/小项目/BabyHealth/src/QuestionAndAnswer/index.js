import React, {Component} from 'react'
import {
    View,
    StyleSheet
} from 'react-native'

import Navigator from '../Common/Navigator'

import {ListViewCell} from '../Recipe'
import MyListView from '../Common/MyListView'
import Answers from '../Data/RecipeAnswers.json'
import QuestionAndAnswerDetial from './QuestionAndAnswerDetial'

class QuestionAndAnswerContainer extends Component {

    constructor(props) {
        super(props);
        this.state = {
            dataSource: [],
        }
    }

    componentDidMount() {
        this.setState({
            dataSource: Answers.section,
        })
    }

    _renderRow = (rowData, sectionID, rowID) => {
        return (
            <ListViewCell data={rowData} push={() => {this._push(rowData, rowID)}}/>
        );
    }

    _push = (rowData, rowID) => {
        this.props.navigator.push({
            title: '详情介绍',
            component: QuestionAndAnswerDetial,
            backButtonTitle: '返回',
            tintColor: 'white',
            passProps: {item: rowData.item}
        })
    }

    render() {
        return (
            <MyListView dataSource={this.state.dataSource} renderRow={this._renderRow}/>
        )
    }
}

export default class QuestionAndAnswer extends Component{

    render() {
        return (
            <Navigator title='营养问答'  component={QuestionAndAnswerContainer}/>
        )
    }
}