import React, {Component, PropTypes} from 'react'
import {
    ListView,
    View,

} from 'react-native'

export default class MyListView extends Component {
    static PropTypes = {
        dataSource: PropTypes.array,
        renderRow: PropTypes.func,
    }

    static defaultProps = {
        dataSource: [],
    }

    constructor(props) {
        super(props)
        this.state = {
            dataSource: new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2}).cloneWithRows(this.props.dataSource)
        }
    }

    componentWillReceiveProps(nextProps) {
        this.setState({
            dataSource: this.state.dataSource.cloneWithRows(nextProps.dataSource)
        })
    }

    _renderSeparator = (sectionID, rowID, adjacentRowHighlighted) => {
        return (
            <View style={{height:1, backgroundColor: 'gray'}} key={'sectionID' + sectionID + 'rowID' + rowID}/>
        );
    }

    render() {
        return (
            <ListView dataSource={this.state.dataSource}
                      renderRow={this.props.renderRow}
                      renderSeparator={this._renderSeparator}
                      enableEmptySections={true}
                      renderHeader={this.props.renderHeader}
                      style={this.props.style}
                      refreshControl={this.props.refreshControl}
            />
        );
    }

}