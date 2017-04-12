import React, {Component} from 'react'
import {
    CameraRoll,
    Image,
    Text,
    View,
    ListView,
    StyleSheet,
    ActivityIndicator,
} from 'react-native'


export default class CameraRollView extends Component {
    static propTypes = {
        groupTypes: React.PropTypes.oneOf([
            'Album',
            'All',
            'Event',
            'Faces',
            'Library',
            'PhotoStream',
            'SavedPhotos'
        ]),
        batchSize: React.PropTypes.number,
        renderImage: React.PropTypes.func,
        imagesPerRow: React.PropTypes.number,
        assetType: React.PropTypes.oneOf([
            'Photos',
            'Videos',
            'All',
        ])
    }

    static defaultProps = {
        groupTypes: 'SavedPhotos',
        batchSize: 5,
        renderImage: (asset) => {
            var imageSize = 150;
            var imageStyle = [styles.image, {width: imageSize, height: imageSize}];
            return (
                <Image source={asset.node.image} style={imageStyle} />
            );
        },
        imagesPerRow: 1,
        assetType: 'Photos',
    }

    constructor(p) {
        super(p)
        this.state = {
            assets: [],
            groupTypes: this.props.groupTypes,
            lastCursor: null,
            assetType: this.props.assetType,
            noMore: false,
            loadingMore: false,
            dataSource: new ListView.DataSource({rowHasChanged:(r1, r2) => r1 !== r2})
        }
    }

    componentDidMount() {
        this.fetch()
    }

    componentWillReceiveProps(nextProps) {
        if (this.props.groupTypes !== nextProps.groupTypes) {
            this.fetch(true)
        }
    }

    rendererChanged() {
        var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2})
        this.state.dataSource = ds.cloneWithRows(this.state.assets)
    }

    _appendAssets(data) {
        var assets = data.edges;
        var newState = {loadingMore: false};
        if (!data.page_info.has_next_page) {
            newState.noMore = true;
        }
        if (assets.length > 0) {
            newState.lastCursor = data.page_info.end_cursor;
            newState.assets = this.state.assets.concat(assets);
            newState.dataSource = this.state.dataSource.cloneWithRows(newState.assets)
        }

        this.setState(newState);
    }

    _fetch(clear) {
        if (clear){
            this.setState({
                assets: [],
                groupTypes: this.props.groupTypes,
                lastCursor: null,
                assetType: this.props.assetType,
                noMore: false,
                loadingMore: false,
                dataSource: new ListView.DataSource({rowHasChanged:(r1, r2) => r1 !== r2})
            }, () => {this.fetch()})
            return;
        }

        var fetchParams = {
            first: this.props.batchSize,
            groupTypes: this.props.groupTypes,
            assetType: this.props.assetType,
        }

        if (this.state.lastCursor) {
            fetchParams.after = this.state.lastCursor;
        }

        CameraRoll.getPhotos(fetchParams).then((data) => {this._appendAssets(data)})

    }

    fetch(clear) {
        if (!this.state.loadingMore) {
            this.setState({loadingMore: true}, () => {this._fetch(clear)})
        }
    }

    _renderRow(rowData, sectionID, rowId) {
        var images = rowData.map((image) => {
            if (image === null) {
                return null;
            }
            return this.props.renderImage(image)
        })

        return (
            <View style={styles.row}>
                {images}
            </View>
        );
    }

    _renderFooter() {
        if (!this.state.noMore) {
            return (<ActivityIndicator color='green'/>)
        }
        return null;
    }

    _onEndReached() {
        if (!this.state.noMore) {
            this.fetch();
        }
    }


    render() {
        return(
            <ListView renderRow={(rowData, sectionID, rowID) => {this._renderRow(rowData, sectionID, rowID)}}
                      renderFooter={() => {this._renderFooter()}}
                      onEndReached={() => {this._onEndReached()}}
                      style={styles.container}
                      dataSource={this.state.dataSource}
            />
        );
    }
}


const styles = StyleSheet.create({
    row: {
        flexDirection: 'row',
        flex: 1,
    },

    url: {
        fontSize: 9,
        marginBottom: 14,
    },
    image: {
        margin: 4,
    },
    info: {
        flex: 1,
    },
    container: {
        flex: 1,
    }
})